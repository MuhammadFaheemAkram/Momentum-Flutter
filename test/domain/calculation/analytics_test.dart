import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/analytics.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

import '../../helpers/habit_builders.dart';

void main() {
  group('the consistency score', () {
    test('the last 7 days count twice', () {
      // A good last week after a slow month scores higher than its rate.
      final h = habit(start: today.addDays(-29));
      final recentOnly = history(
        h,
        doneEvery(today.addDays(-6), today.addDays(-1)),
      );

      // (2×6 + 0) / (2×6 + 23) = 34, against a plain rate of 6 / 29 = 21.
      expect(consistencyScore([recentOnly], today: today), 34);
    });

    test('today counts once done, and never before', () {
      final h = habit(start: today.addDays(-29));
      final perfect = history(
        h,
        doneEvery(today.addDays(-29), today.addDays(-1)),
      );
      final withToday = history(h, doneEvery(today.addDays(-29), today));

      expect(consistencyScore([perfect], today: today), 100);
      expect(consistencyScore([withToday], today: today), 100);
    });

    test('none with fewer than 7 habit-days asked', () {
      final h = habit(start: today.addDays(-6));

      expect(consistencyScore([history(h)], today: today), isNull);
      expect(
        consistencyScore([
          history(habit(start: today.addDays(-7))),
        ], today: today),
        0,
      );
    });
  });

  test('the longest perfect run passes over days that ask nothing', () {
    final run = habit(schedule: monWedFri, start: oct(1));
    // Mon 5, Wed 7, Fri 9 done; Mon 12 missed; Wed 14, Fri 16 done.
    final h = history(run, [
      done(oct(5)),
      done(oct(7)),
      done(oct(9)),
      done(oct(14)),
      done(oct(16)),
    ]);

    expect(longestPerfectRun([h], today: today), 3);
  });

  group('the overview', () {
    final read = habit(
      id: 'read',
      start: oct(1),
    ).copyWith(title: 'Read', category: HabitCategory.reading);
    final water = habit(id: 'water', start: oct(1));
    final old = habit(
      id: 'old',
      start: CalendarDate(2026, 8, 1),
      archivedAt: DateTime.utc(2026, 9),
    );
    final overview = buildAnalytics([
      history(read, doneEvery(oct(1), oct(20), id: 'read')),
      history(water, doneEvery(oct(14), oct(20), id: 'water')),
      history(
        old,
        doneEvery(
          CalendarDate(2026, 8, 1),
          CalendarDate(2026, 8, 20),
          id: 'old',
        ),
      ),
    ], today: today);

    test('counts every completion, archived habits included', () {
      expect(overview.totalCompletions, 20 + 7 + 20);
      expect(overview.weekly, hasLength(8));
      expect(overview.weekly.last.count, 4, reason: 'Mon and Tue, two habits');
      expect(overview.monthly.map((m) => m.start.month), [5, 6, 7, 8, 9, 10]);
      expect(overview.monthly.map((m) => m.count), [0, 0, 0, 20, 0, 27]);
    });

    test('the best current streak is an active habit’s', () {
      expect(overview.bestStreak!.habit.id, 'read');
      expect(overview.bestStreak!.streak.current, 20);
    });

    test('the most successful habit has the best rate since its start', () {
      // Read: 20 of 20; water: 7 of 20 (it started on the 1st, done since the 14th).
      expect(overview.mostSuccessful!.habit.id, 'read');
    });

    test('categories are shares of all completions, most first', () {
      expect(overview.categories.first.category, HabitCategory.health);
      expect(overview.categories.first.count, 27);
      expect(overview.categories.last.ratio, closeTo(20 / 47, 1e-9));
    });

    test('the longest streaks, a week counted as seven days', () {
      final weekly = habit(
        id: 'weekly',
        schedule: const HabitSchedule.timesPerWeek(1),
        start: CalendarDate(2026, 8, 3),
      );
      final mixed = buildAnalytics([
        history(water, doneEvery(oct(14), oct(20), id: 'water')),
        history(weekly, [
          for (var w = 0; w < 5; w++)
            done(CalendarDate(2026, 8, 3).addDays(7 * w), id: 'weekly'),
        ]),
      ], today: today);

      expect(mixed.longestStreaks.map((e) => (e.habit.id, e.streak.unit)), [
        ('weekly', StreakUnit.weeks),
        ('water', StreakUnit.days),
      ]);
    });
  });
}
