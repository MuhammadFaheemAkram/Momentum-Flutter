import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'habit_draft.freezed.dart';

/// What the habit form saves: the fields a user chooses. The rest (id,
/// creation time, position, archive state) belong to the stored habit.
@freezed
abstract class HabitDraft with _$HabitDraft {
  const factory HabitDraft({
    required String title,
    @Default('') String description,
    required HabitCategory category,
    required HabitColor color,
    required HabitIcon icon,
    required HabitSchedule schedule,
    @Default(1) int dailyTarget,
    required CalendarDate startDate,
    TimeOfDayValue? reminder,
  }) = _HabitDraft;

  /// [habit]'s choices, to edit them.
  factory HabitDraft.of(Habit habit) => HabitDraft(
    title: habit.title,
    description: habit.description,
    category: habit.category,
    color: habit.color,
    icon: habit.icon,
    schedule: habit.schedule,
    dailyTarget: habit.dailyTarget,
    startDate: habit.startDate,
    reminder: habit.reminder,
  );
}
