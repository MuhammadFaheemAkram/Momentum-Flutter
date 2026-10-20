import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/routine.dart';

part 'search.freezed.dart';

/// What a search found, by kind, each in the order its screen lists them.
@freezed
abstract class SearchResults with _$SearchResults {
  const factory SearchResults({
    @Default(<Habit>[]) List<Habit> habits,
    @Default(<Routine>[]) List<Routine> routines,
    @Default(<Goal>[]) List<Goal> goals,
    @Default(<AchievementId>[]) List<AchievementId> achievements,
  }) = _SearchResults;

  const SearchResults._();

  int get count =>
      habits.length + routines.length + goals.length + achievements.length;

  bool get isEmpty => count == 0;
}
