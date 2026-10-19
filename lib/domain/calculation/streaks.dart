import 'dart:math' as math;

import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';

/// What a streak counts.
enum StreakUnit { days, weeks }

/// A habit's current and longest runs.
class HabitStreak {
  const HabitStreak({
    required this.current,
    required this.longest,
    required this.unit,
  });

  final int current;
  final int longest;
  final StreakUnit unit;

  @override
  bool operator ==(Object other) =>
      other is HabitStreak &&
      other.current == current &&
      other.longest == longest &&
      other.unit == unit;

  @override
  int get hashCode => Object.hash(current, longest, unit);

  @override
  String toString() => 'HabitStreak($current, longest $longest ${unit.name})';
}

/// A habit's streak, as of [today].
///
/// - **Fixed days** (daily, on weekdays): consecutive due days done. Days
///   it wasn't due and skipped days are passed over: a Mon / Wed / Fri
///   habit's streak survives the Tuesday, and a skip neither breaks nor
///   extends it. Today counts once done, and doesn't break it before then.
/// - **Times per week:** consecutive ISO weeks that met their target,
///   counted in weeks. Judging the week, not the day, is the point of the
///   schedule: any three days make a 3× week. This week counts once met.
HabitStreak habitStreak(HabitHistory history, {required CalendarDate today}) {
  final habit = history.habit;
  var run = 0;
  var longest = 0;

  void extend() => longest = math.max(longest, ++run);

  switch (habit.schedule) {
    case Daily() || OnWeekdays():
      for (var day = habit.startDate; day <= today; day = day.addDays(1)) {
        if (!history.isDue(day) || history.isSkippedOn(day)) continue;
        if (history.isDoneOn(day)) {
          extend();
        } else if (day != today) {
          run = 0;
        }
      }
      return HabitStreak(current: run, longest: longest, unit: StreakUnit.days);
    case TimesPerWeek():
      for (
        var week = habit.startDate.weekStart;
        week <= today;
        week = week.addDays(7)
      ) {
        final outcome = history.weekOutcome(week, today: today);
        if (outcome.isNeutral) continue;
        if (outcome.met) {
          extend();
        } else if (!outcome.isCurrent) {
          run = 0;
        }
      }
      return HabitStreak(
        current: run,
        longest: longest,
        unit: StreakUnit.weeks,
      );
  }
}
