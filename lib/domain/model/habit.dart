import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'habit.freezed.dart';

/// When a habit is due.
///
/// A sealed union, so every calculation over a schedule is an exhaustive
/// `switch` and a new kind of schedule can't be forgotten anywhere.
@freezed
sealed class HabitSchedule with _$HabitSchedule {
  /// Every day.
  const factory HabitSchedule.daily() = Daily;

  /// On the chosen [weekdays], 1 (Monday) to 7 (Sunday), as
  /// `DateTime.weekday`: at least one (checked by the form's validation and
  /// by the database).
  const factory HabitSchedule.onWeekdays(Set<int> weekdays) = OnWeekdays;

  /// [times] days in each ISO week (Monday to Sunday), any days. Judged per
  /// week, so a week of three runs is met whichever days they fall on.
  @Assert('times >= 1 && times <= 6', 'one to six times a week')
  const factory HabitSchedule.timesPerWeek(int times) = TimesPerWeek;
}

/// Something the user wants to do regularly.
///
/// Nothing derived is stored here: no streak, no completion rate. They are
/// calculated from the habit's logs when they are read, so they can never
/// disagree with the history, and editing the schedule re-derives them.
@freezed
abstract class Habit with _$Habit {
  const factory Habit({
    required String id,
    required String title,
    @Default('') String description,
    required HabitCategory category,
    required HabitColor color,
    required HabitIcon icon,
    required HabitSchedule schedule,

    /// Check-ins a day for the day to count as done ("8 glasses"): 1–20.
    @Default(1) int dailyTarget,

    /// The first day the habit can be due.
    required CalendarDate startDate,

    /// When to remind the user on a due day, if at all.
    TimeOfDayValue? reminder,

    /// When it was archived: an archived habit keeps its history and is
    /// never due.
    DateTime? archivedAt,
    required DateTime createdAt,

    /// The position in the user's list.
    required int sortOrder,
  }) = _Habit;
}
