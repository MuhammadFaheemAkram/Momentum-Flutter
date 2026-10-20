import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/analytics/cubit/analytics_cubit.dart';
import 'package:momentum/features/analytics/cubit/analytics_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  test('follows the history', () async {
    final stack = DataStack();
    addTearDown(stack.close);
    await stack.seed(UserData(habits: [habit(id: 'read')]));
    final cubit = AnalyticsCubit(stack.watchAnalytics)..start();
    addTearDown(cubit.close);

    final empty = await waitFor(
      cubit,
      (s) => s.status == AnalyticsStatus.ready,
    );
    // A habit, but nothing done yet: nothing to add up.
    expect(empty.overview!.isEmpty, isTrue);

    await stack.addCheckIn('read');

    final done = await waitFor(cubit, (s) => s.overview!.totalCompletions == 1);
    expect(done.overview!.isEmpty, isFalse);
  });
}
