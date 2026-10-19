import 'dart:math' as math;

import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';

/// What a day looks like for one habit.
enum DayState {
  /// The day's target was reached.
  done,

  /// Some check-ins, below the day's target.
  partial,

  /// Skipped on purpose: neither done nor missed.
  skipped,

  /// Due, over, and not done: it breaks a streak. Only habits with fixed
  /// days miss a day; a weekly habit is judged by its week.
  missed,

  /// Due today, not done yet. Not a miss until the day is over.
  open,

  /// Nothing asked of the habit that day: not due, not started yet,
  /// archived, or a weekly habit's day off.
  none,

  /// Still to come.
  future,
}

/// One habit and its logs, with the questions the engine asks about a day.
///
/// Everything here is derived from the logs when it is asked, never stored:
/// a streak or a rate can't disagree with the history, and editing the
/// schedule or the daily target re-derives them all.
class HabitHistory {
  HabitHistory(this.habit, Iterable<HabitLog> logs)
    : _logs = {
        for (final log in logs)
          if (log.habitId == habit.id) log.day: log,
      };

  final Habit habit;
  final Map<CalendarDate, HabitLog> _logs;

  Iterable<HabitLog> get logs => _logs.values;

  HabitLog? logOn(CalendarDate day) => _logs[day];

  /// The day the habit was archived, in the user's calendar.
  CalendarDate? get archivedOn => switch (habit.archivedAt) {
    final at? => CalendarDate.fromDateTime(at.toLocal()),
    null => null,
  };

  /// Whether the habit exists on [day]: from its start date, and before the
  /// day it was archived. An archived habit keeps its history, but is never
  /// due again.
  bool isActiveOn(CalendarDate day) {
    final archived = archivedOn;
    return day >= habit.startDate && (archived == null || day < archived);
  }

  /// Done: at least the daily target, and not a skip.
  bool isDoneOn(CalendarDate day) {
    final log = _logs[day];
    return log != null && !log.skipped && log.count >= habit.dailyTarget;
  }

  bool isSkippedOn(CalendarDate day) => _logs[day]?.skipped ?? false;

  /// Whether the habit asks to be done on [day].
  ///
  /// - **Daily:** every day.
  /// - **On weekdays:** on its days.
  /// - **Times per week:** every day of the ISO week until the week's slots
  ///   are used. A done day and a skipped day each use one, so a habit done
  ///   three times by Wednesday isn't due on Thursday.
  bool isDue(CalendarDate day) {
    if (!isActiveOn(day)) return false;
    return switch (habit.schedule) {
      Daily() => true,
      OnWeekdays(:final weekdays) => weekdays.contains(day.weekday),
      TimesPerWeek() =>
        _slotsUsed(day.weekStart, before: day) < weekSlots(day.weekStart),
    };
  }

  /// A weekly habit's slots in the week starting [weekStart]: its times a
  /// week, or fewer in a week it starts or ends part-way through (a 5× habit
  /// started on a Friday can't be done five times that week).
  int weekSlots(CalendarDate weekStart) {
    final times = switch (habit.schedule) {
      TimesPerWeek(:final times) => times,
      _ => 0,
    };
    var available = 0;
    for (var i = 0; i < 7; i++) {
      if (isActiveOn(weekStart.addDays(i))) available++;
    }
    return math.min(times, available);
  }

  /// How a weekly habit's week went, as of [today].
  WeekOutcome weekOutcome(
    CalendarDate weekStart, {
    required CalendarDate today,
  }) {
    var done = 0;
    var skipped = 0;
    for (var i = 0; i < 7; i++) {
      final day = weekStart.addDays(i);
      if (day > today || !isActiveOn(day)) continue;
      if (isDoneOn(day)) done++;
      if (isSkippedOn(day)) skipped++;
    }
    return WeekOutcome(
      needed: math.max(0, weekSlots(weekStart) - skipped),
      done: done,
      isCurrent: weekStart == today.weekStart,
    );
  }

  /// What [day] looks like, as of [today].
  DayState stateOn(CalendarDate day, {required CalendarDate today}) {
    if (day > today) return DayState.future;
    if (!isActiveOn(day)) return DayState.none;
    final log = _logs[day];
    if (log != null && log.skipped) return DayState.skipped;
    if (isDoneOn(day)) return DayState.done;
    if (log != null) return DayState.partial;
    if (!isDue(day)) return DayState.none;
    if (day == today) return DayState.open;
    return switch (habit.schedule) {
      TimesPerWeek() => DayState.none,
      Daily() || OnWeekdays() => DayState.missed,
    };
  }

  /// Done days in all, on any day.
  int get totalCompletions => _logs.keys.where(isDoneOn).length;

  /// Whether a day can still be changed from the habit's history (backfill):
  /// not in the future, not before the habit started, at most
  /// [backfillDays] back, and only while the habit isn't archived.
  bool canSetDay(CalendarDate day, {required CalendarDate today}) =>
      habit.archivedAt == null &&
      day <= today &&
      day >= habit.startDate &&
      day.daysUntil(today) <= backfillDays;

  /// How far back a day can be changed.
  static const backfillDays = 30;

  int _slotsUsed(CalendarDate weekStart, {required CalendarDate before}) {
    var used = 0;
    for (var day = weekStart; day < before; day = day.addDays(1)) {
      if (isDoneOn(day) || isSkippedOn(day)) used++;
    }
    return used;
  }
}

/// A weekly habit's week: how many done days it [needed] (its slots, less
/// the days skipped) and how many it got.
class WeekOutcome {
  const WeekOutcome({
    required this.needed,
    required this.done,
    required this.isCurrent,
  });

  final int needed;
  final int done;

  /// This week, still under way.
  final bool isCurrent;

  bool get met => needed > 0 && done >= needed;

  /// A week with nothing asked of it (every slot skipped, or the habit not
  /// active): it neither extends nor breaks a streak.
  bool get isNeutral => needed == 0;
}
