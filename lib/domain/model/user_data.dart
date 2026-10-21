import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/routine.dart';

part 'user_data.freezed.dart';

/// Everything the user owns, in one value: what the demo loads, and what a
/// backup sends.
@freezed
abstract class UserData with _$UserData {
  const factory UserData({
    @Default(<Habit>[]) List<Habit> habits,
    @Default(<HabitLog>[]) List<HabitLog> logs,
    @Default(<Routine>[]) List<Routine> routines,
    @Default(<RoutineCheck>[]) List<RoutineCheck> routineChecks,
    @Default(<Goal>[]) List<Goal> goals,
    @Default(<AchievementUnlock>[]) List<AchievementUnlock> unlocks,
  }) = _UserData;
}
