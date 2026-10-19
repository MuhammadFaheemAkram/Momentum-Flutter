import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_state.dart';
import 'package:momentum/features/habit_detail/habit_detail_view.dart';

import '../../helpers/overview_fixtures.dart';
import '../../helpers/pump_app.dart';

class _MockHabitDetailCubit extends MockCubit<HabitDetailState>
    implements HabitDetailCubit {}

void main() {
  late _MockHabitDetailCubit cubit;

  setUp(() {
    cubit = _MockHabitDetailCubit();
    when(() => cubit.start()).thenReturn(null);
  });

  Future<void> pump(WidgetTester tester, HabitDetailState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<HabitDetailCubit>.value(
        value: cubit,
        child: const HabitDetailView(),
      ),
    );
  }

  testWidgets('the habit, its figures, its calendar and its weeks', (
    tester,
  ) async {
    await pump(
      tester,
      HabitDetailState(
        status: HabitDetailStatus.ready,
        detail: detailFixture(),
      ),
    );

    expect(find.text('Read 20 pages'), findsOneWidget);
    expect(find.text('Current streak'), findsOneWidget);
    expect(find.text('0 days'), findsOneWidget);
    expect(find.text('Longest streak'), findsOneWidget);
    // Started on the 1st: missed the 1st–4th, done the 5th–12th, skipped
    // the 13th, missed since.
    expect(find.text('8 days'), findsOneWidget);
    expect(find.text('Times done'), findsOneWidget);
    expect(find.text('Done on 8 days, skipped 1, missed 11'), findsOneWidget);
    expect(find.textContaining('Tap a day in the last 30'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('^Last 8 weeks: 8 of')),
      findsOneWidget,
    );
  });

  testWidgets('archived: no backfill, and Unarchive in the menu', (
    tester,
  ) async {
    await pump(
      tester,
      HabitDetailState(
        status: HabitDetailStatus.ready,
        detail: detailFixture(archived: true),
      ),
    );

    expect(find.textContaining('Tap a day'), findsNothing);
    expect(find.textContaining('Archived:'), findsOneWidget);
    await tester.tap(find.byTooltip('More'));
    await tester.pumpAndSettle();
    expect(find.text('Unarchive'), findsOneWidget);
  });

  testWidgets("a habit that's gone says so", (tester) async {
    await pump(
      tester,
      const HabitDetailState(status: HabitDetailStatus.notFound),
    );

    expect(find.text("This habit doesn't exist any more"), findsOneWidget);
    expect(find.text('Go to Habits'), findsOneWidget);
  });
}
