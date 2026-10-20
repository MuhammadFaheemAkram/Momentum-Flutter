import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/achievements/cubit/achievements_cubit.dart';
import 'package:momentum/features/achievements/cubit/achievements_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

void main() {
  test('unlocked first, then the locked ones closest to earning', () async {
    final stack = DataStack();
    addTearDown(stack.close);
    await stack.seed(
      UserData(
        habits: [habit(id: 'read')],
        logs: doneEvery(oct(16), oct(20), id: 'read'),
      ),
    );
    await stack.evaluateAchievements();
    final cubit = AchievementsCubit(stack.watchAchievements)..start();
    addTearDown(cubit.close);

    final state = await waitFor(
      cubit,
      (s) => s.status == AchievementsStatus.ready,
    );

    expect(state.unlockedCount, 1);
    expect(state.ordered.first.id, AchievementId.firstStep);
    // A 5-day streak: 5 of 7 is the closest of the locked badges.
    expect(state.ordered[1].id, AchievementId.streak7);
    expect(state.ordered, hasLength(AchievementId.values.length));
  });
}
