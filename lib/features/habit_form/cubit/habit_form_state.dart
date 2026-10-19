import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'habit_form_state.freezed.dart';

enum HabitFormStatus { loading, editing, notFound }

/// The form's three ways to say how often.
enum ScheduleKind { daily, onWeekdays, timesPerWeek }

/// What the form holds while it's edited. Each schedule keeps its own
/// choice (the weekdays, the times a week), so switching back and forth
/// loses nothing.
@freezed
abstract class HabitFormValues with _$HabitFormValues {
  const factory HabitFormValues({
    @Default('') String title,
    @Default('') String description,
    @Default(HabitCategory.health) HabitCategory category,
    @Default(HabitColor.green) HabitColor color,
    @Default(HabitIcon.heart) HabitIcon icon,
    @Default(ScheduleKind.daily) ScheduleKind kind,
    @Default({1, 2, 3, 4, 5}) Set<int> weekdays,
    @Default(3) int timesPerWeek,
    @Default(1) int dailyTarget,
    required CalendarDate startDate,
    TimeOfDayValue? reminder,
  }) = _HabitFormValues;

  const HabitFormValues._();

  /// [habit]'s choices.
  factory HabitFormValues.of(Habit habit) {
    final base = HabitFormValues(
      title: habit.title,
      description: habit.description,
      category: habit.category,
      color: habit.color,
      icon: habit.icon,
      dailyTarget: habit.dailyTarget,
      startDate: habit.startDate,
      reminder: habit.reminder,
    );
    return switch (habit.schedule) {
      Daily() => base,
      OnWeekdays(:final weekdays) => base.copyWith(
        kind: ScheduleKind.onWeekdays,
        weekdays: weekdays,
      ),
      TimesPerWeek(:final times) => base.copyWith(
        kind: ScheduleKind.timesPerWeek,
        timesPerWeek: times,
      ),
    };
  }

  HabitSchedule get schedule => switch (kind) {
    ScheduleKind.daily => const HabitSchedule.daily(),
    ScheduleKind.onWeekdays => HabitSchedule.onWeekdays(weekdays),
    ScheduleKind.timesPerWeek => HabitSchedule.timesPerWeek(timesPerWeek),
  };

  HabitDraft get draft => HabitDraft(
    title: title,
    description: description,
    category: category,
    color: color,
    icon: icon,
    schedule: schedule,
    dailyTarget: dailyTarget,
    startDate: startDate,
    reminder: reminder,
  );

  /// The choice that matters for [kind]: switching from "On chosen days"
  /// to "Daily" and back isn't a change if nothing else was.
  bool sameAs(HabitFormValues other) => draft == other.draft;
}

/// How the form closed: the page pops with it.
sealed class HabitFormExit {
  const HabitFormExit();
}

final class HabitSaved extends HabitFormExit {
  const HabitSaved(this.habit, {required this.created});

  final Habit habit;
  final bool created;
}

final class HabitDeleted extends HabitFormExit {
  const HabitDeleted(this.title);

  final String title;
}

/// Left without saving: nothing changed, or the user chose to discard.
final class HabitDiscarded extends HabitFormExit {
  const HabitDiscarded();
}

@freezed
abstract class HabitFormState with _$HabitFormState {
  const factory HabitFormState({
    @Default(HabitFormStatus.loading) HabitFormStatus status,

    /// What the habit was when opened (the defaults for a new one).
    HabitFormValues? original,
    HabitFormValues? values,

    /// Errors show under the fields only after a first Save.
    @Default(false) bool showErrors,
    @Default(false) bool saving,
    HabitFormExit? exit,
    String? errorMessage,
    @Default(0) int errorSerial,
  }) = _HabitFormState;

  const HabitFormState._();

  bool get isDirty {
    final values = this.values;
    final original = this.original;
    return values != null && original != null && !values.sameAs(original);
  }

  String? get titleError =>
      showErrors ? habitTitleError(values?.title ?? '') : null;

  /// Shown as soon as it's too long: the counter says so too.
  String? get descriptionError =>
      habitDescriptionError(values?.description ?? '');

  String? get chosenDaysError =>
      showErrors && values?.kind == ScheduleKind.onWeekdays
      ? weekdaysError(values!.weekdays)
      : null;
}
