import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_log.dart';

void main() {
  final day = CalendarDate(2026, 10, 21);

  group('HabitSchedule', () {
    test('weekday schedules compare by their days, in any order', () {
      expect(
        const HabitSchedule.onWeekdays({1, 3, 5}),
        const HabitSchedule.onWeekdays({5, 1, 3}),
      );
      expect(
        const HabitSchedule.onWeekdays({1, 3}),
        isNot(const HabitSchedule.onWeekdays({1, 3, 5})),
      );
    });

    test('a weekly schedule is one to six times', () {
      expect(const HabitSchedule.timesPerWeek(6), isA<TimesPerWeek>());
      expect(
        () => HabitSchedule.timesPerWeek(0),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => HabitSchedule.timesPerWeek(7),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('HabitLog', () {
    test('is a count of at least one, or a skip', () {
      expect(HabitLog(habitId: 'h', day: day).count, 1);
      expect(
        HabitLog(habitId: 'h', day: day, count: 0, skipped: true).skipped,
        isTrue,
      );
    });

    test('is never both, nor neither', () {
      expect(
        () => HabitLog(habitId: 'h', day: day, count: 0),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => HabitLog(habitId: 'h', day: day, count: 2, skipped: true),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  test(
    "every stored habit color has a shade in the design system's palette",
    () {
      // A habit stores its color's *name*; the palette must know every one.
      expect(HabitPalette.names, [
        for (final color in HabitColor.values) color.name,
      ]);
    },
  );
}
