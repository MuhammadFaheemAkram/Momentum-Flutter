import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/habit.dart';

void main() {
  test('a schedule reads the way people say it', () {
    expect(scheduleLabel(const HabitSchedule.daily()), 'Daily');
    expect(
      scheduleLabel(const HabitSchedule.onWeekdays({5, 1, 3})),
      'Mon · Wed · Fri',
    );
    expect(
      scheduleLabel(const HabitSchedule.onWeekdays({1, 2, 3, 4, 5})),
      'Weekdays',
    );
    expect(scheduleLabel(const HabitSchedule.onWeekdays({6, 7})), 'Weekends');
    expect(
      scheduleLabel(const HabitSchedule.onWeekdays({1, 2, 3, 4, 5, 6, 7})),
      'Every day',
    );
    expect(scheduleLabel(const HabitSchedule.timesPerWeek(3)), '3× a week');
    expect(
      scheduleLabel(const HabitSchedule.daily(), dailyTarget: 8),
      'Daily · 8 a day',
    );
  });

  test('a streak reads in its unit, and not at all when zero', () {
    expect(
      streakLabel(
        const HabitStreak(current: 4, longest: 9, unit: StreakUnit.days),
      ),
      '4-day streak',
    );
    expect(
      streakLabel(
        const HabitStreak(current: 2, longest: 2, unit: StreakUnit.weeks),
      ),
      '2-week streak',
    );
    expect(
      streakLabel(
        const HabitStreak(current: 0, longest: 9, unit: StreakUnit.days),
      ),
      isNull,
    );
    expect(streakLength(1, StreakUnit.weeks), '1 week');
  });

  test('counts read naturally', () {
    expect(countLabel(1, 'time'), '1 time');
    expect(countLabel(3, 'time'), '3 times');
  });
}
