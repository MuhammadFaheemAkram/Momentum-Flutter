import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';
import 'package:momentum/features/today/cubit/today_cubit.dart';
import 'package:momentum/features/today/cubit/today_state.dart';
import 'package:momentum/features/today/today_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/overview_fixtures.dart';
import '../../helpers/pump_app.dart';

class _MockTodayCubit extends MockCubit<TodayState> implements TodayCubit {}

void main() {
  late _MockTodayCubit cubit;

  setUpAll(() => registerFallbackValue(const HabitNotice('')));
  setUp(() {
    cubit = _MockTodayCubit();
    when(() => cubit.start()).thenReturn(null);
    when(() => cubit.undoNotice(any())).thenAnswer((_) async {});
  });

  Future<void> pump(WidgetTester tester, TodayState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      ShellDrawerScope(
        openDrawer: () {},
        child: BlocProvider<TodayCubit>.value(
          value: cubit,
          child: const TodayView(),
        ),
      ),
    );
  }

  final ready = TodayState(status: TodayStatus.ready, overview: todayFixture());

  testWidgets('the header: the date, the ring, the perfect days, the week', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, ready);

    expect(find.text('Wednesday, 21 October'), findsOneWidget);
    expect(find.text('1 of 3 done'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('1 of 3 habits done today')),
      findsOneWidget,
    );
    // The date is a heading on its own, not the whole card.
    expect(
      tester.getSemantics(find.text('Wednesday, 21 October')),
      isSemantics(label: 'Wednesday, 21 October', isHeader: true),
    );
    expect(find.text('7 perfect days'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        RegExp(
          r'This week: Monday perfect, Tuesday perfect, '
          r'Wednesday \(today\) partly done',
        ),
      ),
      findsOneWidget,
    );
    handle.dispose();
  });

  testWidgets('due habits first, open before done; the rest folded away', (
    tester,
  ) async {
    await pump(tester, ready);

    final titles = tester
        .widgetList<Text>(
          find.textContaining(
            RegExp(r'^(Drink water|Morning run|Read 20 pages|Gym)$'),
          ),
        )
        .map((t) => t.data)
        .toList();
    expect(titles, ['Drink water', 'Morning run', 'Read 20 pages']);
    expect(find.text('Not due today (1)'), findsOneWidget);

    await tester.tap(find.text('Not due today (1)'));
    await tester.pumpAndSettle();
    expect(find.text('Gym'), findsOneWidget);
  });

  testWidgets("today's routines and the goals, after the habits", (
    tester,
  ) async {
    final overview = buildTodayOverview(
      [readHabit],
      const [],
      today: today,
      routines: [routine()],
      checks: [RoutineCheck(itemId: 'r-a', day: today)],
      goals: [goal()],
    );
    await pump(
      tester,
      TodayState(status: TodayStatus.ready, overview: overview),
    );

    expect(find.text('Routines today'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
    expect(find.text('Goals'), findsOneWidget);
    expect(find.text('0 of 5 this week'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Routines today')).dy,
      greaterThan(tester.getTopLeft(find.text('Read 20 pages')).dy),
    );
  });

  testWidgets('no habits, but routines: a way to add a habit', (tester) async {
    await pump(
      tester,
      TodayState(
        status: TodayStatus.ready,
        overview: buildTodayOverview(
          const [],
          const [],
          today: today,
          routines: [routine()],
        ),
      ),
    );

    expect(find.text('No habits yet.'), findsOneWidget);
    expect(find.text('Routines today'), findsOneWidget);
  });

  testWidgets('while loading, a spinner', (tester) async {
    await pump(tester, const TodayState());

    expect(find.text('Loading today…'), findsOneWidget);
  });

  testWidgets('a failure offers Try again', (tester) async {
    await pump(tester, const TodayState(status: TodayStatus.failed));

    await tester.tap(find.text('Try again'));
    verify(() => cubit.start()).called(1);
  });

  testWidgets('no habits: a way to add the first', (tester) async {
    await pump(
      tester,
      TodayState(
        status: TodayStatus.ready,
        overview: buildTodayOverview(const [], const [], today: today),
      ),
    );

    expect(find.text('No habits yet'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'New habit'), findsOneWidget);
  });

  testWidgets('a notice shows as a SnackBar, and its Undo goes to the Cubit', (
    tester,
  ) async {
    const notice = HabitNotice('Skipped Morning run today', unarchive: 'run');
    whenListen(
      cubit,
      Stream.value(ready.copyWith(notice: notice, noticeSerial: 1)),
      initialState: ready,
    );
    tester.useTallPhoneSurface();
    await tester.pumpThemed(
      ShellDrawerScope(
        openDrawer: () {},
        child: BlocProvider<TodayCubit>.value(
          value: cubit,
          child: const TodayView(),
        ),
      ),
    );
    // Settled: while the SnackBar slides in, a tap can land on the FAB.
    await tester.pumpAndSettle();

    expect(find.text('Skipped Morning run today'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    verify(() => cubit.undoNotice(notice)).called(1);
  });

  testWidgets('coming up: the next reminders today, each opening its habit', (
    tester,
  ) async {
    final reminder = PlannedNotification(
      id: 1,
      kind: NotificationKind.reminder,
      day: today,
      time: TimeOfDayValue(18, 0),
      title: 'Read 20 pages',
      body: 'Due today',
      target: const NotificationTarget.habit('read'),
      habitId: 'read',
    );

    await pump(tester, ready.copyWith(upcoming: [reminder]));

    expect(find.text('Coming up'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(ReminderRow),
        matching: find.textContaining(RegExp(r'^Reminder at 6:00\sPM$')),
      ),
      findsOneWidget,
    );
  });

  testWidgets('nothing coming up: no section', (tester) async {
    await pump(tester, ready);

    expect(find.text('Coming up'), findsNothing);
  });
}
