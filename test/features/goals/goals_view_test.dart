import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/features/goals/cubit/goals_cubit.dart';
import 'package:momentum/features/goals/cubit/goals_state.dart';
import 'package:momentum/features/goals/goals_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockGoalsCubit extends MockCubit<GoalsState> implements GoalsCubit {}

void main() {
  late _MockGoalsCubit cubit;

  setUpAll(() => registerFallbackValue(GoalPeriod.daily));
  setUp(() {
    cubit = _MockGoalsCubit();
    when(() => cubit.start()).thenReturn(null);
    when(() => cubit.showPeriod(any())).thenReturn(null);
  });

  final ready = GoalsState(
    status: GoalsStatus.ready,
    today: today,
    goals: buildGoalList(
      [goal(), goal(id: 'm', period: GoalPeriod.monthly)],
      const [],
      const [],
      today: today,
    ),
  );

  Future<void> pump(WidgetTester tester, GoalsState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<GoalsCubit>.value(value: cubit, child: const GoalsView()),
    );
  }

  testWidgets('the periods with their counts; the weekly goals shown', (
    tester,
  ) async {
    await pump(tester, ready);

    expect(find.text('Weekly (1)'), findsOneWidget);
    expect(find.text('Monthly (1)'), findsOneWidget);
    expect(find.text('Daily'), findsOneWidget);
    expect(find.text('Goal g'), findsOneWidget);
    expect(find.text('Goal m'), findsNothing);

    await tester.tap(find.text('Monthly (1)'));
    verify(() => cubit.showPeriod(GoalPeriod.monthly)).called(1);
  });

  testWidgets('a period with none says so', (tester) async {
    await pump(tester, ready.copyWith(period: GoalPeriod.daily));

    expect(find.text('No daily goals'), findsOneWidget);
  });

  testWidgets('New goal opens the sheet', (tester) async {
    await pump(tester, ready);

    await tester.tap(find.text('New goal'));
    await tester.pumpAndSettle();

    expect(find.text('What counts'), findsOneWidget);
  });
}
