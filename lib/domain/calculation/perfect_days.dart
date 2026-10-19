import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';

/// Whether [day] was perfect: nothing due was missed, and something was
/// done. `null` when the day doesn't count either way: nothing was asked
/// or done, or it's today and not perfect *yet*.
///
/// Skipped habits don't spoil a day. A weekly habit is judged by its week,
/// so it never makes a day imperfect; doing it still makes a day count.
bool? isPerfectDay(
  Iterable<HabitHistory> histories,
  CalendarDate day, {
  required CalendarDate today,
}) {
  var anyDone = false;
  var anyMissed = false;
  for (final history in histories) {
    if (!history.isActiveOn(day)) continue;
    if (history.isDoneOn(day)) {
      anyDone = true;
    } else if (history.habit.schedule is! TimesPerWeek &&
        history.isDue(day) &&
        !history.isSkippedOn(day)) {
      anyMissed = true;
    }
  }
  if (anyMissed) return day == today ? null : false;
  return anyDone ? true : null;
}

/// Consecutive perfect days, counting back from today (which counts once
/// perfect, and doesn't break the run before then). Days that don't count
/// either way are passed over.
int perfectDayStreak(
  Iterable<HabitHistory> histories, {
  required CalendarDate today,
}) {
  final starts = [for (final history in histories) history.habit.startDate];
  if (starts.isEmpty) return 0;
  final first = starts.reduce((a, b) => a < b ? a : b);
  var streak = 0;
  for (var day = today; day >= first; day = day.addDays(-1)) {
    switch (isPerfectDay(histories, day, today: today)) {
      case true:
        streak++;
      case false:
        return streak;
      case null:
        continue;
    }
  }
  return streak;
}

/// How a day of the week strip on Today looks.
enum DayDot {
  /// Everything due was done.
  perfect,

  /// Something done, but not everything (or today, under way).
  partial,

  /// Something due was missed, and nothing done.
  missed,

  /// Nothing asked or done.
  empty,

  /// Still to come.
  future,
}

/// The seven days of [today]'s ISO week, Monday first.
List<DayDot> weekDots(
  Iterable<HabitHistory> histories, {
  required CalendarDate today,
}) {
  return [
    for (var i = 0; i < 7; i++)
      () {
        final day = today.weekStart.addDays(i);
        if (day > today) return DayDot.future;
        final anyDone = histories.any(
          (h) => h.isDoneOn(day) && h.isActiveOn(day),
        );
        return switch (isPerfectDay(histories, day, today: today)) {
          true => DayDot.perfect,
          false => anyDone ? DayDot.partial : DayDot.missed,
          null => anyDone ? DayDot.partial : DayDot.empty,
        };
      }(),
  ];
}
