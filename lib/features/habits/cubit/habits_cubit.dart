import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart';
import 'package:momentum/features/habit_actions/habit_day_actions.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';
import 'package:momentum/features/habits/cubit/habits_state.dart';

/// The Habits tab: every habit, filtered in memory as the user types.
@injectable
class HabitsCubit extends Cubit<HabitsState> {
  HabitsCubit(this._watchHabits, this._actions) : super(const HabitsState());

  final WatchHabitsUseCase _watchHabits;
  final HabitDayActions _actions;
  StreamSubscription<Object?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: HabitsStatus.loading));
    _subscription = _watchHabits().listen(
      (list) => emit(
        state.copyWith(
          status: HabitsStatus.ready,
          today: list.today,
          habits: list.habits,
        ),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Habits failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: HabitsStatus.failed));
      },
    );
  }

  void search(String query) => emit(state.copyWith(query: query));

  void filterBy(HabitCategory? category) =>
      emit(state.copyWith(category: category));

  void showArchived({required bool show}) =>
      emit(state.copyWith(showArchived: show));

  Future<void> checkIn(HabitToday item) async =>
      _notify(await _actions.checkIn(item));

  Future<void> undo(HabitToday item) async =>
      _notify(await _actions.undo(item, today: state.today!));

  Future<void> skip(HabitToday item) async =>
      _notify(await _actions.skip(item, today: state.today!));

  Future<void> setArchived(HabitToday item, {required bool archived}) async =>
      _notify(await _actions.setArchived(item, archived: archived));

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
