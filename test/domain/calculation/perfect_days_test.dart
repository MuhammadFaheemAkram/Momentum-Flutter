import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';
import 'package:momentum/domain/model/habit.dart';

import '../../helpers/habit_builders.dart';

void main() {
  final water = habit(id: 'water', start: oct(1));
  final run = habit(id: 'run', schedule: monWedFri, start: oct(1));
  final spanish = habit(
    id: 'spanish',
    schedule: const HabitSchedule.timesPerWeek(3),
    start: oct(1),
  );

  int streakOf(List<HabitHistory> histories) =>
      perfectDayStreak(histories, today: today);

  test('a day is perfect when everything due is done', () {
    final histories = [
      history(water, doneEvery(oct(15), oct(20), id: 'water')),
      // Fri 16 and Mon 19: both of its due days in the run.
      history(run, [done(oct(16), id: 'run'), done(oct(19), id: 'run')]),
    ];

    expect(streakOf(histories), 6);
  });

  test('one missed habit breaks the run', () {
    final histories = [
      history(water, doneEvery(oct(15), oct(20), id: 'water')),
      history(run, [done(oct(19), id: 'run')]),
    ];

    // Friday the 16th was missed; Saturday to Tuesday were perfect.
    expect(streakOf(histories), 4);
  });

  test('a skip does not spoil a day', () {
    final histories = [
      history(water, doneEvery(oct(18), oct(20), id: 'water')),
      history(run, [skip(oct(19), id: 'run')]),
    ];

    expect(isPerfectDay(histories, oct(19), today: today), isTrue);
  });

  test(
    'a weekly habit not done that day does not spoil it; done, it counts',
    () {
      final histories = [
        history(water, doneEvery(oct(19), oct(20), id: 'water')),
        history(spanish, [done(oct(18), id: 'spanish')]),
      ];

      expect(isPerfectDay(histories, oct(19), today: today), isTrue);
      expect(
        isPerfectDay(
          [
            history(spanish, [done(oct(18), id: 'spanish')]),
          ],
          oct(18),
          today: today,
        ),
        isTrue,
      );
    },
  );

  test('a day with nothing asked or done is passed over', () {
    // Only the Mon / Wed / Fri habit: Saturday and Sunday ask nothing.
    final histories = [
      history(run, [done(oct(16), id: 'run'), done(oct(19), id: 'run')]),
    ];

    expect(isPerfectDay(histories, oct(17), today: today), isNull);
    expect(streakOf(histories), 2);
  });

  test(
    "today doesn't break the run before it's over; it counts once perfect",
    () {
      final pending = [
        history(water, doneEvery(oct(18), oct(20), id: 'water')),
      ];
      final finished = [
        history(water, doneEvery(oct(18), oct(21), id: 'water')),
      ];

      expect(isPerfectDay(pending, today, today: today), isNull);
      expect(streakOf(pending), 3);
      expect(streakOf(finished), 4);
    },
  );

  test('no habits, no perfect days', () {
    expect(streakOf([]), 0);
  });

  group('the week strip', () {
    test('shows each day of this week, Monday first', () {
      final histories = [
        history(water, [done(oct(19), id: 'water'), done(today, id: 'water')]),
        history(run, [done(oct(19), id: 'run')]),
      ];

      expect(weekDots(histories, today: today), [
        DayDot.perfect,
        DayDot.missed,
        DayDot.partial,
        DayDot.future,
        DayDot.future,
        DayDot.future,
        DayDot.future,
      ]);
    });

    test('a day with something done but something missed is partial', () {
      final histories = [
        history(water, [done(oct(19), id: 'water')]),
        history(run),
      ];

      expect(weekDots(histories, today: today).first, DayDot.partial);
    });

    test('a day that asks nothing is empty', () {
      expect(weekDots([history(run)], today: today)[1], DayDot.empty);
    });
  });
}
