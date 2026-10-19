import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/data/mapper/demo_mappers.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

import '../helpers/data_stack.dart';
import '../helpers/database.dart';
import '../helpers/test_dependencies.dart';

// The demo that ships in assets/json/demo.json, through the real service,
// mapper and database.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DemoDto demo;

  setUpAll(() async => demo = await bundledDemo());

  test('loads into the database whatever the day of the week', () async {
    // Its weeks are counted back from today's, so each weekday cuts the
    // current week at a different place.
    for (var offset = 0; offset < 7; offset++) {
      final now = DateTime(2026, 10, 19 + offset, 15);
      final db = newTestDatabase();
      await db.userDataDao.replaceAll(demo.toUserData(now: now).toRows());
      final stored = await db.userDataDao.readAll();
      await db.close();

      expect(stored.habits, hasLength(6), reason: '$now');
      final latest = stored.logs
          .map((l) => l.day)
          .reduce((a, b) => a > b ? a : b);
      expect(latest, CalendarDate.fromDateTime(now), reason: '$now');
    }
    // Just after midnight on a Monday, the first moment of a week.
    expect(
      () => demo.toUserData(now: DateTime(2026, 10, 19, 0, 1)),
      returnsNormally,
    );
  });

  group('as of $demoNow', () {
    final today = CalendarDate.fromDateTime(demoNow);
    late final data = demo.toUserData(now: demoNow);

    test('has the six habits, in every kind of schedule', () {
      expect(
        [for (final habit in data.habits) (habit.title, habit.schedule)],
        [
          ('Drink water', const HabitSchedule.daily()),
          ('Morning run', const HabitSchedule.onWeekdays({1, 3, 5})),
          ('Read 20 pages', const HabitSchedule.daily()),
          ('Learn Spanish', const HabitSchedule.timesPerWeek(5)),
          ('No-spend day', const HabitSchedule.timesPerWeek(3)),
          ('Plan tomorrow', const HabitSchedule.onWeekdays({1, 2, 3, 4, 5})),
        ],
      );
      expect(data.habits.first.dailyTarget, 8);
      expect(data.habits.map((h) => h.category).toSet(), hasLength(6));
    });

    test('covers eight weeks, with gaps and a few skips', () {
      final earliest = data.logs
          .map((l) => l.day)
          .reduce((a, b) => a < b ? a : b);
      expect(earliest, today.weekStart.addDays(-56));

      final skips = data.logs.where((l) => l.skipped).length;
      expect(skips, inInclusiveRange(3, 6));
      // A daily habit with gaps: fewer logs than days.
      final readDays = data.logs.where((l) => l.habitId == 'habit_read').length;
      expect(readDays, lessThan(today.weekStart.addDays(-56).daysUntil(today)));
    });

    test('logs a weekday habit only on its days', () {
      for (final habit in data.habits) {
        if (habit.schedule case OnWeekdays(:final weekdays)) {
          final days = data.logs
              .where((l) => l.habitId == habit.id)
              .map((l) => l.day.weekday);
          expect(days.every(weekdays.contains), isTrue, reason: habit.title);
        }
      }
    });

    test('has yesterday done for the daily habits, so streaks are live', () {
      final yesterday = today.addDays(-1);
      for (final id in ['habit_water', 'habit_read']) {
        final log = data.logs.singleWhere(
          (l) => l.habitId == id && l.day == yesterday,
        );
        final habit = data.habits.singleWhere((h) => h.id == id);
        expect(log.count, greaterThanOrEqualTo(habit.dailyTarget), reason: id);
      }
    });

    test('leaves something to do today', () {
      final water = data.logs.singleWhere(
        (l) => l.habitId == 'habit_water' && l.day == today,
      );
      expect(water.count, 3);
      expect(
        data.logs.where((l) => l.habitId == 'habit_read' && l.day == today),
        isEmpty,
      );
    });

    test('has a morning routine of four items and an evening one of three', () {
      expect(
        [for (final r in data.routines) (r.title, r.time, r.items.length)],
        [
          ('Morning', RoutineTime.morning, 4),
          ('Evening', RoutineTime.evening, 3),
        ],
      );
      expect(data.routineChecks.where((c) => c.day == today), hasLength(2));
    });

    test('has three goals: all habits and one habit, each period', () {
      expect(
        [for (final goal in data.goals) (goal.period, goal.scope)],
        [
          (GoalPeriod.weekly, const GoalScope.allHabits()),
          (GoalPeriod.monthly, const GoalScope.habit('habit_read')),
          (GoalPeriod.daily, const GoalScope.allHabits()),
        ],
      );
    });

    test('has no badges: they are earned, not loaded', () {
      expect(data.unlocks, isEmpty);
    });
  });
}
