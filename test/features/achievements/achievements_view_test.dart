import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/calculation/achievements.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/features/achievements/achievements_page.dart';
import 'package:momentum/features/achievements/cubit/achievements_cubit.dart';
import 'package:momentum/features/achievements/cubit/achievements_state.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockAchievementsCubit extends MockCubit<AchievementsState>
    implements AchievementsCubit {}

void main() {
  testWidgets('how many are unlocked; unlocked ones with their date, locked '
      'ones with their rule and progress', (tester) async {
    final cubit = _MockAchievementsCubit();
    final input = AchievementInput(
      histories: [history(habit(), doneEvery(oct(16), oct(20)))],
      routines: const [],
      checks: const [],
      today: today,
    );
    when(() => cubit.state).thenReturn(
      AchievementsState(
        status: AchievementsStatus.ready,
        today: today,
        statuses: achievementStatuses(input, [
          AchievementUnlock(
            achievementId: AchievementId.firstStep.name,
            unlockedOn: oct(16),
            unlockedAt: DateTime.utc(2026, 10, 16),
          ),
        ]),
      ),
    );
    tester.useTallPhoneSurface();
    await tester.pumpThemed(
      ShellDrawerScope(
        openDrawer: () {},
        child: BlocProvider<AchievementsCubit>.value(
          value: cubit,
          child: const AchievementsView(),
        ),
      ),
    );

    expect(find.text('1 of 10 unlocked'), findsOneWidget);
    expect(find.text('Unlocked Fri, 16 Oct'), findsOneWidget);
    expect(find.text('Keep a habit going 7 days in a row.'), findsOneWidget);
    expect(find.text('Locked · 5 of 7 days'), findsOneWidget);
    expect(find.text('Locked · 1 of 5 habits'), findsOneWidget);
  });
}
