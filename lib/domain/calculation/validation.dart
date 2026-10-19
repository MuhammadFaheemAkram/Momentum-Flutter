import 'package:characters/characters.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/routine.dart';

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

abstract final class RoutineLimits {
  static const maxTitle = 40;
  static const maxItems = 20;
  static const maxItemTitle = 60;
}

String? routineTitleError(String title) {
  final trimmed = title.trim();
  if (trimmed.isEmpty) return 'Give the routine a name';
  if (trimmed.characters.length > RoutineLimits.maxTitle) {
    return 'Keep the name to ${RoutineLimits.maxTitle} characters';
  }
  return null;
}

String? routineItemsError(List<RoutineItem> items) {
  if (items.isEmpty) return 'Add at least one step';
  if (items.length > RoutineLimits.maxItems) {
    return 'A routine can have up to ${RoutineLimits.maxItems} steps';
  }
  return null;
}

String? routineItemTitleError(String title) {
  final trimmed = title.trim();
  if (trimmed.isEmpty) return 'Name this step, or remove it';
  if (trimmed.characters.length > RoutineLimits.maxItemTitle) {
    return 'Keep it to ${RoutineLimits.maxItemTitle} characters';
  }
  return null;
}

/// The first rule [draft] breaks, or null.
String? routineDraftError(RoutineDraft draft) =>
    routineTitleError(draft.title) ??
    routineItemsError(draft.items) ??
    draft.items
        .map((item) => routineItemTitleError(item.title))
        .nonNulls
        .firstOrNull;

abstract final class GoalLimits {
  static const maxTitle = 60;
  static const minTarget = 1;
  static const maxTarget = 200;
}

String? goalTitleError(String title) {
  final trimmed = title.trim();
  if (trimmed.isEmpty) return 'Give the goal a name';
  if (trimmed.characters.length > GoalLimits.maxTitle) {
    return 'Keep the name to ${GoalLimits.maxTitle} characters';
  }
  return null;
}

String? goalTargetError(int? target) =>
    target == null ||
        target < GoalLimits.minTarget ||
        target > GoalLimits.maxTarget
    ? 'Pick a target from ${GoalLimits.minTarget} to ${GoalLimits.maxTarget}'
    : null;

/// The first rule [draft] breaks, or null. (That a one-habit goal's habit
/// exists is the database's to say: a foreign key.)
String? goalDraftError(GoalDraft draft) =>
    goalTitleError(draft.title) ?? goalTargetError(draft.target);
