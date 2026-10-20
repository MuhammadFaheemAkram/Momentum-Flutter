import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/calculation/completion_rate.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'analytics.freezed.dart';

/// Done habit-days in a period that starts on [start] (a week or a month).
@freezed
abstract class PeriodCount with _$PeriodCount {
  const factory PeriodCount({required CalendarDate start, required int count}) =
      _PeriodCount;
}

/// A habit with a figure about it: its streak, its rate.
@freezed
abstract class HabitStreakEntry with _$HabitStreakEntry {
  const factory HabitStreakEntry({
    required Habit habit,
    required HabitStreak streak,
  }) = _HabitStreakEntry;
}

@freezed
abstract class HabitRateEntry with _$HabitRateEntry {
  const factory HabitRateEntry({
    required Habit habit,
    required CompletionRate rate,
  }) = _HabitRateEntry;
}

/// Done habit-days in one category, of all of them.
@freezed
abstract class CategoryShare with _$CategoryShare {
  const factory CategoryShare({
    required HabitCategory category,
    required int count,
    required int total,
  }) = _CategoryShare;

  const CategoryShare._();

  double get ratio => total == 0 ? 0 : count / total;
}

/// The Analytics tab, derived from the history when it's read.
@freezed
abstract class AnalyticsOverview with _$AnalyticsOverview {
  const factory AnalyticsOverview({
    required CalendarDate today,

    /// The last 30 days.
    required CompletionRate rate30,

    /// 0–100, or null with too little history.
    int? consistencyScore,

    /// The active habit with the longest current streak.
    HabitStreakEntry? bestStreak,
    required int totalCompletions,
    required int perfectDaysThisMonth,

    /// The last 8 ISO weeks, oldest first.
    required List<PeriodCount> weekly,

    /// The last 6 months, oldest first.
    required List<PeriodCount> monthly,

    /// Each habit's longest run, longest first.
    required List<HabitStreakEntry> longestStreaks,

    /// The best completion rate since its start (with enough history).
    HabitRateEntry? mostSuccessful,

    /// All-time done days by category, most first.
    required List<CategoryShare> categories,
  }) = _AnalyticsOverview;

  const AnalyticsOverview._();

  bool get isEmpty => totalCompletions == 0 && longestStreaks.isEmpty;
}
