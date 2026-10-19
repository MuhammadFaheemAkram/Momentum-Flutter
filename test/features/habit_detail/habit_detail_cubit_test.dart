import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [habit(id: 'read', start: oct(1))],
        logs: doneEvery(oct(15), oct(20), id: 'read'),
      ),
    );
  });
  tearDown(() => stack.close());

  HabitDetailCubit open(String id) {
    final cubit = HabitDetailCubit(
      stack.watchDetail,
      stack.setDay,
      stack.setArchived,
      stack.deleteHabit,
      id,
    )..start();
    addTearDown(cubit.close);
    return cubit;
  }

  HeatmapDay dayOf(HabitDetailState state, int day) =>
      state.detail!.heatmap.singleWhere((d) => d.day == oct(day));

  test('loads the page, live', () async {
    final cubit = open('read');

    final state = await waitFor(
      cubit,
      (s) => s.status == HabitDetailStatus.ready,
    );

    expect(state.detail!.streak.current, 6);
    expect(dayOf(state, 14).state, DayState.missed);
  });

  test('a tapped day toggles: missed → done → not done', () async {
    final cubit = open('read');
    final ready = await waitFor(
      cubit,
      (s) => s.status == HabitDetailStatus.ready,
    );

    await cubit.toggleDay(dayOf(ready, 14));
    final done = await waitFor(
      cubit,
      (s) => dayOf(s, 14).state == DayState.done,
    );
    expect(done.detail!.streak.current, 7);

    await cubit.toggleDay(dayOf(done, 14));
    await waitFor(cubit, (s) => dayOf(s, 14).state == DayState.missed);
  });

  test('archive says so', () async {
    final cubit = open('read');
    await waitFor(cubit, (s) => s.status == HabitDetailStatus.ready);

    await cubit.setArchived(archived: true);
    await waitFor(cubit, (s) => s.detail!.habit.archivedAt != null);
    expect(cubit.state.message, 'Archived Habit read');
  });

  test('delete leaves the page', () async {
    final cubit = open('read');
    await waitFor(cubit, (s) => s.status == HabitDetailStatus.ready);

    await cubit.delete();

    expect(cubit.state.deleted, isTrue);
  });

  test("a habit that doesn't exist is not found", () async {
    final cubit = open('nope');

    await waitFor(cubit, (s) => s.status == HabitDetailStatus.notFound);
  });
}
