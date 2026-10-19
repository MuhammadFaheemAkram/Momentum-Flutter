import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/test_dependencies.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  group('routines', () {
    const draft = RoutineDraft(
      title: '  Evening ',
      time: RoutineTime.evening,
      items: [
        RoutineItem(id: 'i1', title: ' Tidy up '),
        RoutineItem(id: 'i2', title: 'Journal'),
      ],
    );

    test('a new one gets an id, the time and the next position; titles are '
        'trimmed', () async {
      await stack.seed(UserData(routines: [routine(id: 'a')]));

      final created =
          (await stack.routines.saveRoutine(draft) as Ok<Routine>).value;

      expect(created.id, startsWith('routine_'));
      expect((created.title, created.sortOrder), ('Evening', 1));
      expect(created.items.map((i) => i.title), ['Tidy up', 'Journal']);
      expect(created.createdAt, demoNow.toUtc());
      expect(await stack.routines.findRoutine(created.id), created);
    });

    test('an edit keeps its time of creation and its position', () async {
      final original = routine(id: 'a', sortOrder: 4);
      await stack.seed(UserData(routines: [original]));

      final saved = (await stack.routines.saveRoutine(
        draft,
        id: 'a',
      ) as Ok<Routine>).value;

      expect((saved.createdAt, saved.sortOrder), (original.createdAt, 4));
      expect(
        (await stack.routines.watchRoutines().first).single.items.map(
          (i) => i.id,
        ),
        ['i1', 'i2'],
      );
    });

    test('editing one that is gone says so', () async {
      expect(
        await stack.routines.saveRoutine(draft, id: 'nope'),
        isA<Err<Routine>>().having(
          (e) => e.exception,
          'exception',
          isA<NotFoundException>(),
        ),
      );
    });
  });

  group('goals', () {
    const draft = GoalDraft(
      title: ' Read often ',
      scope: GoalScope.habit('read'),
      period: GoalPeriod.monthly,
      target: 20,
    );

    test('a new one is set today', () async {
      await stack.seed(UserData(habits: [habit(id: 'read')]));

      final created = (await stack.goals.saveGoal(draft) as Ok<Goal>).value;

      expect(created.title, 'Read often');
      expect(created.createdOn, today);
      expect(await stack.goals.watchGoals().first, [created]);
    });

    test('an edit keeps when it was set', () async {
      await stack.seed(
        UserData(
          habits: [habit(id: 'read')],
          goals: [goal()],
        ),
      );

      final saved =
          (await stack.goals.saveGoal(draft, id: 'g') as Ok<Goal>).value;

      expect(saved.createdOn, goal().createdOn);
      expect(saved.scope, const GoalScope.habit('read'));
    });

    test(
      'a goal on a habit that is not there is refused (the foreign key)',
      () async {
        expect(await stack.goals.saveGoal(draft), isA<Err<Goal>>());
      },
    );
  });
}
