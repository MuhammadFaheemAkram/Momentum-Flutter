import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/usecase/habit_use_cases.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';

/// Creates a habit ([habitId] null) or edits [habitId]'s. The values live
/// here, so the discard guard knows whether anything changed, and the same
/// rules as the use case decide what to show under each field.
@injectable
class HabitFormCubit extends Cubit<HabitFormState> {
  HabitFormCubit(
    this._findHabit,
    this._saveHabit,
    this._deleteHabit,
    this._clock,
    @factoryParam this.habitId,
  ) : super(const HabitFormState());

  final FindHabitUseCase _findHabit;
  final SaveHabitUseCase _saveHabit;
  final DeleteHabitUseCase _deleteHabit;
  final CalendarClock _clock;
  final String? habitId;

  bool get isNew => habitId == null;

  Future<void> load() async {
    final id = habitId;
    if (id == null) {
      final values = HabitFormValues(startDate: _clock.today);
      emit(
        state.copyWith(
          status: HabitFormStatus.editing,
          original: values,
          values: values,
        ),
      );
      return;
    }
    final habit = await _findHabit(id);
    if (isClosed) return;
    if (habit == null) {
      emit(state.copyWith(status: HabitFormStatus.notFound));
      return;
    }
    final values = HabitFormValues.of(habit);
    emit(
      state.copyWith(
        status: HabitFormStatus.editing,
        original: values,
        values: values,
      ),
    );
  }

  void _update(HabitFormValues Function(HabitFormValues values) change) {
    final values = state.values;
    if (values == null || state.saving) return;
    emit(state.copyWith(values: change(values)));
  }

  void titleChanged(String title) => _update((v) => v.copyWith(title: title));

  void descriptionChanged(String description) =>
      _update((v) => v.copyWith(description: description));

  void categoryChanged(HabitCategory category) =>
      _update((v) => v.copyWith(category: category));

  void kindChanged(ScheduleKind kind) => _update((v) => v.copyWith(kind: kind));

  void weekdayToggled(int weekday) => _update((v) {
    final weekdays = {...v.weekdays};
    if (!weekdays.remove(weekday)) weekdays.add(weekday);
    return v.copyWith(weekdays: weekdays);
  });

  void timesPerWeekChanged(int times) => _update(
    (v) => v.copyWith(
      timesPerWeek: times.clamp(
        HabitLimits.minTimesPerWeek,
        HabitLimits.maxTimesPerWeek,
      ),
    ),
  );

  void dailyTargetChanged(int target) => _update(
    (v) => v.copyWith(
      dailyTarget: target.clamp(
        HabitLimits.minDailyTarget,
        HabitLimits.maxDailyTarget,
      ),
    ),
  );

  void startDateChanged(CalendarDate day) =>
      _update((v) => v.copyWith(startDate: day));

  void reminderChanged(TimeOfDayValue? reminder) =>
      _update((v) => v.copyWith(reminder: reminder));

  void colorChanged(HabitColor color) =>
      _update((v) => v.copyWith(color: color));

  void iconChanged(HabitIcon icon) => _update((v) => v.copyWith(icon: icon));

  /// Saves, unless nothing changed (then it just closes). With a problem,
  /// the errors appear under the fields instead.
  Future<void> save() async {
    final values = state.values;
    if (values == null || state.saving) return;
    if (!isNew && !state.isDirty) {
      emit(state.copyWith(exit: const HabitDiscarded()));
      return;
    }
    if (habitDraftError(values.draft) != null) {
      emit(state.copyWith(showErrors: true));
      return;
    }
    emit(state.copyWith(saving: true));
    final result = await _saveHabit(values.draft, id: habitId);
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            saving: false,
            exit: HabitSaved(value, created: isNew),
          ),
        );
      case Err(:final exception):
        _fail(exception.message);
    }
  }

  /// Leaves without saving (after the user confirmed the discard).
  void discard() => emit(state.copyWith(exit: const HabitDiscarded()));

  /// Deletes the habit with its history (the view confirms first).
  Future<void> delete() async {
    final id = habitId;
    if (id == null || state.saving) return;
    emit(state.copyWith(saving: true));
    final result = await _deleteHabit(id);
    if (isClosed) return;
    switch (result) {
      case Ok():
        emit(
          state.copyWith(
            saving: false,
            exit: HabitDeleted(state.original?.title ?? ''),
          ),
        );
      case Err(:final exception):
        _fail(exception.message);
    }
  }

  void _fail(String message) => emit(
    state.copyWith(
      saving: false,
      errorMessage: message,
      errorSerial: state.errorSerial + 1,
    ),
  );
}
