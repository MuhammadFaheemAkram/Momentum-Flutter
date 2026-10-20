import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/first_value.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/common/settled_stream.dart';
import 'package:momentum/domain/calculation/achievements.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/repository/achievement_repository.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/repository/routine_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// Everything the badge rules read, with the unlocks so far: live, and
/// again at midnight (the clock first, conventions §11.61).
@injectable
class AchievementSources {
  const AchievementSources(
    this._habits,
    this._logs,
    this._routines,
    this._achievements,
    this._clock,
  );

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final RoutineRepository _routines;
  final AchievementRepository _achievements;
  final CalendarClock _clock;

  Stream<(AchievementInput, List<AchievementUnlock>)> watch() {
    final habits = _habits.watchHabits().combineLatest(
      _logs.watchLogs(),
      (habits, logs) => (habits, logs),
    );
    final routines = _routines.watchRoutines().combineLatest(
      _routines.watchChecks(),
      (routines, checks) => (routines, checks),
    );
    final everything = habits
        .combineLatest(routines, (h, r) => (h, r))
        .combineLatest(_achievements.watchUnlocks(), (d, u) => (d, u));
    return _clock.watchToday().combineLatest(everything, (today, data) {
      final (((habits, logs), (routines, checks)), unlocks) = data;
      return (
        AchievementInput(
          histories: _histories(habits, logs),
          routines: routines,
          checks: checks,
          today: today,
        ),
        unlocks,
      );
    });
  }

  /// The same, once.
  Future<(AchievementInput, List<AchievementUnlock>)> read() async {
    final (habits, logs, routines, checks, unlocks) = (
      await _habits.watchHabits().firstValue,
      await _logs.watchLogs().firstValue,
      await _routines.watchRoutines().firstValue,
      await _routines.watchChecks().firstValue,
      await _achievements.watchUnlocks().firstValue,
    );
    return (
      AchievementInput(
        histories: _histories(habits, logs),
        routines: routines,
        checks: checks,
        today: _clock.today,
      ),
      unlocks,
    );
  }

  static List<HabitHistory> _histories(
    List<Habit> habits,
    List<HabitLog> logs,
  ) {
    final byHabit = <String, List<HabitLog>>{};
    for (final log in logs) {
      (byHabit[log.habitId] ??= []).add(log);
    }
    return [
      for (final habit in habits)
        HabitHistory(habit, byHabit[habit.id] ?? const []),
    ];
  }
}

/// The Achievements tab: every badge with its progress and unlock.
@injectable
class WatchAchievementsUseCase {
  const WatchAchievementsUseCase(this._sources);

  final AchievementSources _sources;

  Stream<({CalendarDate today, List<AchievementStatus> statuses})> call() =>
      _sources.watch().map(
        (data) => (
          today: data.$1.today,
          statuses: achievementStatuses(data.$1, data.$2),
        ),
      );
}

/// Records the badges whose rules are met now but that aren't unlocked
/// yet, once each, and returns them. The background tasks run it (Phase 6);
/// the app watches with [WatchNewAchievementsUseCase].
@injectable
class EvaluateAchievementsUseCase {
  const EvaluateAchievementsUseCase(this._sources, this._achievements);

  final AchievementSources _sources;
  final AchievementRepository _achievements;

  Future<Result<List<AchievementId>>> call() async {
    final (input, unlocks) = await _sources.read();
    return _record(_achievements, input, unlocks);
  }
}

/// While the app runs: after every change to the history, the badges just
/// earned, recorded once each. This is how "after every write" works
/// without each write calling it: the database says something changed, and
/// the rules run again.
///
/// - **Debounced** ([settle]): a write that touches several tables (the
///   demo, a reset) arrives as a burst of changes; the rules run once it
///   settles, so its badges are celebrated together, not one by one.
/// - **One evaluation at a time** (`asyncMap`), so a badge can't be
///   recorded twice.
@injectable
class WatchNewAchievementsUseCase {
  const WatchNewAchievementsUseCase(
    this._sources,
    this._achievements, {
    @ignoreParam this.settle = const Duration(milliseconds: 300),
  });

  final AchievementSources _sources;
  final AchievementRepository _achievements;
  final Duration settle;

  Stream<List<AchievementId>> call() => _sources
      .watch()
      .settled(settle)
      .asyncMap((data) async {
        final result = await _record(_achievements, data.$1, data.$2);
        return switch (result) {
          Ok(:final value) => value,
          Err() => const <AchievementId>[],
        };
      })
      .where((recorded) => recorded.isNotEmpty);
}

Future<Result<List<AchievementId>>> _record(
  AchievementRepository achievements,
  AchievementInput input,
  List<AchievementUnlock> unlocks,
) async {
  final earned = newlyEarned(input, unlocks);
  if (earned.isEmpty) return const Ok([]);
  return achievements.recordUnlocks(earned);
}
