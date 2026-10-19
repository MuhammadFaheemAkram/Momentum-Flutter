import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/habit.dart';

import '../../helpers/habit_builders.dart';

void main() {
  group('Today', () {
    final water = habit(id: 'water', target: 8);
    final read = habit(id: 'read');
    final run = habit(id: 'run', schedule: monWedFri);
    final plan = habit(id: 'plan');
    final weekly = habit(
      id: 'weekly',
      schedule: const HabitSchedule.timesPerWeek(1),
    );

    test('lists due habits not done, then done, then skipped; the rest as '
        'not due', () {
      final overview = buildTodayOverview(
        [water, read, run, plan, weekly],
        [
          done(today, id: 'read'),
          done(today, id: 'water', count: 3),
          skip(today, id: 'run'),
          done(oct(19), id: 'weekly'),
        ],
        today: today,
      );

      expect(overview.due.map((h) => h.habit.id), [
        'water',
        'plan',
        'read',
        'run',
      ]);
      expect(overview.notDue.map((h) => h.habit.id), ['weekly']);
      expect(overview.due.first.count, 3);
    });

    test('the ring is done ÷ due, leaving skips out', () {
      final overview = buildTodayOverview(
        [read, plan, run],
        [done(today, id: 'read'), skip(today, id: 'run')],
        today: today,
      );

      expect((overview.summary.done, overview.summary.due), (1, 2));
      expect(overview.summary.ratio, 0.5);
    });

    test('archived habits are left out; a habit starting later is not due', () {
      final overview = buildTodayOverview(
        [
          read.copyWith(archivedAt: DateTime.utc(2026, 10)),
          plan.copyWith(startDate: oct(25)),
        ],
        const [],
        today: today,
      );

      expect(overview.due, isEmpty);
      expect(overview.notDue.single.habit.id, 'plan');
      expect(overview.summary.ratio, isNull);
    });

    test('nothing at all: empty', () {
      expect(
        buildTodayOverview(const [], const [], today: today).isEmpty,
        isTrue,
      );
    });
  });

  test('the Habits list keeps archived habits, in order', () {
    final list = buildHabitList(
      [habit(id: 'a'), habit(id: 'b', archivedAt: DateTime.utc(2026, 10))],
      const [],
      today: today,
    );

    expect(list.map((h) => (h.habit.id, h.due)), [('a', true), ('b', false)]);
  });

  group('a habit page', () {
    final h = habit(start: oct(1), target: 2);

    test('has twelve whole weeks, the last holding today', () {
      final detail = buildHabitDetail(h, const [], today: today);

      expect(detail.heatmap, hasLength(84));
      expect(detail.heatmap.first.day, oct(19).addDays(-77));
      expect(detail.heatmap.first.day.weekday, 1);
      expect(detail.heatmap.last.day, oct(25));
      expect(detail.heatmap.last.state, DayState.future);
    });

    test('can set the days of the last 30 since its start, not ahead', () {
      final detail = buildHabitDetail(h, const [], today: today);
      bool canSet(int daysAgo) => detail.heatmap
          .singleWhere((d) => d.day == today.addDays(-daysAgo))
          .canSet;

      expect(canSet(0), isTrue);
      expect(canSet(20), isTrue);
      expect(canSet(21), isFalse, reason: 'before 1 October, its start');
      expect(detail.heatmap.last.canSet, isFalse);
    });

    test('has the figures and eight weekly bars', () {
      final detail = buildHabitDetail(h, [
        ...doneEvery(oct(12), oct(20), count: 2),
        done(oct(11)),
      ], today: today);

      expect(
        detail.streak,
        const HabitStreak(current: 9, longest: 9, unit: StreakUnit.days),
      );
      expect(detail.totalCompletions, 9);
      // 1–20 October due (today pending), 9 done.
      expect((detail.rate.achieved, detail.rate.expected), (9, 20));
      expect(detail.weeks, hasLength(8));
      expect(detail.weeks.reversed.take(2).map((w) => (w.done, w.target)), [
        (2, 7),
        (7, 7),
      ]);
      expect(detail.weeks.first.target, 0, reason: 'before it started');
    });

    test("a weekly habit's bars aim at its times a week", () {
      final weekly = habit(
        schedule: const HabitSchedule.timesPerWeek(3),
        start: oct(1),
      );
      final detail = buildHabitDetail(weekly, [done(oct(19))], today: today);

      expect((detail.weeks.last.done, detail.weeks.last.target), (1, 3));
    });
  });
}
