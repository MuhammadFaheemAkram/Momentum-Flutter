import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';

part 'goals_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.attachedDatabase);

  /// In the order they were set (the id breaks ties: conventions §11.60).
  Stream<List<GoalRow>> watchGoals() =>
      (select(goals)..orderBy([
            (t) => OrderingTerm(expression: t.createdAt),
            (t) => OrderingTerm(expression: t.id),
          ]))
          .watch();

  Future<GoalRow?> findGoal(String id) =>
      (select(goals)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertGoal(GoalRow row) => into(goals).insert(row);

  /// Rewrites every column, nulls included: a goal moved from one habit to
  /// all habits must lose its `habit_id` (an upsert from a row would leave
  /// the null unwritten, conventions §11.57).
  Future<bool> updateGoal(GoalRow row) => update(goals).replace(row);

  Future<int> deleteGoal(String id) =>
      (delete(goals)..where((t) => t.id.equals(id))).go();
}
