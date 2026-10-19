import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [habit(id: 'run', schedule: monWedFri)],
        logs: [done(oct(19), id: 'run')],
      ),
    );
  });
  tearDown(() => stack.close());

  Future<HabitFormCubit> open([String? habitId]) async {
    final cubit = HabitFormCubit(
      stack.findHabit,
      stack.saveHabit,
      stack.deleteHabit,
      stack.calendar,
      habitId,
    );
    addTearDown(cubit.close);
    await cubit.load();
    return cubit;
  }

  group('a new habit', () {
    test('starts today, daily, with no reminder', () async {
      final cubit = await open();

      expect(cubit.state.status, HabitFormStatus.editing);
      expect(cubit.state.values!.startDate, today);
      expect(cubit.state.values!.schedule, const HabitSchedule.daily());
      expect(cubit.state.values!.reminder, isNull);
      expect(cubit.state.isDirty, isFalse);
    });

    test(
      'shows its errors only after a first Save, and saves nothing',
      () async {
        final cubit = await open();
        expect(cubit.state.titleError, isNull);

        await cubit.save();

        expect(cubit.state.titleError, 'Give the habit a name');
        expect(cubit.state.exit, isNull);
        expect(await stack.habits.watchHabits().first, hasLength(1));
      },
    );

    test('needs a day when on chosen days', () async {
      final cubit = await open();
      cubit
        ..titleChanged('Gym')
        ..kindChanged(ScheduleKind.onWeekdays);
      for (final day in [1, 2, 3, 4, 5]) {
        cubit.weekdayToggled(day);
      }

      await cubit.save();

      expect(cubit.state.chosenDaysError, 'Pick at least one day');
    });

    test('saves every choice', () async {
      final cubit = await open();
      cubit
        ..titleChanged('Learn Spanish')
        ..descriptionChanged('A lesson')
        ..categoryChanged(HabitCategory.learning)
        ..kindChanged(ScheduleKind.timesPerWeek)
        ..timesPerWeekChanged(5)
        ..dailyTargetChanged(2)
        ..startDateChanged(oct(26))
        ..reminderChanged(TimeOfDayValue(19, 0))
        ..colorChanged(HabitColor.indigo)
        ..iconChanged(HabitIcon.language);

      await cubit.save();

      final exit = cubit.state.exit! as HabitSaved;
      expect(exit.created, isTrue);
      final saved = (await stack.findHabit(exit.habit.id))!;
      expect(saved.schedule, const HabitSchedule.timesPerWeek(5));
      expect(
        (saved.title, saved.category, saved.dailyTarget, saved.startDate),
        ('Learn Spanish', HabitCategory.learning, 2, oct(26)),
      );
      expect(
        (saved.reminder, saved.color, saved.icon),
        (TimeOfDayValue(19, 0), HabitColor.indigo, HabitIcon.language),
      );
    });

    test('steppers stay within their limits', () async {
      final cubit = await open();

      cubit
        ..dailyTargetChanged(25)
        ..timesPerWeekChanged(0);

      expect(cubit.state.values!.dailyTarget, 20);
      expect(cubit.state.values!.timesPerWeek, 1);
    });
  });

  group('an existing habit', () {
    test('opens with its choices', () async {
      final cubit = await open('run');

      expect(cubit.state.values!.kind, ScheduleKind.onWeekdays);
      expect(cubit.state.values!.weekdays, {1, 3, 5});
    });

    test('untouched, Save just closes', () async {
      final cubit = await open('run');

      await cubit.save();

      expect(cubit.state.exit, isA<HabitDiscarded>());
    });

    test('switching the schedule away and back is not a change', () async {
      final cubit = await open('run');

      cubit.kindChanged(ScheduleKind.daily);
      expect(cubit.state.isDirty, isTrue);
      cubit.kindChanged(ScheduleKind.onWeekdays);
      expect(cubit.state.isDirty, isFalse);
    });

    test('an edit keeps the history', () async {
      final cubit = await open('run');

      cubit.kindChanged(ScheduleKind.daily);
      await cubit.save();

      expect(cubit.state.exit, isA<HabitSaved>());
      expect(await stack.logs.findLog('run', oct(19)), isNotNull);
    });

    test('delete removes it with its history', () async {
      final cubit = await open('run');

      await cubit.delete();

      expect(cubit.state.exit, isA<HabitDeleted>());
      expect(await stack.findHabit('run'), isNull);
      expect(await stack.logs.findLog('run', oct(19)), isNull);
    });

    test("one that doesn't exist is not found", () async {
      final cubit = await open('nope');

      expect(cubit.state.status, HabitFormStatus.notFound);
    });
  });
}
