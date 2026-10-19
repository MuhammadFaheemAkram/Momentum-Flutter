import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/repository/goal_repository.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/repository/routine_repository.dart';
import 'package:stream_transform/stream_transform.dart';

// The screens' live views: today's date, habits and logs, combined and
// derived again whenever any of them changes. drift re-runs a query when its
// table changes, so a check-in anywhere updates every screen.
//
// The clock comes first. drift's streams are broadcast, and `combineLatest`
// on a broadcast source wraps a single-subscription `other` (the clock) in
// `asBroadcastStream()`, which never cancels it: the clock, and its midnight
// timer, would outlive the screen (conventions §11.61).

/// Today: the ring, the perfect days, the week, today's habits, routines
/// and goals.
@injectable
class WatchTodayUseCase {
  const WatchTodayUseCase(
    this._habits,
    this._logs,
    this._routines,
    this._goals,
    this._clock,
  );

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final RoutineRepository _routines;
  final GoalRepository _goals;
  final CalendarClock _clock;

  Stream<TodayOverview> call() {
    final routines = _routines.watchRoutines().combineLatest(
      _routines.watchChecks(),
      (routines, checks) => (routines, checks),
    );
    final everything = _habitsAndLogs(_habits.watchHabits(), _logs.watchLogs())
        .combineLatest(routines, (habits, routines) => (habits, routines))
        .combineLatest(_goals.watchGoals(), (data, goals) => (data, goals));
    return _clock.watchToday().combineLatest(everything, (today, data) {
      final (((habits, logs), (routines, checks)), goals) = data;
      return buildTodayOverview(
        habits,
        logs,
        today: today,
        routines: routines,
        checks: checks,
        goals: goals,
      );
    });
  }
}

/// Every habit, archived ones too, as it stands today.
@injectable
class WatchHabitsUseCase {
  const WatchHabitsUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Stream<({CalendarDate today, List<HabitToday> habits})> call() =>
      _clock.watchToday().combineLatest(
        _habitsAndLogs(_habits.watchHabits(), _logs.watchLogs()),
        (today, data) => (
          today: today,
          habits: buildHabitList(data.$1, data.$2, today: today),
        ),
      );
}

/// One habit's page; `null` once the habit is gone.
@injectable
class WatchHabitDetailUseCase {
  const WatchHabitDetailUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Stream<HabitDetail?> call(String habitId) =>
      _clock.watchToday().combineLatest(
        _habits
            .watchHabit(habitId)
            .combineLatest(
              _logs.watchLogsFor(habitId),
              (habit, logs) => (habit, logs),
            ),
        (today, data) {
          final (habit, logs) = data;
          return habit == null
              ? null
              : buildHabitDetail(habit, logs, today: today);
        },
      );
}

Stream<(List<Habit>, List<HabitLog>)> _habitsAndLogs(
  Stream<List<Habit>> habits,
  Stream<List<HabitLog>> logs,
) => habits.combineLatest(logs, (habits, logs) => (habits, logs));
