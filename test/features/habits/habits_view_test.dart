import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/features/habits/cubit/habits_cubit.dart';
import 'package:momentum/features/habits/cubit/habits_state.dart';
import 'package:momentum/features/habits/habits_view.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/overview_fixtures.dart';
import '../../helpers/pump_app.dart';

class _MockHabitsCubit extends MockCubit<HabitsState> implements HabitsCubit {}

void main() {
  late _MockHabitsCubit cubit;

  setUpAll(() => registerFallbackValue(HabitCategory.health));
  setUp(() {
    cubit = _MockHabitsCubit();
    when(() => cubit.start()).thenReturn(null);
    when(() => cubit.search(any())).thenReturn(null);
    when(() => cubit.filterBy(any())).thenReturn(null);
  });

  final habits = buildHabitList(
    [readHabit, runHabit.copyWith(archivedAt: DateTime.utc(2026, 10))],
    const [],
    today: today,
  );
  final ready = HabitsState(
    status: HabitsStatus.ready,
    today: today,
    habits: habits,
  );

  Future<void> pump(WidgetTester tester, HabitsState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      ShellDrawerScope(
        openDrawer: () {},
        child: BlocProvider<HabitsCubit>.value(
          value: cubit,
          child: const HabitsView(),
        ),
      ),
    );
  }

  testWidgets('lists the habits, with the archived ones behind a switch', (
    tester,
  ) async {
    await pump(tester, ready);

    expect(find.text('Read 20 pages'), findsOneWidget);
    expect(find.text('Morning run'), findsNothing);
    expect(find.text('Show archived (1)'), findsOneWidget);
  });

  testWidgets('shown, an archived habit says so and has no check button', (
    tester,
  ) async {
    await pump(tester, ready.copyWith(showArchived: true));

    expect(find.text('Archived'), findsOneWidget);
    expect(find.byTooltip('Mark Morning run done'), findsNothing);
    expect(find.byTooltip('Mark Read 20 pages done'), findsOneWidget);
  });

  testWidgets('typing searches; a chip filters', (tester) async {
    await pump(tester, ready);

    await tester.enterText(find.byType(TextField), 'read');
    await tester.tap(find.text('Fitness'));

    verify(() => cubit.search('read')).called(1);
    verify(() => cubit.filterBy(HabitCategory.fitness)).called(1);
  });

  testWidgets('nothing matching says so', (tester) async {
    await pump(tester, ready.copyWith(query: 'zzz'));

    expect(find.text('No habits match.'), findsOneWidget);
  });

  testWidgets('no habits at all: a way to add one', (tester) async {
    await pump(tester, const HabitsState(status: HabitsStatus.ready));

    expect(find.text('No habits yet'), findsOneWidget);
  });
}
