import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/completion_rate.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit.dart';

import '../../helpers/habit_builders.dart';

void main() {
  CompletionRate rateOf(
    List<HabitHistory> histories, {
    int from = 12,
    int to = 21,
  }) => completionRate(histories, from: oct(from), to: oct(to), today: today);

  group('fixed days', () {
    test('done ÷ (due − skipped); today left out until done', () {
      // 12–20 October: nine days, one skipped, six done.
      final h = history(habit(start: oct(1)), [
        ...doneEvery(oct(12), oct(17)),
        skip(oct(18)),
      ]);

      expect(rateOf([h]), const CompletionRate(achieved: 6, expected: 8));
      expect(rateOf([h]).ratio, 0.75);
    });

    test('today counts once done', () {
      final h = history(habit(start: oct(1)), doneEvery(oct(12), oct(21)));

      expect(rateOf([h]), const CompletionRate(achieved: 10, expected: 10));
    });

    test(
      'a weekday habit is asked on its days; done on a day off is left out',
      () {
        // Mon 12, Wed 14, Fri 16, Mon 19 due (Wed 21 is today, pending).
        final h = history(habit(schedule: monWedFri, start: oct(1)), [
          done(oct(12)),
          done(oct(13)),
          done(oct(16)),
        ]);

        expect(rateOf([h]), const CompletionRate(achieved: 2, expected: 4));
      },
    );

    test('days before the start are not asked', () {
      final h = history(habit(start: oct(20)), [done(oct(20))]);

      expect(rateOf([h]), const CompletionRate(achieved: 1, expected: 1));
    });
  });

  group('times a week', () {
    final weekly = habit(
      schedule: const HabitSchedule.timesPerWeek(3),
      start: oct(1),
    );

    test('a past week asks for its slots; extra days earn nothing more', () {
      final short = history(weekly, [done(oct(12)), done(oct(14))]);
      final extra = history(weekly, doneEvery(oct(12), oct(17)));

      expect(
        rateOf([short], to: 18),
        const CompletionRate(achieved: 2, expected: 3),
      );
      expect(
        rateOf([extra], to: 18),
        const CompletionRate(achieved: 3, expected: 3),
      );
    });

    test('this week asks only for what is done so far', () {
      final h = history(weekly, [done(oct(19))]);

      expect(
        rateOf([h], from: 19),
        const CompletionRate(achieved: 1, expected: 1),
      );
      expect(rateOf([history(weekly)], from: 19).ratio, isNull);
    });

    test('a skip lowers what the week asks', () {
      final h = history(weekly, [skip(oct(12)), done(oct(13))]);

      expect(
        rateOf([h], to: 18),
        const CompletionRate(achieved: 1, expected: 2),
      );
    });
  });

  test('adds up across habits', () {
    final a = history(
      habit(id: 'a', start: oct(1)),
      doneEvery(oct(19), oct(20), id: 'a'),
    );
    final b = history(habit(id: 'b', start: oct(1)), [done(oct(19), id: 'b')]);

    expect(
      rateOf([a, b], from: 19),
      const CompletionRate(achieved: 3, expected: 4),
    );
  });

  test('nothing asked yet: no ratio', () {
    expect(rateOf([]).ratio, isNull);
  });
}
