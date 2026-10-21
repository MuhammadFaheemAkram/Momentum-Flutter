import 'dart:convert';

import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

/// How many days ahead the plan reaches.
const notificationHorizonDays = 7;

/// The most notifications planned at once. iOS keeps only the 64 soonest
/// pending notifications per app and silently drops the rest; 60 leaves a
/// margin.
const maxPlannedNotifications = 60;

/// Every notification the app wants on the device from [now] on, soonest
/// first: what `SyncNotificationsUseCase` makes the device match.
///
/// **A rolling window, not repeating notifications.** A repeating "daily at
/// 07:00" can't skip a day the habit is already done, can't follow a
/// Mon / Wed / Fri schedule or a weekly target, and can't say how many
/// habits are left. So the plan lists each day's notifications one by one,
/// for [horizonDays] days, and is planned again after every change (and at
/// launch, on resume, at midnight, and in the background), so it keeps
/// rolling forward.
///
/// Each day, for the habits it asks for (not done, not skipped):
/// - a **reminder** at each one's own time;
/// - the **nudge** at the nudge time, while any is open;
/// - the **summary** at the summary time, on any day something is due.
///
/// A day ahead is planned as it will be if nothing else changes (nothing
/// done yet); any change plans again. Times already past are dropped, and
/// at most [limit] are kept.
List<PlannedNotification> planNotifications({
  required DateTime now,
  required Iterable<HabitHistory> histories,
  required AppSettings settings,
  int horizonDays = notificationHorizonDays,
  int limit = maxPlannedNotifications,
}) {
  final active = [
    for (final history in histories)
      if (history.habit.archivedAt == null) history,
  ];
  final today = CalendarDate.fromDateTime(now);
  final plan = <PlannedNotification>[];
  for (var offset = 0; offset < horizonDays; offset++) {
    final day = today.addDays(offset);
    final asked = [
      for (final history in active)
        if (history.isDue(day) && !history.isSkippedOn(day)) history,
    ];
    final open = [
      for (final history in asked)
        if (!history.isDoneOn(day)) history,
    ];
    plan.addAll(remindersOn(open, day));
    if (settings.nudgeEnabled && open.isNotEmpty) {
      plan.add(
        _planned(
          NotificationKind.nudge,
          day,
          settings.nudgeTime,
          title: open.length == 1
              ? '1 habit left today'
              : '${open.length} habits left today',
          body: _titles(open),
          target: const NotificationTarget.today(),
        ),
      );
    }
    if (settings.summaryEnabled && asked.isNotEmpty) {
      final done = asked.length - open.length;
      final perfect = perfectDayStreak(active, today: day);
      plan.add(
        _planned(
          NotificationKind.summary,
          day,
          settings.summaryTime,
          title: 'Your day',
          body: [
            '$done of ${asked.length} done today',
            if (perfect == 1) '1 perfect day',
            if (perfect > 1) '$perfect perfect days',
          ].join(', '),
          target: const NotificationTarget.today(),
        ),
      );
    }
  }
  final upcoming = plan.where((n) => n.at.isAfter(now)).toList()
    ..sort(_soonestFirst);
  return _uniqueIds(upcoming.take(limit));
}

/// The reminders on [day] for [open]: the habits it asks for and that
/// aren't done yet, in time order. Today shows today's.
List<PlannedNotification> remindersOn(
  Iterable<HabitHistory> open,
  CalendarDate day,
) {
  final reminders = [
    for (final history in open)
      if (history.habit.reminder case final time?)
        _planned(
          NotificationKind.reminder,
          day,
          time,
          title: history.habit.title,
          body: _reminderBody(history, day),
          target: NotificationTarget.habit(history.habit.id),
          habitId: history.habit.id,
        ),
  ];
  return reminders..sort(_soonestFirst);
}

/// A stable id for [kind] on [day] (for [habitId]'s reminder): the same in
/// every plan, so an unchanged notification is recognised and left alone.
///
/// The 32-bit FNV-1a hash of the three, kept positive: Android's
/// notification ids are 32-bit signed integers.
int notificationId(NotificationKind kind, CalendarDate day, {String? habitId}) {
  var hash = 0x811c9dc5;
  for (final byte in utf8.encode(
    '${kind.name}|${habitId ?? ''}|${day.yyyymmdd}',
  )) {
    hash = ((hash ^ byte) * 0x01000193) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}

PlannedNotification _planned(
  NotificationKind kind,
  CalendarDate day,
  TimeOfDayValue time, {
  required String title,
  required String body,
  required NotificationTarget target,
  String? habitId,
}) => PlannedNotification(
  id: notificationId(kind, day, habitId: habitId),
  kind: kind,
  day: day,
  time: time,
  title: title,
  body: body,
  target: target,
  habitId: habitId,
);

String _reminderBody(HabitHistory history, CalendarDate day) {
  final habit = history.habit;
  if (habit.dailyTarget > 1) {
    final count = history.logOn(day)?.count ?? 0;
    return '$count of ${habit.dailyTarget} so far today';
  }
  return habit.description.isEmpty ? 'Due today' : habit.description;
}

/// "Read 20 pages, Plan tomorrow and 2 more".
String _titles(List<HabitHistory> habits) {
  const shown = 3;
  final titles = [for (final h in habits.take(shown)) h.habit.title];
  final more = habits.length - shown;
  return more > 0 ? '${titles.join(', ')} and $more more' : titles.join(', ');
}

/// By time; at the same minute, reminders before the nudge before the
/// summary, then by habit, so the order (and so the ids) never depend on
/// the input's order.
int _soonestFirst(PlannedNotification a, PlannedNotification b) {
  final byTime = a.at.compareTo(b.at);
  if (byTime != 0) return byTime;
  final byKind = a.kind.index.compareTo(b.kind.index);
  if (byKind != 0) return byKind;
  return (a.habitId ?? '').compareTo(b.habitId ?? '');
}

/// Two different notifications with the same hash would replace each other
/// on the device: the later one moves to the next free id.
List<PlannedNotification> _uniqueIds(Iterable<PlannedNotification> plan) {
  final used = <int>{};
  return [
    for (final notification in plan)
      () {
        var id = notification.id;
        while (!used.add(id)) {
          id = (id + 1) & 0x7fffffff;
        }
        return notification.copyWith(id: id);
      }(),
  ];
}
