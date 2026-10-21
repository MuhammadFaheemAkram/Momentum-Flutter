import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';

part 'user_data_dao.g.dart';

/// Every user table's rows: what the demo writes and what a backup reads. Rows, not companions, so writing and reading back give the
/// same value.
class UserRows {
  const UserRows({
    this.habits = const [],
    this.logs = const [],
    this.routines = const [],
    this.routineItems = const [],
    this.routineChecks = const [],
    this.goals = const [],
    this.unlocks = const [],
  });

  final List<HabitRow> habits;
  final List<HabitLogRow> logs;
  final List<RoutineRow> routines;
  final List<RoutineItemRow> routineItems;
  final List<RoutineCheckRow> routineChecks;
  final List<GoalRow> goals;
  final List<AchievementUnlockRow> unlocks;
}

/// Reads and writes that cover all of the user's tables at once.
@DriftAccessor(
  tables: [
    Habits,
    HabitLogs,
    Routines,
    RoutineItems,
    RoutineChecks,
    Goals,
    AchievementUnlocks,
  ],
)
class UserDataDao extends DatabaseAccessor<AppDatabase>
    with _$UserDataDaoMixin {
  UserDataDao(super.attachedDatabase);

  /// Replaces everything with [rows] in **one transaction**: it lands
  /// completely or not at all, and running it twice gives the same result.
  Future<void> replaceAll(UserRows rows) {
    return transaction(() async {
      // Parents last: the cascades would empty the children anyway, but
      // deleting each table explicitly doesn't depend on them.
      for (final table in <TableInfo<Table, Object?>>[
        routineChecks,
        routineItems,
        routines,
        habitLogs,
        goals,
        habits,
        achievementUnlocks,
      ]) {
        await delete(table).go();
      }
      await batch((batch) {
        batch
          ..insertAll(habits, rows.habits)
          ..insertAll(habitLogs, rows.logs)
          ..insertAll(routines, rows.routines)
          ..insertAll(routineItems, rows.routineItems)
          ..insertAll(routineChecks, rows.routineChecks)
          ..insertAll(goals, rows.goals)
          ..insertAll(achievementUnlocks, rows.unlocks);
      });
    });
  }

  /// Deletes the history (logs, routine check-offs, badge unlocks) in
  /// **one transaction**; habits, routines and goals stay. Nothing derived
  /// needs resetting: streaks, rates and goal progress are counted from the
  /// logs, so they start from zero with them.
  Future<void> resetProgress() {
    return transaction(() async {
      await delete(habitLogs).go();
      await delete(routineChecks).go();
      await delete(achievementUnlocks).go();
    });
  }

  /// Every row, in a stable order, read in one transaction so the tables
  /// agree with each other.
  Future<UserRows> readAll() {
    return transaction(() async {
      return UserRows(
        habits: await (select(
          habits,
        )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get(),
        logs:
            await (select(habitLogs)..orderBy([
                  (t) => OrderingTerm(expression: t.habitId),
                  (t) => OrderingTerm(expression: t.day),
                ]))
                .get(),
        routines: await (select(
          routines,
        )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get(),
        routineItems:
            await (select(routineItems)..orderBy([
                  (t) => OrderingTerm(expression: t.routineId),
                  (t) => OrderingTerm(expression: t.sortOrder),
                ]))
                .get(),
        routineChecks:
            await (select(routineChecks)..orderBy([
                  (t) => OrderingTerm(expression: t.itemId),
                  (t) => OrderingTerm(expression: t.day),
                ]))
                .get(),
        // Instants are text that sorts in time order only to the
        // millisecond (conventions §11.60): the id breaks ties.
        goals:
            await (select(goals)..orderBy([
                  (t) => OrderingTerm(expression: t.createdAt),
                  (t) => OrderingTerm(expression: t.id),
                ]))
                .get(),
        unlocks:
            await (select(achievementUnlocks)..orderBy([
                  (t) => OrderingTerm(expression: t.unlockedAt),
                  (t) => OrderingTerm(expression: t.achievementId),
                ]))
                .get(),
      );
    });
  }
}
