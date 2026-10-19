import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/repository/routine_repository.dart';

import '../helpers/app_harness.dart';

// Routines and goals on the real app, as of Wednesday 21 October 2026.
void main() {
  tearDown(getIt.reset);

  double topOf(WidgetTester tester, String text) =>
      tester.getTopLeft(find.text(text)).dy;

  testWidgets('create a routine; checking a step off shows on Today', (
    tester,
  ) async {
    await pumpMomentum(tester, tall: true);
    await tester.openDrawer();
    await tester.tapAndSettle(drawerItem('Routines'));
    await tester.tapAndSettle(find.byType(FloatingActionButton));

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Evening');
    await tester.tap(find.text('Evening').last);
    await tester.enterText(find.widgetWithText(TextField, 'Step 1'), 'Tidy up');
    await tester.tapAndSettle(find.text('Add a step'));
    await tester.enterText(find.widgetWithText(TextField, 'Step 2'), 'Journal');
    await tester.tap(find.text('Save'));
    await tester.pumpUntilFound(find.text('Added Evening'));

    expect(find.text('Tidy up'), findsOneWidget);
    await tester.tap(find.text('Journal'));
    await tester.pumpUntilFound(find.textContaining('1 / 2'));

    await tester.tapAndSettle(find.byTooltip('Back'));
    await tester.pumpUntilFound(find.text('Routines today'));
    expect(find.text('1 / 2'), findsOneWidget);
  });

  testWidgets("a reorder with a screen reader's Move up is saved", (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pumpMomentum(
      tester,
      withDemo: true,
      tall: true,
      initialLocation: '/routines/routine_morning/edit',
    );
    expect(
      topOf(tester, 'Plan the day'),
      greaterThan(topOf(tester, 'Make the bed')),
    );

    final last = find.semantics
        .byPredicate(
          (node) =>
              node.getSemanticsData().customSemanticsActionIds?.isNotEmpty ??
              false,
        )
        .evaluate()
        .last;
    last.owner!.performAction(
      last.id,
      SemanticsAction.customAction,
      CustomSemanticsAction.getIdentifier(
        const CustomSemanticsAction(label: 'Move to the start'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpUntilFound(appBarTitled('Routines'));

    final saved = await tester.runAsync(
      () => getIt<RoutineRepository>().findRoutine('routine_morning'),
    );
    expect(saved!.items.first.title, 'Plan the day');
    expect(
      topOf(tester, 'Plan the day'),
      lessThan(topOf(tester, 'Make the bed')),
    );
    handle.dispose();
  });

  testWidgets('delete a routine, confirmed', (tester) async {
    await pumpMomentum(
      tester,
      withDemo: true,
      tall: true,
      initialLocation: '/routines',
    );

    await tester.tapAndSettle(find.byTooltip('Edit Evening'));
    await tester.tapAndSettle(find.text('Delete routine'));
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpUntilFound(find.text('Deleted Evening'));

    expect(find.text('Tidy the desk'), findsNothing);
    expect(find.text('Morning'), findsWidgets);
  });

  testWidgets('a goal on one habit counts it; completing it on Today moves '
      'the goal', (tester) async {
    await pumpMomentum(tester, withDemo: true, tall: true);
    await tester.openDrawer();
    await tester.tapAndSettle(drawerItem('Goals'));
    await tester.tapAndSettle(find.text('New goal'));

    await tester.enterText(
      find.widgetWithText(TextField, 'Name'),
      'Read daily',
    );
    await tester.tapAndSettle(find.text('One habit'));
    await tester.tapAndSettle(find.text('Read 20 pages'));
    await tester.tapAndSettle(find.text('Daily').last);
    await tester.enterText(
      find.widgetWithText(TextField, 'Completions today'),
      '1',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpUntilFound(find.text('Added Read daily'));
    expect(find.text('0 of 1 today'), findsOneWidget);

    await tester.tapAndSettle(find.byTooltip('Back'));
    await tester.tap(find.byTooltip('Mark Read 20 pages done'));
    await tester.pumpUntilFound(find.text('1 of 1 today'));
    expect(find.text('Done today · Resets tomorrow'), findsOneWidget);
  });

  testWidgets('the routine editor asks before throwing edits away', (
    tester,
  ) async {
    await pumpMomentum(tester, initialLocation: '/routines/new');
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Night');
    await tester.pump();

    await tester.tapAndSettle(find.byTooltip('Close'));
    expect(find.text('Discard changes?'), findsOneWidget);
    await tester.tapAndSettle(find.text('Discard'));
    expect(appBarTitled('Routines'), findsOneWidget);
  });
}
