import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/features/welcome/cubit/welcome_cubit.dart';
import 'package:momentum/features/welcome/cubit/welcome_state.dart';
import 'package:momentum/features/welcome/welcome_page.dart';

import '../../helpers/pump_app.dart';

class _MockWelcomeCubit extends MockCubit<WelcomeState>
    implements WelcomeCubit {}

void main() {
  late _MockWelcomeCubit cubit;

  setUp(() {
    cubit = _MockWelcomeCubit();
    when(() => cubit.exploreDemo()).thenAnswer((_) async {});
    when(() => cubit.startEmpty()).thenAnswer((_) async {});
  });

  Future<void> pump(WidgetTester tester, WelcomeState state) {
    when(() => cubit.state).thenReturn(state);
    tester.usePhoneSurface();
    return tester.pumpThemed(
      BlocProvider<WelcomeCubit>.value(
        value: cubit,
        child: const WelcomeView(),
      ),
    );
  }

  FilledButton demoButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.byType(FilledButton));

  TextButton emptyButton(WidgetTester tester) =>
      tester.widget<TextButton>(find.byType(TextButton));

  testWidgets('each choice goes to the Cubit', (tester) async {
    await pump(tester, const WelcomeState());

    await tester.tap(find.text('Explore with demo data'));
    await tester.tap(find.text('Start empty'));

    verify(() => cubit.exploreDemo()).called(1);
    verify(() => cubit.startEmpty()).called(1);
  });

  testWidgets('while the demo loads, its button spins and both wait', (
    tester,
  ) async {
    await pump(tester, const WelcomeState(starting: StartChoice.demo));

    expect(find.text('Explore with demo data'), findsNothing);
    expect(find.bySemanticsLabel('Loading the demo'), findsOneWidget);
    expect(demoButton(tester).onPressed, isNull);
    expect(emptyButton(tester).onPressed, isNull);
  });

  testWidgets('while starting empty, both wait', (tester) async {
    await pump(tester, const WelcomeState(starting: StartChoice.empty));

    expect(find.bySemanticsLabel('Starting'), findsOneWidget);
    expect(demoButton(tester).onPressed, isNull);
  });

  testWidgets('a failed demo shows why, offers Try again, and still allows '
      'starting empty', (tester) async {
    await pump(
      tester,
      const WelcomeState(errorMessage: "Couldn't reach the server."),
    );

    expect(find.text("Couldn't reach the server."), findsOneWidget);
    expect(find.text('Explore with demo data'), findsNothing);
    await tester.tap(find.text('Try again'));
    verify(() => cubit.exploreDemo()).called(1);
    expect(emptyButton(tester).onPressed, isNotNull);
  });

  testWidgets('the error is announced when it appears (a live region)', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, const WelcomeState(errorMessage: 'Offline.'));

    expect(
      tester.getSemantics(find.text('Offline.')),
      isSemantics(isLiveRegion: true),
    );
    handle.dispose();
  });
}
