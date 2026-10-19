import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'goal.freezed.dart';

/// What a goal counts.
@freezed
sealed class GoalScope with _$GoalScope {
  /// Completions of any habit ("complete 25 habits this week").
  const factory GoalScope.allHabits() = AllHabits;

  /// Completions of one habit ("read on 20 days this month").
  const factory GoalScope.habit(String habitId) = OneHabit;
}

/// A target for a period. Its progress is never stored: it is counted from
/// the logs in the current window (today, this ISO week, this month), so a
/// new week starts from zero without any job resetting it.
@freezed
abstract class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String title,
    required GoalScope scope,
    required GoalPeriod period,

    /// 1–200.
    required int target,
    required CalendarDate createdOn,
    required DateTime createdAt,
  }) = _Goal;
}

/// What the goal sheet saves.
@freezed
abstract class GoalDraft with _$GoalDraft {
  const factory GoalDraft({
    required String title,
    required GoalScope scope,
    required GoalPeriod period,
    required int target,
  }) = _GoalDraft;

  factory GoalDraft.of(Goal goal) => GoalDraft(
    title: goal.title,
    scope: goal.scope,
    period: goal.period,
    target: goal.target,
  );
}

/// The days a goal counts in now: today, this ISO week, or this month.
@freezed
abstract class GoalWindow with _$GoalWindow {
  const factory GoalWindow({
    required CalendarDate start,
    required CalendarDate end,
  }) = _GoalWindow;

  const GoalWindow._();

  bool contains(CalendarDate day) => day >= start && day <= end;

  /// The day the goal starts over from zero.
  CalendarDate get resets => end.addDays(1);
}

/// A goal with its progress in the current window, derived when read.
@freezed
abstract class GoalProgress with _$GoalProgress {
  const factory GoalProgress({
    required Goal goal,
    required GoalWindow window,
    required int current,

    /// The habit a one-habit goal counts (null for all habits).
    String? habitTitle,
  }) = _GoalProgress;

  const GoalProgress._();

  bool get isMet => current >= goal.target;

  /// 0 to 1, capped at 1.
  double get ratio => (current / goal.target).clamp(0, 1).toDouble();
}
