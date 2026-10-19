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
