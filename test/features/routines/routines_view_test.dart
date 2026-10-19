import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/calculation/routines.dart';
import 'package:momentum/features/routines/cubit/routines_cubit.dart';
import 'package:momentum/features/routines/cubit/routines_state.dart';
import 'package:momentum/features/routines/routines_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockRoutinesCubit extends MockCubit<RoutinesState>
    implements RoutinesCubit {}

void main() {
  late _MockRoutinesCubit cubit;

  setUp(() {
    cubit = _MockRoutinesCubit();
    when(() => cubit.start()).thenReturn(null);
  });

  Future<void> pump(WidgetTester tester, RoutinesState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<RoutinesCubit>.value(
        value: cubit,
        child: const RoutinesView(),
      ),
    );
  }

  testWidgets('each routine, with its steps to check off', (tester) async {
    await pump(
      tester,
      RoutinesState(
        status: RoutinesStatus.ready,
        today: today,
        routines: routinesToday(
          [routine(id: 'm'), routine(id: 'e')],
          const [],
          today: today,
        ),
      ),
    );

    expect(find.text('Routine m'), findsOneWidget);
    expect(find.text('Routine e'), findsOneWidget);
    expect(find.text('Step a'), findsNWidgets(2));
    expect(find.byTooltip('Edit Routine m'), findsOneWidget);
  });

  testWidgets('none yet: what a routine is, and a way to add one', (
    tester,
  ) async {
    await pump(tester, const RoutinesState(status: RoutinesStatus.ready));

    expect(find.text('No routines yet'), findsOneWidget);
    expect(find.text('New routine'), findsNWidgets(2));
  });
}
