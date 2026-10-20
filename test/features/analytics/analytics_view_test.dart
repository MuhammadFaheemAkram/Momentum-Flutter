import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/calculation/analytics.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/features/analytics/analytics_page.dart';
import 'package:momentum/features/analytics/cubit/analytics_cubit.dart';
import 'package:momentum/features/analytics/cubit/analytics_state.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockAnalyticsCubit extends MockCubit<AnalyticsState>
    implements AnalyticsCubit {}

void main() {
  late _MockAnalyticsCubit cubit;

  setUp(() => cubit = _MockAnalyticsCubit());

  Future<void> pump(WidgetTester tester, AnalyticsState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      ShellDrawerScope(
        openDrawer: () {},
        child: BlocProvider<AnalyticsCubit>.value(
          value: cubit,
          child: const AnalyticsView(),
        ),
      ),
    );
  }

  testWidgets('the figures, the charts with their summaries, and the lists', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final read = habit(
      id: 'read',
      start: oct(1),
    ).copyWith(title: 'Read', category: HabitCategory.reading);
    await pump(
      tester,
      AnalyticsState(
        status: AnalyticsStatus.ready,
        overview: buildAnalytics([
          history(read, doneEvery(oct(1), oct(20), id: 'read')),
        ], today: today),
      ),
    );

    expect(find.text('100%'), findsOneWidget);
    expect(find.text('20 days · Read'), findsOneWidget);
    expect(find.text('20'), findsWidgets);
    // 4, 7, 7 and 2 since the 1st; the first of the two busiest weeks.
    expect(
      find.bySemanticsLabel(
        RegExp('^Last 8 weeks: 20 completions. Most: the week of 5 Oct, 7.'),
      ),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(RegExp('^Last 6 months: 20 completions.')),
      findsOneWidget,
    );
    expect(find.text('Most successful'), findsOneWidget);
    expect(find.text('20 · 100%'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('nothing done yet: says so', (tester) async {
    await pump(
      tester,
      AnalyticsState(
        status: AnalyticsStatus.ready,
        overview: buildAnalytics(const [], today: today),
      ),
    );

    expect(find.text('Nothing to add up yet'), findsOneWidget);
  });
}
