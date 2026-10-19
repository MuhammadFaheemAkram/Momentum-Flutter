import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/habit_use_cases.dart';
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_state.dart';

/// One habit's page, live: a backfilled day or an edit shows at once.
@injectable
class HabitDetailCubit extends Cubit<HabitDetailState> {
  HabitDetailCubit(
    this._watchDetail,
    this._setDay,
    this._setArchived,
    this._delete,
    @factoryParam this.habitId,
  ) : super(const HabitDetailState());

  final WatchHabitDetailUseCase _watchDetail;
  final SetHabitDayUseCase _setDay;
  final SetHabitArchivedUseCase _setArchived;
  final DeleteHabitUseCase _delete;
  final String habitId;
  StreamSubscription<HabitDetail?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: HabitDetailStatus.loading));
    _subscription = _watchDetail(habitId).listen(
      (detail) => emit(
        state.copyWith(
          status: detail == null
              ? HabitDetailStatus.notFound
              : HabitDetailStatus.ready,
          detail: detail,
        ),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Habit detail failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: HabitDetailStatus.failed));
      },
    );
  }

  /// Backfill: a done day becomes not done, any other becomes done.
  Future<void> toggleDay(HeatmapDay day) async {
    _report(await _setDay(habitId, day.day, done: day.state != DayState.done));
  }

  Future<void> setArchived({required bool archived}) async {
    final result = await _setArchived(habitId, archived: archived);
    if (_report(result)) {
      final title = state.detail?.habit.title ?? '';
      _say(archived ? 'Archived $title' : '$title is back');
    }
  }

  Future<void> delete() async {
    if (_report(await _delete(habitId))) {
      await _subscription?.cancel();
      if (!isClosed) emit(state.copyWith(deleted: true));
    }
  }

  /// True on success; on failure, says why.
  bool _report(Result<void> result) {
    if (result case Err(:final exception)) {
      _say(exception.message);
      return false;
    }
    return true;
  }

  void _say(String message) {
    if (isClosed) return;
    emit(
      state.copyWith(message: message, messageSerial: state.messageSerial + 1),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
