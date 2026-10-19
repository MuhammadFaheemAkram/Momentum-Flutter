import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';

import '../../helpers/habit_builders.dart';

void main() {
  HabitStreak streakOf(Habit h, List<HabitLog> logs, {CalendarDate? on}) =>
      habitStreak(history(h, logs), today: on ?? today);

  group('a daily habit', () {
    final h = habit(start: oct(1));

    test('counts done days back from yesterday while today is pending', () {
      final streak = streakOf(h, doneEvery(oct(15), oct(20)));

      expect(
        streak,
        const HabitStreak(current: 6, longest: 6, unit: StreakUnit.days),
      );
    });

    test('today counts once done', () {
      expect(streakOf(h, doneEvery(oct(15), oct(21))).current, 7);
    });

    test('a missed day breaks it; the longest run is kept', () {
      final logs = [
        ...doneEvery(oct(1), oct(10)),
        ...doneEvery(oct(12), oct(20)),
      ];

      expect(
        streakOf(h, logs),
        const HabitStreak(current: 9, longest: 10, unit: StreakUnit.days),
      );
    });

    test('a missed yesterday leaves none, even with today pending', () {
      expect(streakOf(h, doneEvery(oct(10), oct(19))).current, 0);
    });

    test('a skipped day neither breaks nor extends it', () {
      final logs = [
        ...doneEvery(oct(15), oct(17)),
        skip(oct(18)),
        ...doneEvery(oct(19), oct(20)),
      ];

      expect(streakOf(h, logs).current, 5);
    });

    test('a partial day is not done: it breaks it once over', () {
      final counted = habit(start: oct(1), target: 8);
      final logs = [
        ...doneEvery(oct(15), oct(18), count: 8),
        done(oct(19), count: 7),
        done(oct(20), count: 9),
      ];

      expect(streakOf(counted, logs).current, 1);
      expect(streakOf(counted, [...logs, done(today, count: 3)]).current, 1);
    });

    test('runs across the end of a month and of a year', () {
      final h = habit(start: CalendarDate(2026, 12, 1));
      final logs = doneEvery(
        CalendarDate(2026, 12, 28),
        CalendarDate(2027, 1, 3),
      );

      expect(streakOf(h, logs, on: CalendarDate(2027, 1, 3)).current, 7);
      expect(
        streakOf(
          habit(start: oct(1)),
          doneEvery(oct(29), CalendarDate(2026, 11, 2)),
          on: CalendarDate(2026, 11, 2),
        ).current,
        5,
      );
    });

    test("doesn't count days before it started", () {
      // Done before its start (the start date was moved later).
      final late = habit(start: oct(18));

      expect(streakOf(late, doneEvery(oct(10), oct(20))).current, 3);
    });

    test('is zero with no history', () {
      expect(
        streakOf(h, const []),
        const HabitStreak(current: 0, longest: 0, unit: StreakUnit.days),
      );
    });
  });

  group('a Mon / Wed / Fri habit', () {
    final h = habit(schedule: monWedFri, start: oct(1));

    test('carries its streak over the days it is not due', () {
      // Fri 9, Mon 12, Wed 14, Fri 16, Mon 19; today is Wednesday.
      final logs = [
        done(oct(9)),
        done(oct(12)),
        done(oct(14)),
        done(oct(16)),
        done(oct(19)),
      ];

      expect(streakOf(h, logs).current, 5);
    });

    test('done on a day off: neither more nor less', () {
      final logs = [done(oct(16)), done(oct(17)), done(oct(19))];

      expect(streakOf(h, logs).current, 2);
    });

    test('a missed due day breaks it', () {
      final logs = [done(oct(12)), done(oct(14)), done(oct(19))];

      expect(streakOf(h, logs).current, 1, reason: 'Friday the 16th missed');
    });
  });

  group('a 3-times-a-week habit counts weeks', () {
    final h = habit(
      schedule: const HabitSchedule.timesPerWeek(3),
      start: oct(1),
    );
    // Week of 5 October: met; week of 12 October: met; this week: 1 so far.
    final metWeeks = [
      done(oct(5)),
      done(oct(7)),
      done(oct(10)),
      done(oct(12)),
      done(oct(13)),
      done(oct(18)),
      done(oct(19)),
    ];

    test('this week, still under way, neither counts nor breaks it', () {
      expect(
        streakOf(h, metWeeks),
        const HabitStreak(current: 2, longest: 2, unit: StreakUnit.weeks),
      );
    });

    test('this week counts once met', () {
      expect(
        streakOf(h, [...metWeeks, done(oct(20)), done(oct(21))]).current,
        3,
      );
    });

    test('a past week short of its target breaks it', () {
      final logs = [...metWeeks]..remove(metWeeks[3]);

      expect(streakOf(h, logs).current, 0);
      expect(streakOf(h, logs).longest, 1);
    });

    test('a fully skipped week is neutral', () {
      final logs = [
        done(oct(5)),
        done(oct(7)),
        done(oct(10)),
        skip(oct(12)),
        skip(oct(13)),
        skip(oct(14)),
        done(oct(19)),
        done(oct(20)),
        done(oct(21)),
      ];

      expect(streakOf(h, logs).current, 2);
    });

    test('its first week asks only for the days it had', () {
      // Started Saturday 17 October: two days that week, both done.
      final late = h.copyWith(startDate: oct(17));

      expect(streakOf(late, [done(oct(17)), done(oct(18))]).current, 1);
    });
  });

  test('an archived habit keeps the streak it had', () {
    final h = habit(start: oct(1), archivedAt: DateTime(2026, 10, 18, 12));

    expect(streakOf(h, doneEvery(oct(10), oct(17))).current, 8);
  });
}
