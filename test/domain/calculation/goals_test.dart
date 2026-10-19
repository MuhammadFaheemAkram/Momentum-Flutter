import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/goals.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';

import '../../helpers/habit_builders.dart';

void main() {
  group('goalWindow', () {
    test('daily is today', () {
      expect(
        goalWindow(GoalPeriod.daily, today),
        GoalWindow(start: today, end: today),
      );
    });

    test('weekly is the ISO week, Monday to Sunday, across a month end', () {
      expect(
        goalWindow(GoalPeriod.weekly, today),
        GoalWindow(start: oct(19), end: oct(25)),
      );
      expect(
        goalWindow(GoalPeriod.weekly, oct(31)),
        GoalWindow(start: oct(26), end: CalendarDate(2026, 11, 1)),
      );
      expect(goalWindow(GoalPeriod.weekly, oct(25)).start, oct(19));
    });

    test('monthly is the calendar month, whatever its length', () {
      expect(
        goalWindow(GoalPeriod.monthly, today),
        GoalWindow(start: oct(1), end: oct(31)),
      );
      expect(
        goalWindow(GoalPeriod.monthly, CalendarDate(2028, 2, 10)).end,
        CalendarDate(2028, 2, 29),
      );
    });

    test('a goal resets the day after its window', () {
      expect(goalWindow(GoalPeriod.weekly, today).resets, oct(26));
    });
  });

  group('goalProgress', () {
    final water = habit(id: 'water', target: 8);
    final read = habit(id: 'read').copyWith(title: 'Read');
    final histories = [
      history(water, [
        done(oct(19), id: 'water', count: 8),
        done(oct(20), id: 'water', count: 5),
        done(oct(21), id: 'water', count: 9),
      ]),
      history(read, [
        done(oct(18), id: 'read'),
        done(oct(19), id: 'read'),
        skip(oct(20), id: 'read'),
        done(oct(21), id: 'read'),
      ]),
    ];

    test('all habits: every done day in the window counts once', () {
      final progress = goalProgress(goal(), histories, today: today);

      // Water on the 19th and 21st (the 20th was partial), Read on the 19th
      // and 21st (the 18th was last week, the 20th a skip).
      expect(progress.current, 4);
      expect(progress.habitTitle, isNull);
    });

    test('one habit: only that habit counts', () {
      final progress = goalProgress(
        goal(scope: const GoalScope.habit('read')),
        histories,
        today: today,
      );

      expect(progress.current, 2);
      expect(progress.habitTitle, 'Read');
    });

    test('daily and monthly windows count their own days', () {
      expect(
        goalProgress(
          goal(period: GoalPeriod.daily),
          histories,
          today: today,
        ).current,
        2,
      );
      expect(
        goalProgress(
          goal(period: GoalPeriod.monthly),
          histories,
          today: today,
        ).current,
        5,
      );
    });

    test('a new window starts from zero, with nothing reset', () {
      final nextMonday = oct(26);

      expect(goalProgress(goal(), histories, today: nextMonday).current, 0);
    });

    test('met at its target; the bar stops at full', () {
      final progress = goalProgress(goal(target: 3), histories, today: today);

      expect(progress.isMet, isTrue);
      expect(progress.ratio, 1);
    });

    test("an archived habit's done days in the window still count", () {
      final archived = history(
        habit(id: 'old', archivedAt: DateTime.utc(2026, 10, 21)),
        [done(oct(19), id: 'old')],
      );

      expect(goalProgress(goal(), [archived], today: today).current, 1);
    });
  });
}
