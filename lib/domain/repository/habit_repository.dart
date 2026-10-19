import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';

abstract interface class HabitRepository {
  /// Every habit in the user's order, archived ones too, on listen and after
  /// every change.
  Stream<List<Habit>> watchHabits();

  /// One habit; `null` once it's gone.
  Stream<Habit?> watchHabit(String id);

  Future<Habit?> findHabit(String id);

  /// Adds a habit at the end of the list.
  Future<Result<Habit>> createHabit(HabitDraft draft);

  /// Applies [draft] to the habit [id]; its history stays, and every figure
  /// is derived again from it.
  Future<Result<Habit>> updateHabit(String id, HabitDraft draft);

  Future<Result<void>> setArchived(String id, {required bool archived});

  /// Deletes the habit, its logs and its goals.
  Future<Result<void>> deleteHabit(String id);
}
