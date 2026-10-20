import 'dart:math' as math;

import 'package:momentum/domain/calculation/analytics.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';

/// Everything the badge rules read.
class AchievementInput {
  AchievementInput({
    required this.histories,
    required this.routines,
    required this.checks,
    required this.today,
  });

  /// Every habit's, archived ones too: what they did still counts.
  final List<HabitHistory> histories;
  final List<Routine> routines;
  final List<RoutineCheck> checks;
  final CalendarDate today;

  late final List<HabitHistory> active = [
    for (final history in histories)
      if (history.habit.archivedAt == null) history,
  ];

  late final int completions = histories.fold(
    0,
    (sum, history) => sum + history.totalCompletions,
  );

  /// The longest run, in days, of any habit counted in days.
  late final int longestDayStreak = histories.fold(0, (longest, history) {
    final streak = habitStreak(history, today: today);
    return streak.unit == StreakUnit.days
        ? math.max(longest, streak.longest)
        : longest;
  });
}

/// How far [id]'s rule is from being met. Each rule is a plain function of
/// the history, so each can be tested at its edge (6 days vs 7).
AchievementProgress achievementProgress(
  AchievementId id,
  AchievementInput input,
) {
  AchievementProgress of(int current, int target, AchievementMeasure measure) =>
      AchievementProgress(
        current: math.min(current, target),
        target: target,
        measure: measure,
      );

  return switch (id) {
    AchievementId.firstStep => of(
      input.completions,
      1,
      AchievementMeasure.completions,
    ),
    AchievementId.streak7 => of(
      input.longestDayStreak,
      7,
      AchievementMeasure.streakDays,
    ),
    AchievementId.streak30 => of(
      input.longestDayStreak,
      30,
      AchievementMeasure.streakDays,
    ),
    AchievementId.perfectWeek => of(
      longestPerfectRun(input.active, today: input.today),
      7,
      AchievementMeasure.perfectDays,
    ),
    AchievementId.century => of(
      input.completions,
      100,
      AchievementMeasure.completions,
    ),
    AchievementId.earlyBird => of(
      _morningRoutineDays(input),
      5,
      AchievementMeasure.routineDays,
    ),
    AchievementId.habitBuilder => of(
      input.active.length,
      5,
      AchievementMeasure.habits,
    ),
    AchievementId.consistencyMaster => _consistencyMaster(input),
    AchievementId.comeback => of(
      input.histories.where(_hasComeback(input.today)).length,
      1,
      AchievementMeasure.comebacks,
    ),
    AchievementId.allRounder => of(
      {
        for (final history in input.histories)
          if (history.totalCompletions > 0) history.habit.category,
      }.length,
      5,
      AchievementMeasure.categories,
    ),
  };
}

/// Every badge: its progress now, and its unlock if it was earned (an
/// unlock stays, whatever the progress does later).
List<AchievementStatus> achievementStatuses(
  AchievementInput input,
  List<AchievementUnlock> unlocks,
) {
  final byId = {for (final unlock in unlocks) unlock.achievementId: unlock};
  return [
    for (final id in AchievementId.values)
      AchievementStatus(
        id: id,
        progress: achievementProgress(id, input),
        unlock: byId[id.name],
      ),
  ];
}

/// The badges whose rule is met now but that aren't unlocked yet.
List<AchievementId> newlyEarned(
  AchievementInput input,
  List<AchievementUnlock> unlocks,
) {
  final unlocked = {for (final unlock in unlocks) unlock.achievementId};
  return [
    for (final id in AchievementId.values)
      if (!unlocked.contains(id.name) && achievementProgress(id, input).isMet)
        id,
  ];
}

/// The days a morning routine had every one of its steps checked off.
int _morningRoutineDays(AchievementInput input) {
  final checkedByDay = <CalendarDate, Set<String>>{};
  for (final check in input.checks) {
    (checkedByDay[check.day] ??= {}).add(check.itemId);
  }
  final days = <CalendarDate>{};
  for (final routine in input.routines) {
    if (routine.time != RoutineTime.morning || routine.items.isEmpty) continue;
    for (final MapEntry(key: day, value: checked) in checkedByDay.entries) {
      if (routine.items.every((item) => checked.contains(item.id))) {
        days.add(day);
      }
    }
  }
  return days.length;
}

/// A score of 80, once there are 30 days of history to judge by. Before
/// that, the progress is the history so far.
AchievementProgress _consistencyMaster(AchievementInput input) {
  const days = 30;
  const target = 80;
  CalendarDate? first;
  for (final history in input.active) {
    final start = history.habit.startDate;
    if (first == null || start < first) first = start;
  }
  final history = first == null ? 0 : first.daysUntil(input.today) + 1;
  if (history < days) {
    return AchievementProgress(
      current: math.max(0, history),
      target: days,
      measure: AchievementMeasure.historyDays,
    );
  }
  final score = consistencyScore(input.active, today: input.today) ?? 0;
  return AchievementProgress(
    current: math.min(score, target),
    target: target,
    measure: AchievementMeasure.score,
  );
}

/// A habit done again after at least a week away: a done day whose previous
/// done day was 8 or more days before, with at least one due day missed in
/// between (a week of skips, or of days off, isn't "away").
bool Function(HabitHistory) _hasComeback(CalendarDate today) => (history) {
  final done = [
    for (final log in history.logs)
      if (history.isDoneOn(log.day) && log.day <= today) log.day,
  ]..sort((a, b) => a.yyyymmdd.compareTo(b.yyyymmdd));
  for (var i = 1; i < done.length; i++) {
    final previous = done[i - 1];
    final next = done[i];
    if (previous.daysUntil(next) <= 7) continue;
    for (var day = previous.addDays(1); day < next; day = day.addDays(1)) {
      if (history.isDue(day) && !history.isSkippedOn(day)) return true;
    }
  }
  return false;
};
