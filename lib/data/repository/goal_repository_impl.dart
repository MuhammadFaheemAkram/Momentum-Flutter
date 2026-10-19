import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/goals_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/repository/goal_repository.dart';

@LazySingleton(as: GoalRepository)
class GoalRepositoryImpl implements GoalRepository {
  const GoalRepositoryImpl(this._goals, this._ids, this._clock);

  final GoalsDao _goals;
  final IdGenerator _ids;
  final Clock _clock;

  @override
  Stream<List<Goal>> watchGoals() => _goals.watchGoals().map(
    (rows) => [for (final row in rows) row.toDomain()],
  );

  @override
  Future<Result<Goal>> saveGoal(GoalDraft draft, {String? id}) =>
      guardWrite('Saving a goal', () async {
        if (id == null) {
          final now = _clock.now();
          final goal = Goal(
            id: _ids.next('goal'),
            title: draft.title.trim(),
            scope: draft.scope,
            period: draft.period,
            target: draft.target,
            createdOn: CalendarDate.fromDateTime(now),
            createdAt: now.toUtc(),
          );
          await _goals.insertGoal(goal.toRow());
          return goal;
        }
        final existing = await _goals.findGoal(id);
        if (existing == null) throw const NotFoundException('goal');
        final goal = existing.toDomain().copyWith(
          title: draft.title.trim(),
          scope: draft.scope,
          period: draft.period,
          target: draft.target,
        );
        await _goals.updateGoal(goal.toRow());
        return goal;
      });

  @override
  Future<Result<void>> deleteGoal(String id) =>
      guardWrite('Deleting a goal', () async {
        await _goals.deleteGoal(id);
      });
}
