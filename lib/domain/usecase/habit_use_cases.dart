import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

@injectable
class FindHabitUseCase {
  const FindHabitUseCase(this._habits);

  final HabitRepository _habits;

  Future<Habit?> call(String id) => _habits.findHabit(id);
}

/// Creates a habit ([id] null) or updates [id]'s. The draft is checked
/// against the same rules the form shows, so nothing invalid is saved
/// whatever calls it.
@injectable
class SaveHabitUseCase {
  const SaveHabitUseCase(this._habits);

  final HabitRepository _habits;

  Future<Result<Habit>> call(HabitDraft draft, {String? id}) async {
    if (habitDraftError(draft) case final problem?) {
      return Err(InvalidInputException(problem));
    }
    return id == null
        ? _habits.createHabit(draft)
        : _habits.updateHabit(id, draft);
  }
}

/// Archives (or brings back) a habit. Its history stays; an archived habit
/// is never due, so its streaks and Today's figures leave it out.
@injectable
class SetHabitArchivedUseCase {
  const SetHabitArchivedUseCase(this._habits);

  final HabitRepository _habits;

  Future<Result<void>> call(String id, {required bool archived}) =>
      _habits.setArchived(id, archived: archived);
}

/// Deletes a habit with its history and its goals (the screen confirms
/// first: there is no undo).
@injectable
class DeleteHabitUseCase {
  const DeleteHabitUseCase(this._habits);

  final HabitRepository _habits;

  Future<Result<void>> call(String id) => _habits.deleteHabit(id);
}
