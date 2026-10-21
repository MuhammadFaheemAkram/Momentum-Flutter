import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

import '../helpers/app_harness.dart';

// Whole flows on the real app: real Cubits, use cases and drift (in memory),
// as of Wednesday 21 October 2026.
void main() {
  tearDown(getIt.reset);

  /// A habit's card (not its "Coming up" reminder).
  Finder habitTitled(String title) =>
      find.descendant(of: find.byType(HabitCard), matching: find.text(title));

  testWidgets('create a habit: it is due today; completing it fills the ring '
      'and starts a streak', (tester) async {
    await pumpMomentum(tester);
    expect(find.text('No habits yet'), findsOneWidget);

    await tester.tapAndSettle(find.byType(FloatingActionButton));
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Stretch');
    await tester.tap(find.text('Save'));
    await tester.pumpUntilFound(appBarTitled('Today'));
    await tester.pumpUntilFound(habitTitled('Stretch'));

    expect(find.text('Added Stretch'), findsOneWidget);
    expect(find.text('0 of 1 done'), findsOneWidget);
    expect(find.text('To do today'), findsOneWidget);

    await tester.tap(find.byTooltip('Mark Stretch done'));
    await tester.pumpUntilFound(find.text('All 1 done. Well done!'));
    expect(find.text('1-day streak'), findsOneWidget);
    expect(find.text('1 perfect day'), findsOneWidget);
  });

  testWidgets('skip keeps the streak; Undo puts the day back', (tester) async {
    await pumpMomentum(tester, withDemo: true, tall: true);
    final streak = find.descendant(
      of: find.ancestor(
        of: habitTitled('Read 20 pages'),
        matching: find.byType(Card),
      ),
      matching: find.textContaining('-day streak'),
    );
    final before = tester.widget<Text>(streak).data;

    await tester.tap(find.byTooltip('More for Read 20 pages'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip today'));
    await tester.pumpUntilFound(find.text('Skipped Read 20 pages today'));

    expect(tester.widget<Text>(streak).data, before);
    expect(
      find.descendant(
        of: find.ancestor(
          of: habitTitled('Read 20 pages'),
          matching: find.byType(Card),
        ),
        matching: find.text('Skipped today'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Undo'));
    await tester.pumpUntilFound(
      find.descendant(
        of: find.ancestor(
          of: habitTitled('Read 20 pages'),
          matching: find.byType(Card),
        ),
        matching: find.text('To do today'),
      ),
    );
  });

  testWidgets('a counted habit: +1 until done', (tester) async {
    await pumpMomentum(tester, withDemo: true, tall: true);
    expect(find.text('3 / 8 today'), findsOneWidget);

    for (var i = 0; i < 5; i++) {
      await tester.tap(find.byTooltip('Add one to Drink water'));
      await tester.settleRealAsync();
    }

    expect(find.text('Done · 8 / 8'), findsOneWidget);
  });

  testWidgets('backfill: a missed day on the calendar becomes done', (
    tester,
  ) async {
    await pumpMomentum(
      tester,
      withDemo: true,
      tall: true,
      initialLocation: '/habits/habit_read',
    );
    final missed = find.bySemanticsLabel(RegExp(r': Missed$'));
    final handle = tester.ensureSemantics();
    await tester.pumpAndSettle();
    final before = missed.evaluate().length;
    expect(before, greaterThan(0));

    // The most recent missed day: within the last 30, so it can be set.
    await tester.tap(missed.last);
    await tester.settleRealAsync();

    expect(missed.evaluate().length, before - 1);
    handle.dispose();
  });

  testWidgets('archive from Habits: gone from Today, back with Undo', (
    tester,
  ) async {
    await pumpMomentum(tester, withDemo: true, tall: true);
    expect(habitTitled('Plan tomorrow'), findsOneWidget);

    await tester.tapAndSettle(destination('Habits'));
    await tester.tap(find.byTooltip('More for Plan tomorrow'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archive'));
    await tester.pumpUntilFound(find.text('Archived Plan tomorrow'));
    await tester.tapAndSettle(destination('Today'));

    expect(habitTitled('Plan tomorrow'), findsNothing);
    final habit = await tester.runAsync(
      () => getIt<HabitRepository>().findHabit('habit_plan'),
    );
    expect(habit!.archivedAt, isNotNull);
  });

  testWidgets('delete from a habit page: confirmed, the history goes too', (
    tester,
  ) async {
    await pumpMomentum(tester, withDemo: true, tall: true);
    await tester.tapAndSettle(destination('Habits'));
    await tester.tap(habitTitled('Morning run'));
    await tester.pumpUntilFound(appBarTitled('Morning run'));

    await tester.tapAndSettle(find.byTooltip('More'));
    await tester.tapAndSettle(find.text('Delete'));
    expect(find.text('Delete this habit?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpUntilFound(appBarTitled('Habits'));

    expect(habitTitled('Morning run'), findsNothing);
    final log = await tester.runAsync(
      () => getIt<HabitLogRepository>().findLog(
        'habit_run',
        CalendarDate(2026, 10, 19),
      ),
    );
    expect(log, isNull);
  });

  testWidgets('editing from a habit page changes it everywhere', (
    tester,
  ) async {
    await pumpMomentum(
      tester,
      withDemo: true,
      tall: true,
      initialLocation: '/habits/habit_read',
    );

    await tester.tapAndSettle(find.byTooltip('Edit habit'));
    await tester.enterText(
      find.widgetWithText(TextField, 'Name'),
      'Read 30 pages',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpUntilFound(appBarTitled('Read 30 pages'));
  });

  testWidgets('the form asks before throwing edits away', (tester) async {
    await pumpMomentum(tester, initialLocation: '/habits/new');
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Stretch');
    await tester.pump();

    await tester.tapAndSettle(find.byTooltip('Close'));
    expect(find.text('Discard changes?'), findsOneWidget);
    await tester.tapAndSettle(find.text('Cancel'));
    expect(appBarTitled('New habit'), findsOneWidget);

    await tester.tapAndSettle(find.byTooltip('Close'));
    await tester.tapAndSettle(find.text('Discard'));
    expect(appBarTitled('Habits'), findsOneWidget);
  });
}
