import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/habits/cubit/habits_cubit.dart';
import 'package:momentum/features/habits/cubit/habits_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;
  late HabitsCubit cubit;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [
          habit(id: 'water').copyWith(title: 'Drink water'),
          habit(id: 'run').copyWith(
            title: 'Morning run',
            category: HabitCategory.fitness,
            description: 'Around the park',
          ),
          habit(
            id: 'old',
            archivedAt: DateTime.utc(2026, 10),
          ).copyWith(title: 'Old habit'),
        ],
      ),
    );
    cubit = HabitsCubit(stack.watchHabits, stack.dayActions)..start();
    await waitFor(cubit, (s) => s.status == HabitsStatus.ready);
  });
  tearDown(() async {
    await cubit.close();
    await stack.close();
  });

  List<String> visible() => [for (final h in cubit.state.visible) h.habit.id];

  test('lists the habits that are not archived; the archived on request', () {
    expect(visible(), ['water', 'run']);
    expect(cubit.state.archivedCount, 1);

    cubit.showArchived(show: true);
    expect(visible(), ['water', 'run', 'old']);
  });

  test('searches names and descriptions, ignoring case', () {
    cubit.search('WATER');
    expect(visible(), ['water']);

    cubit.search('park');
    expect(visible(), ['run']);

    cubit.search('  ');
    expect(visible(), ['water', 'run']);
  });

  test('filters by category, alone and with a search', () {
    cubit.filterBy(HabitCategory.fitness);
    expect(visible(), ['run']);

    cubit.search('water');
    expect(visible(), isEmpty);
    expect(cubit.state.isFiltered, isTrue);
  });

  test('archive hides a habit, and Undo brings it back', () async {
    final run = cubit.state.visible.singleWhere((h) => h.habit.id == 'run');

    await cubit.setArchived(run, archived: true);
    await waitFor(cubit, (s) => s.visible.length == 1);
    expect(cubit.state.notice!.message, 'Archived Morning run');

    await cubit.undoNotice(cubit.state.notice!);
    await waitFor(cubit, (s) => s.visible.length == 2);
  });
}
