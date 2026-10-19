import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/repository/goal_repository.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// Every goal with its progress now, and every habit (the sheet's choices),
/// live and again at midnight (clock first: §11.61).
@injectable
class WatchGoalsUseCase {
  const WatchGoalsUseCase(this._goals, this._habits, this._logs, this._clock);

  final GoalRepository _goals;
  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Stream<({CalendarDate today, List<GoalProgress> goals, List<Habit> habits})>
  call() => _clock.watchToday().combineLatest(
    _goals.watchGoals().combineLatest(
      _habits.watchHabits().combineLatest(
        _logs.watchLogs(),
        (habits, logs) => (habits, logs),
      ),
      (goals, data) => (goals, data.$1, data.$2),
    ),
    (today, data) {
      final (goals, habits, logs) = data;
      return (
        today: today,
        goals: buildGoalList(goals, habits, logs, today: today),
        habits: habits,
      );
    },
  );
}

/// Creates or updates a goal after checking the sheet's rules.
@injectable
class SaveGoalUseCase {
  const SaveGoalUseCase(this._goals);

  final GoalRepository _goals;

  Future<Result<Goal>> call(GoalDraft draft, {String? id}) async {
    if (goalDraftError(draft) case final problem?) {
      return Err(InvalidInputException(problem));
    }
    return _goals.saveGoal(draft, id: id);
  }
}

@injectable
class DeleteGoalUseCase {
  const DeleteGoalUseCase(this._goals);

  final GoalRepository _goals;

  Future<Result<void>> call(String id) => _goals.deleteGoal(id);
}
