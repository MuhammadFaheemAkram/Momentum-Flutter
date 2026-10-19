import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';

import '../../helpers/habit_builders.dart';

void main() {
  group('isDue', () {
    test('a daily habit is due every day from its start', () {
      final h = history(habit(start: oct(10)));

      expect(h.isDue(oct(9)), isFalse);
      expect(h.isDue(oct(10)), isTrue);
      expect(h.isDue(oct(25)), isTrue);
    });

    test('a weekday habit is due on its days only', () {
      final h = history(habit(schedule: monWedFri));

      // 19 October 2026 is a Monday.
      expect(
        [for (var d = 19; d <= 25; d++) h.isDue(oct(d))],
        [true, false, true, false, true, false, false],
      );
    });

    test('an archived habit is due until the day it was archived', () {
      final h = history(habit(archivedAt: DateTime(2026, 10, 20, 9)));

      expect(h.isDue(oct(19)), isTrue);
      expect(h.isDue(oct(20)), isFalse);
      expect(h.isDue(oct(21)), isFalse);
    });

    group('a 3-times-a-week habit', () {
      final weekly = habit(schedule: const HabitSchedule.timesPerWeek(3));

      test('is due each day until the week has its three', () {
        final h = history(weekly, [
          done(oct(19)),
          done(oct(20)),
          done(oct(21)),
        ]);

        expect(h.isDue(oct(21)), isTrue, reason: 'the third, Wednesday');
        expect(h.isDue(oct(22)), isFalse);
        expect(h.isDue(oct(25)), isFalse);
      });

      test('a skip uses one of the slots', () {
        final h = history(weekly, [
          done(oct(19)),
          skip(oct(20)),
          done(oct(21)),
        ]);

        expect(h.isDue(oct(22)), isFalse);
      });

      test('a partial day uses none', () {
        final counted = weekly.copyWith(dailyTarget: 2);
        final h = history(counted, [
          done(oct(19), count: 2),
          done(oct(20), count: 2),
          done(oct(21)),
        ]);

        expect(h.isDue(oct(22)), isTrue);
      });

      test('starts over each ISO week', () {
        final h = history(weekly, [
          done(oct(13)),
          done(oct(14)),
          done(oct(15)),
        ]);

        expect(h.isDue(oct(16)), isFalse);
        expect(h.isDue(oct(19)), isTrue, reason: 'Monday, a new week');
      });

      test('asks for fewer in a week it starts part-way through', () {
        // Started on Saturday the 24th: two days left that week.
        final h = history(weekly.copyWith(startDate: oct(24)));

        expect(h.weekSlots(oct(19)), 2);
        expect(h.weekSlots(oct(26)), 3);
      });
    });
  });

  group('stateOn', () {
    test('reads each kind of day', () {
      final h = history(habit(start: oct(10), target: 2), [
        done(oct(15), count: 2),
        done(oct(16), count: 3),
        done(oct(17)),
        skip(oct(18)),
      ]);

      expect(h.stateOn(oct(9), today: today), DayState.none, reason: 'before');
      expect(h.stateOn(oct(15), today: today), DayState.done);
      expect(h.stateOn(oct(16), today: today), DayState.done, reason: '3 / 2');
      expect(h.stateOn(oct(17), today: today), DayState.partial);
      expect(h.stateOn(oct(18), today: today), DayState.skipped);
      expect(h.stateOn(oct(19), today: today), DayState.missed);
      expect(h.stateOn(today, today: today), DayState.open);
      expect(h.stateOn(oct(22), today: today), DayState.future);
    });

    test('a weekday habit on a day off is none, and done if done anyway', () {
      final h = history(habit(schedule: monWedFri), [done(oct(20))]);

      expect(h.stateOn(oct(18), today: today), DayState.none);
      expect(h.stateOn(oct(20), today: today), DayState.done);
    });

    test("a weekly habit's empty day is never a miss: the week is judged", () {
      final h = history(habit(schedule: const HabitSchedule.timesPerWeek(3)));

      expect(h.stateOn(oct(19), today: today), DayState.none);
      expect(h.stateOn(today, today: today), DayState.open);
    });
  });

  group('weekOutcome', () {
    final weekly = habit(schedule: const HabitSchedule.timesPerWeek(3));

    test('met with its slots done', () {
      final outcome = history(weekly, [
        done(oct(12)),
        done(oct(14)),
        done(oct(18)),
      ]).weekOutcome(oct(12), today: today);

      expect((outcome.needed, outcome.done, outcome.met), (3, 3, true));
      expect(outcome.isCurrent, isFalse);
    });

    test('skips lower what it needs; a fully skipped week is neutral', () {
      final one = history(weekly, [
        skip(oct(12)),
        done(oct(13)),
        done(oct(14)),
      ]).weekOutcome(oct(12), today: today);
      final all = history(weekly, [
        skip(oct(12)),
        skip(oct(13)),
        skip(oct(14)),
      ]).weekOutcome(oct(12), today: today);

      expect((one.needed, one.met), (2, true));
      expect((all.isNeutral, all.met), (true, false));
    });
  });

  group('canSetDay (backfill)', () {
    test('from the start, up to 30 days back, never ahead', () {
      final h = history(habit(start: CalendarDate(2026, 9, 1)));

      expect(h.canSetDay(today, today: today), isTrue);
      expect(h.canSetDay(today.addDays(-30), today: today), isTrue);
      expect(h.canSetDay(today.addDays(-31), today: today), isFalse);
      expect(h.canSetDay(today.addDays(1), today: today), isFalse);
      expect(
        history(habit(start: oct(15))).canSetDay(oct(14), today: today),
        isFalse,
      );
    });

    test('not while archived', () {
      final h = history(habit(archivedAt: DateTime.utc(2026, 10, 21)));

      expect(h.canSetDay(oct(15), today: today), isFalse);
    });
  });

  test('total completions count done days, on any day', () {
    final h = history(habit(schedule: monWedFri, target: 2), [
      done(oct(19), count: 2),
      done(oct(20), count: 5),
      done(oct(21)),
      skip(oct(16)),
    ]);

    expect(h.totalCompletions, 2);
  });
}
