import 'package:drift/drift.dart';
import 'package:drift/native.dart' show SqliteException;
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

import '../../helpers/database.dart';
import '../../helpers/user_data_fixtures.dart';

// The schema's own rules: whatever code writes a row, SQLite refuses one
// that breaks them.
void main() {
  late AppDatabase db;

  setUp(() async {
    db = newTestDatabase();
    await db.userDataDao.replaceAll(fullUserData().toRows());
  });
  tearDown(() => db.close());

  final refused = throwsA(isA<SqliteException>());

  Future<void> insertHabit(HabitRow row) => db.into(db.habits).insert(row);

  final daily = habitFixture(id: 'new').toRow();

  group('a habit', () {
    test('has a daily target of 1–20', () async {
      await expectLater(insertHabit(daily.copyWith(dailyTarget: 0)), refused);
      await expectLater(insertHabit(daily.copyWith(dailyTarget: 21)), refused);
      await insertHabit(daily.copyWith(dailyTarget: 20));
    });

    test('on weekdays has at least one, and only real ones', () async {
      final onWeekdays = habitFixture(
        id: 'new',
        schedule: const HabitSchedule.onWeekdays({2}),
      ).toRow();

      await expectLater(insertHabit(onWeekdays.copyWith(weekdays: 0)), refused);
      await expectLater(
        insertHabit(onWeekdays.copyWith(weekdays: 128)),
        refused,
      );
      await insertHabit(onWeekdays.copyWith(weekdays: 127));
    });

    test('keeps only the columns its schedule needs', () async {
      await expectLater(insertHabit(daily.copyWith(weekdays: 1)), refused);
      await expectLater(
        insertHabit(daily.copyWith(timesPerWeek: const Value(3))),
        refused,
      );
      await expectLater(
        insertHabit(daily.copyWith(scheduleType: ScheduleType.timesPerWeek)),
        refused,
      );
    });

    test('is due one to six times a week', () async {
      final weekly = habitFixture(
        id: 'new',
        schedule: const HabitSchedule.timesPerWeek(3),
      ).toRow();

      await expectLater(
        insertHabit(weekly.copyWith(timesPerWeek: const Value(0))),
        refused,
      );
      await expectLater(
        insertHabit(weekly.copyWith(timesPerWeek: const Value(7))),
        refused,
      );
    });

    test('has a reminder at a real HH:mm time, or none', () async {
      for (final text in ['7:00', '24:00', '12:60', 'noon']) {
        await expectLater(
          db.customStatement(
            "UPDATE habits SET reminder_time = '$text' WHERE id = 'water'",
          ),
          refused,
          reason: text,
        );
      }
      await db.customStatement(
        "UPDATE habits SET reminder_time = '23:59' WHERE id = 'water'",
      );
    });
  });

  group('a log', () {
    Future<void> insertLog(HabitLogsCompanion log) =>
        db.into(db.habitLogs).insert(log);

    test('is one per habit per day (the primary key)', () async {
      await expectLater(
        insertLog(
          HabitLogsCompanion.insert(
            habitId: 'water',
            day: fixtureDay,
            count: 1,
          ),
        ),
        refused,
      );
    });

    test('is a skip with no check-ins, or at least one check-in', () async {
      final day = fixtureDay.addDays(-5);
      await expectLater(
        insertLog(
          HabitLogsCompanion.insert(habitId: 'water', day: day, count: 0),
        ),
        refused,
      );
      await expectLater(
        insertLog(
          HabitLogsCompanion.insert(
            habitId: 'water',
            day: day,
            count: 2,
            skipped: const Value(true),
          ),
        ),
        refused,
      );
      await expectLater(
        insertLog(
          HabitLogsCompanion.insert(habitId: 'water', day: day, count: -1),
        ),
        refused,
      );
    });

    test('belongs to a habit that exists', () async {
      await expectLater(
        insertLog(
          HabitLogsCompanion.insert(habitId: 'nope', day: fixtureDay, count: 1),
        ),
        refused,
      );
    });
  });

  group('a goal', () {
    final goal = GoalsCompanion.insert(
      id: 'new',
      title: 'New',
      kind: GoalKind.allHabits,
      period: GoalPeriod.daily,
      target: 1,
      createdOn: fixtureDay,
      createdAt: fixtureAt,
    );

    test('has a target of 1–200', () async {
      await expectLater(
        db.into(db.goals).insert(goal.copyWith(target: const Value(0))),
        refused,
      );
      await expectLater(
        db.into(db.goals).insert(goal.copyWith(target: const Value(201))),
        refused,
      );
    });

    test('names a habit exactly when it counts one', () async {
      await expectLater(
        db.into(db.goals).insert(goal.copyWith(habitId: const Value('water'))),
        refused,
      );
      await expectLater(
        db
            .into(db.goals)
            .insert(goal.copyWith(kind: const Value(GoalKind.habit))),
        refused,
      );
      await expectLater(
        db
            .into(db.goals)
            .insert(
              goal.copyWith(
                kind: const Value(GoalKind.habit),
                habitId: const Value('nope'),
              ),
            ),
        refused,
      );
    });
  });

  test('an achievement is unlocked once (the primary key)', () async {
    await expectLater(
      db
          .into(db.achievementUnlocks)
          .insert(
            AchievementUnlocksCompanion.insert(
              achievementId: 'first_step',
              unlockedOn: fixtureDay,
              unlockedAt: fixtureAt,
            ),
          ),
      refused,
    );
  });

  group('deleting', () {
    test('a habit deletes its logs and its goals, and nothing else', () async {
      await (db.delete(db.habits)..where((t) => t.id.equals('water'))).go();

      final logs = await db.select(db.habitLogs).get();
      final goals = await db.select(db.goals).get();
      expect(logs.map((l) => l.habitId), ['run']);
      expect(goals.map((g) => g.id), ['week']);
    });

    test('a routine deletes its items and their checks', () async {
      await (db.delete(db.routines)..where((t) => t.id.equals('morning'))).go();

      expect(await db.select(db.routineItems).get(), isEmpty);
      expect(await db.select(db.routineChecks).get(), isEmpty);
    });

    test('an item deletes its checks', () async {
      await (db.delete(db.routineItems)..where((t) => t.id.equals('bed'))).go();

      final checks = await db.select(db.routineChecks).get();
      expect(checks.map((c) => c.itemId), ['stretch']);
    });
  });
}
