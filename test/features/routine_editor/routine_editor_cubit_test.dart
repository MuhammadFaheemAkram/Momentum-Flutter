import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_cubit.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        routines: [
          routine(id: 'm', items: ['bed', 'stretch', 'plan']),
        ],
        routineChecks: [RoutineCheck(itemId: 'm-plan', day: today)],
      ),
    );
  });
  tearDown(() => stack.close());

  Future<RoutineEditorCubit> open([String? id]) async {
    final cubit = RoutineEditorCubit(
      stack.findRoutine,
      stack.saveRoutine,
      stack.deleteRoutine,
      stack.ids,
      id,
    );
    addTearDown(cubit.close);
    await cubit.load();
    return cubit;
  }

  List<String> ids(RoutineEditorCubit cubit) => [
    for (final item in cubit.state.draft!.items) item.id,
  ];

  group('a new routine', () {
    test('starts with one empty step, untouched', () async {
      final cubit = await open();

      expect(cubit.state.draft!.items, hasLength(1));
      expect(cubit.state.isDirty, isFalse);
    });

    test('shows its errors after a first Save', () async {
      final cubit = await open();

      await cubit.save();

      expect(cubit.state.titleError, 'Give the routine a name');
      expect(
        cubit.state.itemError(cubit.state.draft!.items.single),
        'Name this step, or remove it',
      );
      expect(cubit.state.exit, isNull);
    });

    test('saves its name, time and steps in order', () async {
      final cubit = await open();
      final first = cubit.state.draft!.items.single.id;
      cubit
        ..titleChanged('Evening')
        ..timeChanged(RoutineTime.evening)
        ..itemChanged(first, 'Tidy up');
      final second = cubit.addItem()!;
      cubit.itemChanged(second, 'Journal');

      await cubit.save();

      final exit = cubit.state.exit! as RoutineSaved;
      expect(exit.created, isTrue);
      final saved = (await stack.findRoutine(exit.routine.id))!;
      expect(saved.time, RoutineTime.evening);
      expect(saved.items.map((i) => i.title), ['Tidy up', 'Journal']);
    });

    test('has at most 20 steps', () async {
      final cubit = await open();
      for (var i = 0; i < 25; i++) {
        cubit.addItem();
      }

      expect(cubit.state.draft!.items, hasLength(20));
      expect(cubit.state.canAddItem, isFalse);
      expect(cubit.addItem(), isNull);
    });
  });

  group('an existing routine', () {
    test('moves steps the way the list reports them, up and down', () async {
      final cubit = await open('m');

      cubit.moveItem(2, 0);
      expect(ids(cubit), ['m-plan', 'm-bed', 'm-stretch']);

      cubit.moveItem(0, 2);
      expect(ids(cubit), ['m-bed', 'm-stretch', 'm-plan']);
      expect(cubit.state.isDirty, isFalse, reason: 'back as it was');
    });

    test('a saved reorder keeps every check-off on its step', () async {
      final cubit = await open('m');

      cubit.moveItem(2, 0);
      await cubit.save();

      final saved = (await stack.findRoutine('m'))!;
      expect(saved.items.map((i) => i.id), ['m-plan', 'm-bed', 'm-stretch']);
      final checks = await stack.routines.watchChecks().first;
      expect(checks.single.itemId, 'm-plan');
    });

    test('removing a step removes its check-off on Save', () async {
      final cubit = await open('m');

      cubit.removeItem('m-plan');
      await cubit.save();

      expect(await stack.routines.watchChecks().first, isEmpty);
    });

    test('untouched, Save just closes; Delete removes it', () async {
      final untouched = await open('m');
      await untouched.save();
      expect(untouched.state.exit, isA<RoutineDiscarded>());

      final cubit = await open('m');
      await cubit.delete();
      expect(cubit.state.exit, isA<RoutineDeleted>());
      expect(await stack.findRoutine('m'), isNull);
    });

    test("one that doesn't exist is not found", () async {
      final cubit = await open('nope');

      expect(cubit.state.status, RoutineEditorStatus.notFound);
    });
  });
}
