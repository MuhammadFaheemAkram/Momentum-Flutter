import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/goals/cubit/goals_cubit.dart';
import 'package:momentum/features/goals/cubit/goals_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;
  late GoalsCubit cubit;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [
          habit(id: 'read'),
          habit(id: 'old', archivedAt: DateTime.utc(2026, 10)),
        ],
        logs: [done(today, id: 'read')],
        goals: [
          goal(id: 'week'),
          goal(id: 'day', period: GoalPeriod.daily, target: 1),
        ],
      ),
    );
    cubit = GoalsCubit(stack.watchGoals, stack.saveGoal, stack.deleteGoal)
      ..start();
    await waitFor(cubit, (s) => s.status == GoalsStatus.ready);
  });
  tearDown(() async {
    await cubit.close();
    await stack.close();
  });

  test('shows one period at a time, weekly first, with each one counted', () {
    expect(cubit.state.visible.map((g) => g.goal.id), ['week']);
    expect(cubit.state.countFor(GoalPeriod.daily), 1);

    cubit.showPeriod(GoalPeriod.daily);
    expect(cubit.state.visible.single.isMet, isTrue);
  });

  test('every habit is offered to the sheet, archived ones too', () {
    expect(cubit.state.habits.map((h) => h.id), ['read', 'old']);
  });

  test('a saved goal shows in its period, and says so', () async {
    await cubit.save(
      const GoalDraft(
        title: 'Read 20 days',
        scope: GoalScope.habit('read'),
        period: GoalPeriod.monthly,
        target: 20,
      ),
    );
    await waitFor(cubit, (s) => s.countFor(GoalPeriod.monthly) == 1);

    expect(cubit.state.period, GoalPeriod.monthly);
    expect(cubit.state.visible.single.current, 1);
    expect(cubit.state.message, 'Added Read 20 days');
  });

  test('delete removes it', () async {
    await cubit.delete(cubit.state.visible.single.goal);

    await waitFor(cubit, (s) => s.countFor(GoalPeriod.weekly) == 0);
    expect(cubit.state.message, 'Deleted Goal week');
  });
}
