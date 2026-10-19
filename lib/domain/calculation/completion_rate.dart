import 'dart:math' as math;

import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';

/// How much of what was asked got done: [achieved] of [expected].
class CompletionRate {
  const CompletionRate({required this.achieved, required this.expected});

  final int achieved;
  final int expected;

  /// 0 to 1, or null when nothing was asked yet.
  double? get ratio => expected == 0 ? null : achieved / expected;

  CompletionRate operator +(CompletionRate other) => CompletionRate(
    achieved: achieved + other.achieved,
    expected: expected + other.expected,
  );

  @override
  bool operator ==(Object other) =>
      other is CompletionRate &&
      other.achieved == achieved &&
      other.expected == expected;

  @override
  int get hashCode => Object.hash(achieved, expected);

  @override
  String toString() => 'CompletionRate($achieved / $expected)';
}

/// The completion rate of [histories] from [from] to [to] (inclusive), as
/// of [today]: done ÷ (due − skipped).
///
/// - **Fixed days:** each due day is asked once. Skipped days are left out,
///   and so is today until it's done: the day isn't over.
/// - **Times per week:** each week asks for its slots, less its skips (the
///   part of the week inside the range). This week asks only for what is
///   done so far, for the same reason as today.
/// - Days a habit wasn't due are left out, even when it was done anyway.
CompletionRate completionRate(
  Iterable<HabitHistory> histories, {
  required CalendarDate from,
  required CalendarDate to,
  required CalendarDate today,
}) {
  var total = const CompletionRate(achieved: 0, expected: 0);
  final end = to < today ? to : today;
  for (final history in histories) {
    switch (history.habit.schedule) {
      case Daily() || OnWeekdays():
        var achieved = 0;
        var expected = 0;
        for (var day = from; day <= end; day = day.addDays(1)) {
          if (!history.isDue(day) || history.isSkippedOn(day)) continue;
          final done = history.isDoneOn(day);
          if (day == today && !done) continue;
          expected++;
          if (done) achieved++;
        }
        total += CompletionRate(achieved: achieved, expected: expected);
      case TimesPerWeek(:final times):
        for (var week = from.weekStart; week <= end; week = week.addDays(7)) {
          var active = 0;
          var done = 0;
          var skipped = 0;
          for (var i = 0; i < 7; i++) {
            final day = week.addDays(i);
            if (day < from || day > end || !history.isActiveOn(day)) continue;
            active++;
            if (history.isDoneOn(day)) done++;
            if (history.isSkippedOn(day)) skipped++;
          }
          var needed = math.max(0, math.min(times, active) - skipped);
          if (week == today.weekStart) needed = math.min(needed, done);
          total += CompletionRate(
            achieved: math.min(done, needed),
            expected: needed,
          );
        }
    }
  }
  return total;
}
