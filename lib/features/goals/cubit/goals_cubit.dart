import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/usecase/goal_use_cases.dart';
import 'package:momentum/features/goals/cubit/goals_state.dart';

/// Goals with their progress now, by period; saved from the editor sheet.
@injectable
class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit(this._watchGoals, this._saveGoal, this._deleteGoal)
    : super(const GoalsState());

  final WatchGoalsUseCase _watchGoals;
  final SaveGoalUseCase _saveGoal;
  final DeleteGoalUseCase _deleteGoal;
  StreamSubscription<Object?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: GoalsStatus.loading));
    _subscription = _watchGoals().listen(
      (data) => emit(
        state.copyWith(
          status: GoalsStatus.ready,
          today: data.today,
          goals: data.goals,
          habits: data.habits,
        ),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Goals failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: GoalsStatus.failed));
      },
    );
  }

  void showPeriod(GoalPeriod period) => emit(state.copyWith(period: period));

  /// Saves [draft] (new, or [id]'s) and shows its period.
  Future<void> save(GoalDraft draft, {String? id}) async {
    final result = await _saveGoal(draft, id: id);
    if (isClosed) return;
    switch (result) {
      case Ok():
        emit(state.copyWith(period: draft.period));
        _say(id == null ? 'Added ${draft.title.trim()}' : 'Saved');
      case Err(:final exception):
        _say(exception.message);
    }
  }

  Future<void> delete(Goal goal) async {
    final result = await _deleteGoal(goal.id);
    if (isClosed) return;
    _say(switch (result) {
      Ok() => 'Deleted ${goal.title}',
      Err(:final exception) => exception.message,
    });
  }

  void _say(String message) => emit(
    state.copyWith(message: message, messageSerial: state.messageSerial + 1),
  );

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
