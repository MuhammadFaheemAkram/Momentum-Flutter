import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/usecase/habit_day_rules.dart';

// What happens to a habit's day: complete (+1), skip, undo, and backfill.
// Each checks the same rules first (habit_day_rules.dart), so a stale
// screen or a deep link can't log an archived habit or a future day.

Future<Result<void>> _checked(
  HabitRepository habits,
  String habitId,
  CalendarDate day,
  CalendarDate today,
  Future<Result<void>> Function() write,
) async {
  try {
    await checkHabitDay(habits, habitId, day, today: today);
  } on AppException catch (exception) {
    return Err(exception);
  }
  return write();
}

/// One more check-in today: it completes a once-a-day habit, and adds one
/// to a counted one ("3 / 8" → "4 / 8").
@injectable
class AddCheckInUseCase {
  const AddCheckInUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(String habitId) {
    final today = _clock.today;
    return _checked(
      _habits,
      habitId,
      today,
      today,
      () => _logs.addCheckIn(habitId, today),
    );
  }
}

/// Skips today: neither done nor missed.
@injectable
class SkipHabitUseCase {
  const SkipHabitUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(String habitId) {
    final today = _clock.today;
    return _checked(
      _habits,
      habitId,
      today,
      today,
      () => _logs.skip(habitId, today),
    );
  }
}

/// Undo: today goes back to having no log.
@injectable
class ClearHabitDayUseCase {
  const ClearHabitDayUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(String habitId) {
    final today = _clock.today;
    return _checked(
      _habits,
      habitId,
      today,
      today,
      () => _logs.clear(habitId, today),
    );
  }
}

/// Backfill: marks [day] done (its full daily target) or not done (no
/// log), up to 30 days back.
@injectable
class SetHabitDayUseCase {
  const SetHabitDayUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(
    String habitId,
    CalendarDate day, {
    required bool done,
  }) async {
    final today = _clock.today;
    final Habit habit;
    try {
      habit = await checkHabitDay(_habits, habitId, day, today: today);
    } on AppException catch (exception) {
      return Err(exception);
    }
    return done
        ? _logs.putLog(
            HabitLog(habitId: habitId, day: day, count: habit.dailyTarget),
          )
        : _logs.clear(habitId, day);
  }
}

/// Puts a day back as it was before an action (a SnackBar's Undo):
/// [previous], or no log at all.
@injectable
class RestoreHabitDayUseCase {
  const RestoreHabitDayUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(
    String habitId,
    CalendarDate day,
    HabitLog? previous,
  ) => _checked(
    _habits,
    habitId,
    day,
    _clock.today,
    () => previous == null ? _logs.clear(habitId, day) : _logs.putLog(previous),
  );
}

/// "Mark done" on a reminder: today done, at its full daily target. A day
/// already done keeps its count ("9 / 8" stays 9).
@injectable
class MarkHabitDoneUseCase {
  const MarkHabitDoneUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Future<Result<void>> call(String habitId) async {
    final today = _clock.today;
    final Habit habit;
    try {
      habit = await checkHabitDay(_habits, habitId, today, today: today);
    } on AppException catch (exception) {
      return Err(exception);
    }
    final log = await _logs.findLog(habitId, today);
    if (log != null && !log.skipped && log.count >= habit.dailyTarget) {
      return const Ok(null);
    }
    return _logs.putLog(
      HabitLog(habitId: habitId, day: today, count: habit.dailyTarget),
    );
  }
}
