import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  Matcher refusedWith(String message) => isA<Err<Object?>>().having(
    (e) => e.exception,
    'exception',
    isA<InvalidInputException>().having((e) => e.message, 'message', message),
  );

  test('saving a routine refuses one with an empty step', () async {
    final result = await stack.saveRoutine(
      const RoutineDraft(
        title: 'Morning',
        items: [RoutineItem(id: 'a', title: '')],
      ),
    );

    expect(result, refusedWith('Name this step, or remove it'));
  });

  test('saving a goal refuses a target over 200', () async {
    final result = await stack.saveGoal(
      const GoalDraft(
        title: 'Lots',
        scope: GoalScope.allHabits(),
        period: GoalPeriod.monthly,
        target: 201,
      ),
    );

    expect(result, refusedWith('Pick a target from 1 to 200'));
  });

  test('a step is checked off for today, live', () async {
    await stack.seed(UserData(routines: [routine()]));

    await stack.toggleRoutineItem('r-a', checked: true);

    final data = await stack.watchRoutines().first;
    expect(data.today, today);
    expect(data.routines.single.checkedItemIds, {'r-a'});
    expect((await stack.routines.watchChecks().first).single.day, today);
  });

  test("goals count today's completions as they happen", () async {
    await stack.seed(
      UserData(
        habits: [habit(id: 'read')],
        goals: [goal(period: GoalPeriod.daily)],
      ),
    );
    expect((await stack.watchGoals().first).goals.single.current, 0);

    await stack.addCheckIn('read');

    expect((await stack.watchGoals().first).goals.single.current, 1);
  });

  test('Today shows the routines and the goals', () async {
    await stack.seed(
      UserData(
        habits: [habit(id: 'read')],
        routines: [routine()],
        goals: [goal()],
      ),
    );

    final overview = await stack.watchToday().first;

    expect(overview.routines.single.routine.id, 'r');
    expect(overview.goals.single.goal.id, 'g');
  });

  test('cancelling the routines and goals views stops their timers', () {
    fakeAsync((async) {
      for (final view in [stack.watchRoutines(), stack.watchGoals()]) {
        final subscription = view.listen((_) {});
        async.flushMicrotasks();
        subscription.cancel();
        async.flushMicrotasks();
        expect(
          async.pendingTimers.where(
            (t) => t.duration > const Duration(hours: 1),
          ),
          isEmpty,
        );
      }
    });
  });
}
