import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/habit_use_cases.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';

/// Today's actions on a habit, shared by Today and the Habits list. Each
/// returns what to tell the user: nothing after a plain check-in, an Undo
/// after anything that throws away what the day held, and the reason when
/// it fails.
@injectable
class HabitDayActions {
  const HabitDayActions(
    this._addCheckIn,
    this._skip,
    this._clear,
    this._restore,
    this._setArchived,
  );

  final AddCheckInUseCase _addCheckIn;
  final SkipHabitUseCase _skip;
  final ClearHabitDayUseCase _clear;
  final RestoreHabitDayUseCase _restore;
  final SetHabitArchivedUseCase _setArchived;

  Future<HabitNotice?> checkIn(HabitToday item) async =>
      _failure(await _addCheckIn(item.habit.id));

  Future<HabitNotice?> undo(HabitToday item, {required CalendarDate today}) =>
      _undoable(
        _clear(item.habit.id),
        item,
        today,
        'Marked ${item.habit.title} not done',
      );

  Future<HabitNotice?> skip(HabitToday item, {required CalendarDate today}) =>
      _undoable(
        _skip(item.habit.id),
        item,
        today,
        'Skipped ${item.habit.title} today',
      );

  Future<HabitNotice?> setArchived(
    HabitToday item, {
    required bool archived,
  }) async {
    final result = await _setArchived(item.habit.id, archived: archived);
    if (_failure(result) case final failure?) return failure;
    return archived
        ? HabitNotice('Archived ${item.habit.title}', unarchive: item.habit.id)
        : HabitNotice('${item.habit.title} is back');
  }

  /// The SnackBar's Undo.
  Future<HabitNotice?> undoNotice(HabitNotice notice) async {
    if (notice.restore case final restore?) {
      return _failure(
        await _restore(restore.habitId, restore.day, restore.previous),
      );
    }
    if (notice.unarchive case final habitId?) {
      return _failure(await _setArchived(habitId, archived: false));
    }
    return null;
  }

  Future<HabitNotice?> _undoable(
    Future<Result<void>> action,
    HabitToday item,
    CalendarDate today,
    String message,
  ) async {
    if (_failure(await action) case final failure?) return failure;
    return HabitNotice(
      message,
      restore: DayRestore(
        habitId: item.habit.id,
        day: today,
        previous: item.log,
      ),
    );
  }

  static HabitNotice? _failure(Result<void> result) => switch (result) {
    Ok() => null,
    Err(:final exception) => HabitNotice(exception.message),
  };
}
