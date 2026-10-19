import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'goals_state.freezed.dart';

enum GoalsStatus { loading, ready, failed }

@freezed
abstract class GoalsState with _$GoalsState {
  const factory GoalsState({
    @Default(GoalsStatus.loading) GoalsStatus status,
    CalendarDate? today,
    @Default(<GoalProgress>[]) List<GoalProgress> goals,

    /// Every habit, for the sheet's choices.
    @Default(<Habit>[]) List<Habit> habits,

    /// The period shown.
    @Default(GoalPeriod.weekly) GoalPeriod period,
    String? message,
    @Default(0) int messageSerial,
  }) = _GoalsState;

  const GoalsState._();

  List<GoalProgress> get visible => [
    for (final progress in goals)
      if (progress.goal.period == period) progress,
  ];

  int countFor(GoalPeriod period) =>
      goals.where((progress) => progress.goal.period == period).length;
}
