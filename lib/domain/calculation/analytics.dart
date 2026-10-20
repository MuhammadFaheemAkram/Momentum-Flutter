import 'dart:math' as math;

import 'package:momentum/domain/calculation/completion_rate.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/analytics.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';

/// The consistency score: how reliably the habits got done over the last
/// 30 days, from 0 to 100, with the last 7 days counting twice. Recent days
/// say more about how things are going now, so a good week lifts a slow
/// month (and a slow week dents a good one).
///
/// It's the completion rate's own rules (skips and days off left out, today
/// counted only once done), so the two can't disagree. `null` until 7
/// habit-days have been asked for: a score from two days would mean
/// nothing.
int? consistencyScore(
  Iterable<HabitHistory> histories, {
  required CalendarDate today,
}) {
  final recent = completionRate(
    histories,
    from: today.addDays(-6),
    to: today,
    today: today,
  );
  final earlier = completionRate(
    histories,
    from: today.addDays(-29),
    to: today.addDays(-7),
    today: today,
  );
  if (recent.expected + earlier.expected < minimumScoredDays) return null;
  final weighted = 2 * recent.achieved + earlier.achieved;
  final possible = 2 * recent.expected + earlier.expected;
  return (weighted / possible * 100).round();
}

/// Habit-days the consistency score needs before it means anything.
const minimumScoredDays = 7;

/// The longest run of perfect days so far (days that ask nothing are
/// passed over, as in `perfectDayStreak`).
int longestPerfectRun(
  Iterable<HabitHistory> histories, {
  required CalendarDate today,
}) {
  final first = _firstStart(histories);
  if (first == null) return 0;
  var run = 0;
  var longest = 0;
  for (var day = first; day <= today; day = day.addDays(1)) {
    switch (isPerfectDay(histories, day, today: today)) {
      case true:
        longest = math.max(longest, ++run);
      case false:
        run = 0;
      case null:
        break;
    }
  }
  return longest;
}

/// Perfect days from [from] to today.
int perfectDaysSince(
  Iterable<HabitHistory> histories,
  CalendarDate from, {
  required CalendarDate today,
}) {
  var count = 0;
  for (var day = from; day <= today; day = day.addDays(1)) {
    if (isPerfectDay(histories, day, today: today) ?? false) count++;
  }
  return count;
}

/// The Analytics tab. [histories] are every habit's, archived ones too:
/// what they did still happened. Only the "best current streak" is about
/// the habits still going.
AnalyticsOverview buildAnalytics(
  List<HabitHistory> histories, {
  required CalendarDate today,
}) {
  final active = [
    for (final history in histories)
      if (history.habit.archivedAt == null) history,
  ];
  final doneDays = [
    for (final history in histories)
      for (final log in history.logs)
        if (history.isDoneOn(log.day) && log.day <= today)
          (history.habit.category, log.day),
  ];

  int doneIn(CalendarDate from, CalendarDate to) =>
      doneDays.where((d) => d.$2 >= from && d.$2 <= to).length;

  final streaks = [
    for (final history in histories)
      (history, habitStreak(history, today: today)),
  ];
  HabitStreakEntry? best;
  for (final (history, streak) in streaks) {
    if (history.habit.archivedAt != null || streak.current == 0) continue;
    if (best == null || streak.current > best.streak.current) {
      best = HabitStreakEntry(habit: history.habit, streak: streak);
    }
  }

  HabitRateEntry? mostSuccessful;
  for (final history in histories) {
    final rate = completionRate(
      [history],
      from: history.habit.startDate,
      to: today,
      today: today,
    );
    if (rate.expected < minimumScoredDays) continue;
    final current = mostSuccessful?.rate;
    if (current == null ||
        rate.ratio! > current.ratio! ||
        (rate.ratio == current.ratio && rate.achieved > current.achieved)) {
      mostSuccessful = HabitRateEntry(habit: history.habit, rate: rate);
    }
  }

  final byCategory = <HabitCategory, int>{};
  for (final (category, _) in doneDays) {
    byCategory[category] = (byCategory[category] ?? 0) + 1;
  }

  return AnalyticsOverview(
    today: today,
    rate30: completionRate(
      active,
      from: today.addDays(-29),
      to: today,
      today: today,
    ),
    consistencyScore: consistencyScore(active, today: today),
    bestStreak: best,
    totalCompletions: doneDays.length,
    perfectDaysThisMonth: perfectDaysSince(
      active,
      today.monthStart,
      today: today,
    ),
    weekly: [
      for (var w = 7; w >= 0; w--)
        () {
          final start = today.weekStart.addDays(-7 * w);
          return PeriodCount(
            start: start,
            count: doneIn(start, start.addDays(6)),
          );
        }(),
    ],
    monthly: [
      for (var m = 5; m >= 0; m--)
        () {
          final start = today.monthStart.addMonths(-m);
          return PeriodCount(
            start: start,
            count: doneIn(start, start.addMonths(1).addDays(-1)),
          );
        }(),
    ],
    longestStreaks: [
      for (final (history, streak) in streaks)
        if (streak.longest > 0)
          HabitStreakEntry(habit: history.habit, streak: streak),
      // Longest first, a week counted as seven days: a 5-week run of a
      // weekly habit outranks a 9-day one.
    ]..sort((a, b) => _inDays(b.streak).compareTo(_inDays(a.streak))),
    mostSuccessful: mostSuccessful,
    categories: [
      for (final MapEntry(key: category, value: count) in byCategory.entries)
        CategoryShare(category: category, count: count, total: doneDays.length),
    ]..sort((a, b) => b.count.compareTo(a.count)),
  );
}

CalendarDate? _firstStart(Iterable<HabitHistory> histories) {
  CalendarDate? first;
  for (final history in histories) {
    final start = history.habit.startDate;
    if (first == null || start < first) first = start;
  }
  return first;
}

int _inDays(HabitStreak streak) =>
    streak.unit == StreakUnit.weeks ? streak.longest * 7 : streak.longest;
