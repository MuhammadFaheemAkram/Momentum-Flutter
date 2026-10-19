import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';

part 'habits_dao.g.dart';

@DriftAccessor(tables: [Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.attachedDatabase);

  /// Every habit in the user's order, archived ones too.
  Stream<List<HabitRow>> watchAll() => (select(
    habits,
  )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).watch();

  Stream<HabitRow?> watchOne(String id) =>
      (select(habits)..where((t) => t.id.equals(id))).watchSingleOrNull();

  Future<HabitRow?> findOne(String id) =>
      (select(habits)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// The position after the last habit.
  Future<int> nextSortOrder() async {
    final last = habits.sortOrder.max();
    final row = await (selectOnly(habits)..addColumns([last])).getSingle();
    return (row.read(last) ?? -1) + 1;
  }

  Future<void> insertHabit(HabitRow row) => into(habits).insert(row);

  /// Rewrites every column of the habit with [row]'s id. An `UPDATE`, never
  /// `INSERT OR REPLACE`: replacing would delete the row first, and the
  /// cascade would take its logs and goals with it (conventions §11.53).
  /// Returns whether a habit was there to update.
  Future<bool> updateHabit(HabitRow row) => update(habits).replace(row);

  Future<int> setArchivedAt(String id, DateTime? archivedAt) =>
      (update(habits)..where((t) => t.id.equals(id))).write(
        HabitsCompanion(archivedAt: Value(archivedAt)),
      );

  /// Deletes the habit; its logs and goals go with it (`CASCADE`).
  Future<int> deleteHabit(String id) =>
      (delete(habits)..where((t) => t.id.equals(id))).go();
}
