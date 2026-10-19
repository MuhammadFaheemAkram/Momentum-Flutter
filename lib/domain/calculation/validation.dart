import 'package:characters/characters.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';

// The input rules, shared by the forms (to show the error under a field)
// and the use cases (to refuse what slips past). Each returns `null` when
// the value is fine, or what to fix. Lengths count what the user sees: "🏃‍♀️"
// is one character, not five UTF-16 units.

abstract final class HabitLimits {
  static const maxTitle = 60;
  static const maxDescription = 280;
  static const minDailyTarget = 1;
  static const maxDailyTarget = 20;
  static const minTimesPerWeek = 1;
  static const maxTimesPerWeek = 6;
}

String? habitTitleError(String title) {
  final trimmed = title.trim();
  if (trimmed.isEmpty) return 'Give the habit a name';
  if (trimmed.characters.length > HabitLimits.maxTitle) {
    return 'Keep the name to ${HabitLimits.maxTitle} characters';
  }
  return null;
}

String? habitDescriptionError(String description) =>
    description.trim().characters.length > HabitLimits.maxDescription
    ? 'Keep the description to ${HabitLimits.maxDescription} characters'
    : null;

String? weekdaysError(Set<int> weekdays) {
  if (weekdays.isEmpty) return 'Pick at least one day';
  if (weekdays.any((day) => day < 1 || day > 7)) return 'Pick real weekdays';
  return null;
}

String? timesPerWeekError(int times) =>
    times < HabitLimits.minTimesPerWeek || times > HabitLimits.maxTimesPerWeek
    ? 'Pick ${HabitLimits.minTimesPerWeek} to ${HabitLimits.maxTimesPerWeek} '
          'times a week'
    : null;

String? dailyTargetError(int target) =>
    target < HabitLimits.minDailyTarget || target > HabitLimits.maxDailyTarget
    ? 'Pick ${HabitLimits.minDailyTarget} to ${HabitLimits.maxDailyTarget} '
          'times a day'
    : null;

String? scheduleError(HabitSchedule schedule) => switch (schedule) {
  Daily() => null,
  OnWeekdays(:final weekdays) => weekdaysError(weekdays),
  TimesPerWeek(:final times) => timesPerWeekError(times),
};

/// The first rule [draft] breaks, or null.
String? habitDraftError(HabitDraft draft) =>
    habitTitleError(draft.title) ??
    habitDescriptionError(draft.description) ??
    scheduleError(draft.schedule) ??
    dailyTargetError(draft.dailyTarget);
