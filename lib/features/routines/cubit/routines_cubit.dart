import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/usecase/routine_use_cases.dart';
import 'package:momentum/features/routines/cubit/routines_state.dart';

/// Routines with today's check-offs, live and again at midnight.
@injectable
class RoutinesCubit extends Cubit<RoutinesState> {
  RoutinesCubit(this._watchRoutines, this._toggle)
    : super(const RoutinesState());

  final WatchRoutinesUseCase _watchRoutines;
  final ToggleRoutineItemUseCase _toggle;
  StreamSubscription<Object?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: RoutinesStatus.loading));
    _subscription = _watchRoutines().listen(
      (data) => emit(
        state.copyWith(
          status: RoutinesStatus.ready,
          today: data.today,
          routines: data.routines,
        ),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Routines failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: RoutinesStatus.failed));
      },
    );
  }

  Future<void> toggle(RoutineItem item, {required bool checked}) async {
    final result = await _toggle(item.id, checked: checked);
    if (isClosed) return;
    if (result case Err(:final exception)) {
      emit(
        state.copyWith(
          message: exception.message,
          messageSerial: state.messageSerial + 1,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
