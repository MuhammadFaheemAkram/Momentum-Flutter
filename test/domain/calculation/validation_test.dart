import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';

import '../../helpers/habit_builders.dart';

void main() {
  test('a name is required, up to 60 characters as people count them', () {
    expect(habitTitleError(''), isNotNull);
    expect(habitTitleError('   '), isNotNull);
    expect(habitTitleError('a' * 60), isNull);
    expect(habitTitleError('a' * 61), isNotNull);
    // Sixty runners: one character each, though each is five UTF-16 units.
    expect(habitTitleError('🏃‍♀️' * 60), isNull);
  });

  test('a description is optional, up to 280 characters', () {
    expect(habitDescriptionError(''), isNull);
    expect(habitDescriptionError('a' * 280), isNull);
    expect(habitDescriptionError('a' * 281), isNotNull);
  });

  test('a schedule needs a day, or one to six times a week', () {
    expect(scheduleError(const HabitSchedule.daily()), isNull);
    expect(scheduleError(const HabitSchedule.onWeekdays({})), isNotNull);
    expect(scheduleError(const HabitSchedule.onWeekdays({0})), isNotNull);
    expect(scheduleError(const HabitSchedule.onWeekdays({7})), isNull);
    expect(timesPerWeekError(0), isNotNull);
    expect(timesPerWeekError(6), isNull);
    expect(timesPerWeekError(7), isNotNull);
  });

  test('a daily target is 1–20', () {
    expect(dailyTargetError(0), isNotNull);
    expect(dailyTargetError(1), isNull);
    expect(dailyTargetError(20), isNull);
    expect(dailyTargetError(21), isNotNull);
  });

  test('a draft reports its first problem, or none', () {
    final draft = HabitDraft(
      title: 'Read',
      category: HabitCategory.reading,
      color: HabitColor.green,
      icon: HabitIcon.book,
      schedule: const HabitSchedule.daily(),
      startDate: today,
    );

    expect(habitDraftError(draft), isNull);
    expect(habitDraftError(draft.copyWith(title: '')), 'Give the habit a name');
    expect(habitDraftError(draft.copyWith(dailyTarget: 0)), isNotNull);
  });

  group('a routine', () {
    RoutineDraft draft({String title = 'Morning', List<String>? items}) =>
        RoutineDraft(
          title: title,
          items: [
            for (final (i, t) in (items ?? ['Stretch']).indexed)
              RoutineItem(id: '$i', title: t),
          ],
        );

    test('needs a name of up to 40 characters', () {
      expect(routineDraftError(draft(title: '')), 'Give the routine a name');
      expect(routineDraftError(draft(title: 'a' * 40)), isNull);
      expect(routineDraftError(draft(title: 'a' * 41)), isNotNull);
    });

    test('needs 1–20 steps, each named, up to 60 characters', () {
      expect(routineDraftError(draft(items: [])), 'Add at least one step');
      expect(routineDraftError(draft(items: List.filled(20, 'x'))), isNull);
      expect(routineDraftError(draft(items: List.filled(21, 'x'))), isNotNull);
      expect(
        routineDraftError(draft(items: ['ok', ' '])),
        'Name this step, or remove it',
      );
      expect(routineDraftError(draft(items: ['a' * 61])), isNotNull);
    });
  });

  group('a goal', () {
    const draft = GoalDraft(
      title: 'Complete 25 habits',
      scope: GoalScope.allHabits(),
      period: GoalPeriod.weekly,
      target: 25,
    );

    test('needs a name and a target of 1–200', () {
      expect(goalDraftError(draft), isNull);
      expect(
        goalDraftError(draft.copyWith(title: ' ')),
        'Give the goal a name',
      );
      expect(goalDraftError(draft.copyWith(target: 0)), isNotNull);
      expect(goalDraftError(draft.copyWith(target: 200)), isNull);
      expect(goalDraftError(draft.copyWith(target: 201)), isNotNull);
      expect(goalTargetError(null), isNotNull);
    });
  });
}
