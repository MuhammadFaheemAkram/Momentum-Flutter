import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/calculation/completion_rate.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';

part 'habit_overviews.freezed.dart';

// What the screens show, derived from habits and logs when they are read
// (domain/calculation/overviews.dart builds them). Nothing here is stored.

/// A habit as it stands today: on Today, and in the Habits list.
@freezed
abstract class HabitToday with _$HabitToday {
  const factory HabitToday({
    required Habit habit,

    /// Today's log, if any.
    HabitLog? log,
    required DayState state,

    /// Whether today asks for it (it may be done, or skipped).
    required bool due,
    required HabitStreak streak,
  }) = _HabitToday;

  const HabitToday._();

  /// Today's check-ins (0 on a skip).
  int get count => switch (log) {
    HabitLog(skipped: false, :final count) => count,
    _ => 0,
  };
}

@freezed
abstract class TodaySummary with _$TodaySummary {
  const factory TodaySummary({
    /// Habits due today, not counting skips.
    required int due,

    /// Of those, done.
    required int done,
    required int perfectDays,

    /// Monday to Sunday of this week.
    required List<DayDot> week,
  }) = _TodaySummary;

  const TodaySummary._();

  /// The ring: done ÷ due, or null with nothing due.
  double? get ratio => due == 0 ? null : done / due;
}

@freezed
abstract class TodayOverview with _$TodayOverview {
  const factory TodayOverview({
    required CalendarDate today,
    required TodaySummary summary,

    /// Due today: not done first, then done, then skipped.
    required List<HabitToday> due,

    /// The rest: not due today (another weekday, or the week's target met).
    required List<HabitToday> notDue,
  }) = _TodayOverview;

  const TodayOverview._();

  bool get isEmpty => due.isEmpty && notDue.isEmpty;
}

/// A day in a habit's calendar heatmap.
@freezed
abstract class HeatmapDay with _$HeatmapDay {
  const factory HeatmapDay({
    required CalendarDate day,
    required DayState state,

    /// Whether tapping it may toggle it (backfill).
    required bool canSet,
  }) = _HeatmapDay;
}

/// One week's bar in a habit's chart: done days of the days it asked for.
@freezed
abstract class WeekBar with _$WeekBar {
  const factory WeekBar({
    required CalendarDate weekStart,
    required int done,
    required int target,
  }) = _WeekBar;
}

@freezed
abstract class HabitDetail with _$HabitDetail {
  const factory HabitDetail({
    required Habit habit,
    required CalendarDate today,
    required HabitStreak streak,

    /// Since the habit started.
    required CompletionRate rate,
    required int totalCompletions,

    /// Whole weeks, Monday to Sunday, oldest first; the last holds today.
    required List<HeatmapDay> heatmap,

    /// The last eight weeks, oldest first.
    required List<WeekBar> weeks,
  }) = _HabitDetail;
}
