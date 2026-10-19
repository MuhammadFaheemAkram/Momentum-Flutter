import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/goal.dart';

abstract interface class GoalRepository {
  Stream<List<Goal>> watchGoals();

  /// Creates a goal ([id] null), set today, or updates [id]'s.
  Future<Result<Goal>> saveGoal(GoalDraft draft, {String? id});

  Future<Result<void>> deleteGoal(String id);
}
