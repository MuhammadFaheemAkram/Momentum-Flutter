import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/routines/cubit/routines_cubit.dart';
import 'package:momentum/features/routines/cubit/routines_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;
  late RoutinesCubit cubit;

  setUp(() async {
    stack = DataStack();
    await stack.seed(UserData(routines: [routine()]));
    cubit = RoutinesCubit(stack.watchRoutines, stack.toggleRoutineItem)
      ..start();
    await waitFor(cubit, (s) => s.status == RoutinesStatus.ready);
  });
  tearDown(() async {
    await cubit.close();
    await stack.close();
  });

  test('checking a step off shows at once, and un-checking too', () async {
    final item = cubit.state.routines.single.routine.items.first;

    await cubit.toggle(item, checked: true);
    await waitFor(cubit, (s) => s.routines.single.done == 1);

    await cubit.toggle(item, checked: false);
    await waitFor(cubit, (s) => s.routines.single.done == 0);
  });
}
