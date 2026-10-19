import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart';
import 'package:momentum/features/habit_actions/habit_day_actions.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';
import 'package:momentum/features/today/cubit/today_state.dart';

/// Today: live from the database, and again at midnight.
@injectable
class TodayCubit extends Cubit<TodayState> {
  TodayCubit(this._watchToday, this._actions) : super(const TodayState());

  final WatchTodayUseCase _watchToday;
  final HabitDayActions _actions;
  StreamSubscription<TodayOverview>? _subscription;

  /// Starts watching (again, after a failure).
  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: TodayStatus.loading));
    _subscription = _watchToday().listen(
      (overview) =>
          emit(state.copyWith(status: TodayStatus.ready, overview: overview)),
      onError: (Object error, StackTrace stackTrace) {
        log('Today failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: TodayStatus.failed));
      },
    );
  }

  Future<void> checkIn(HabitToday item) async =>
      _notify(await _actions.checkIn(item));

  Future<void> undo(HabitToday item) async =>
      _notify(await _actions.undo(item, today: state.overview!.today));

  Future<void> skip(HabitToday item) async =>
      _notify(await _actions.skip(item, today: state.overview!.today));

  /// The SnackBar's Undo.
  Future<void> undoNotice(HabitNotice notice) async =>
      _notify(await _actions.undoNotice(notice));

  void _notify(HabitNotice? notice) {
    if (notice == null || isClosed) return;
    emit(state.copyWith(notice: notice, noticeSerial: state.noticeSerial + 1));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
