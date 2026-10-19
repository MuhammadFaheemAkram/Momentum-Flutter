import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'routines_dao.g.dart';

@DriftAccessor(tables: [Routines, RoutineItems, RoutineChecks])
class RoutinesDao extends DatabaseAccessor<AppDatabase>
    with _$RoutinesDaoMixin {
  RoutinesDao(super.attachedDatabase);

  Stream<List<RoutineRow>> watchRoutines() => (select(
    routines,
  )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).watch();

  /// Every routine's items, each routine's in its order.
  Stream<List<RoutineItemRow>> watchItems() =>
      (select(routineItems)..orderBy([
            (t) => OrderingTerm(expression: t.routineId),
            (t) => OrderingTerm(expression: t.sortOrder),
          ]))
          .watch();

  /// Every check-off. A few per day: small enough to watch whole, and the
  /// badges of Phase 5 read their history.
  Stream<List<RoutineCheckRow>> watchChecks() => select(routineChecks).watch();

  Future<RoutineRow?> findRoutine(String id) =>
      (select(routines)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<RoutineItemRow>> itemsOf(String routineId) =>
      (select(routineItems)
            ..where((t) => t.routineId.equals(routineId))
            ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
          .get();

  Future<int> nextSortOrder() async {
    final last = routines.sortOrder.max();
    final row = await (selectOnly(routines)..addColumns([last])).getSingle();
    return (row.read(last) ?? -1) + 1;
  }

  /// Writes [routine] with exactly [items], in their order, in **one
  /// transaction**: every item's position is rewritten together, so a
  /// reorder can never be half-saved. Items no longer in the list are
  /// deleted (their check-offs go with them); the others keep their ids,
  /// and so their check-offs.
  ///
  /// Upserts are `ON CONFLICT DO UPDATE`, never `INSERT OR REPLACE`: a
  /// replace would delete the row first and cascade its children away
  /// (conventions §11.53).
  Future<void> saveRoutine(RoutineRow routine, List<RoutineItemRow> items) {
    return transaction(() async {
      await into(routines).insertOnConflictUpdate(routine);
      await (delete(routineItems)..where(
            (t) =>
                t.routineId.equals(routine.id) &
                t.id.isNotIn([for (final item in items) item.id]),
          ))
          .go();
      for (final item in items) {
        await into(routineItems).insertOnConflictUpdate(item);
      }
    });
  }

  /// Deletes the routine; its items and their check-offs go with it.
  Future<int> deleteRoutine(String id) =>
      (delete(routines)..where((t) => t.id.equals(id))).go();

  /// Checks [itemId] off on [day], or not. Checking twice is one check.
  Future<void> setChecked(
    String itemId,
    CalendarDate day, {
    required bool checked,
  }) async {
    if (checked) {
      await into(routineChecks).insert(
        RoutineChecksCompanion.insert(itemId: itemId, day: day),
        mode: InsertMode.insertOrIgnore,
      );
    } else {
      await (delete(
        routineChecks,
      )..where((t) => t.itemId.equals(itemId) & t.day.equalsValue(day))).go();
    }
  }
}
