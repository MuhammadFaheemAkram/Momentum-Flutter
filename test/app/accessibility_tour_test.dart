import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

import '../helpers/app_harness.dart';

// Every screen, in light and dark, with text at 200%: no layout overflows
// (an overflow fails the test), tap targets of at least 48 × 48, a label on
// everything tappable, and readable text contrast. Each phase adds its
// screens and states here.
void main() {
  tearDown(getIt.reset);

  for (final brightness in Brightness.values) {
    group('${brightness.name} theme, text at 200%', () {
      Future<void> open(
        WidgetTester tester, {
        required String at,
        bool onboarded = true,
        bool withDemo = false,
        Future<void> Function()? beforeLaunch,
      }) async {
        tester.platformDispatcher
          ..textScaleFactorTestValue = 2
          ..platformBrightnessTestValue = brightness;
        addTearDown(tester.platformDispatcher.clearAllTestValues);
        await pumpMomentum(
          tester,
          onboarded: onboarded,
          withDemo: withDemo,
          initialLocation: at,
          beforeLaunch: beforeLaunch,
        );
        // Phone width, but tall enough to lay out every item of a long list:
        // the checks below see only what is built.
        tester.view.physicalSize = const Size(390 * 3, 6000 * 3);
        await tester.pumpAndSettle();
        final context = tester.element(find.byType(Scaffold).first);
        expect(MediaQuery.textScalerOf(context).scale(10), 20);
        expect(Theme.of(context).brightness, brightness);
      }

      Future<void> expectAccessible(WidgetTester tester) async {
        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      }

      testWidgets('Welcome', (tester) async {
        await open(tester, at: '/welcome', onboarded: false);
        await expectAccessible(tester);
      });

      testWidgets('Welcome, after the demo failed to load', (tester) async {
        await open(tester, at: '/welcome', onboarded: false);
        getIt<NetworkSimulator>().failRequests = true;
        await tester.tap(find.text('Explore with demo data'));
        await tester.pumpUntilFound(find.text('Try again'));
        await expectAccessible(tester);
      });

      testWidgets('the navigation drawer', (tester) async {
        await open(tester, at: '/today');
        await tester.openDrawer();
        expect(find.byType(Drawer), findsOneWidget);
        await expectAccessible(tester);
      });

      // With the demo: real habits, streaks, counts and a full calendar.
      for (final (name, location) in [
        ('Today', '/today'),
        ('Habits', '/habits'),
        ('Habit detail (a counted habit)', '/habits/habit_water'),
        ('Habit detail (a weekly habit)', '/habits/habit_spanish'),
        ('Edit habit', '/habits/habit_run/edit'),
      ]) {
        testWidgets(name, (tester) async {
          await open(tester, at: location, withDemo: true);
          await expectAccessible(tester);
        });
      }

      testWidgets('Today, with the habits not due expanded', (tester) async {
        // Every demo habit is due on a Wednesday: add one that isn't.
        await open(
          tester,
          at: '/today',
          withDemo: true,
          beforeLaunch: () => tester.runAsync(
            () => getIt<HabitRepository>().createHabit(
              HabitDraft(
                title: 'Gym',
                category: HabitCategory.fitness,
                color: HabitColor.orange,
                icon: HabitIcon.fitness,
                schedule: const HabitSchedule.onWeekdays({2}),
                startDate: CalendarDate(2026, 10, 1),
              ),
            ),
          ),
        );
        await tester.tap(find.textContaining('Not due today ('));
        await tester.pumpAndSettle();
        await expectAccessible(tester);
      });

      testWidgets('Habits, archived shown', (tester) async {
        await open(tester, at: '/habits', withDemo: true);
        await tester.tap(find.byTooltip('More for Plan tomorrow'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Archive'));
        await tester.pumpUntilFound(find.textContaining('Show archived'));
        await tester.tap(find.textContaining('Show archived'));
        await tester.pumpAndSettle();
        expect(find.text('Archived'), findsOneWidget);
        await expectAccessible(tester);
      });

      testWidgets('New habit, with its errors and every schedule choice', (
        tester,
      ) async {
        await open(tester, at: '/habits/new');
        await tester.tap(find.text('Some days'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
        expect(find.text('Give the habit a name'), findsOneWidget);
        await expectAccessible(tester);
      });

      // Empty, or nothing to show yet.
      for (final (name, location) in [
        ('Today, empty', '/today'),
        ('Habits, empty', '/habits'),
        ('Habit detail, not found', '/habits/h1'),
        ('Analytics', '/analytics'),
        ('Achievements', '/achievements'),
        ('Settings', '/settings'),
        ('Routines', '/routines'),
        ('New routine', '/routines/new'),
        ('Goals', '/goals'),
        ('Search', '/search'),
        ('About', '/about'),
      ]) {
        testWidgets(name, (tester) async {
          await open(tester, at: location);
          await expectAccessible(tester);
        });
      }
    });
  }

  testWidgets('the tab labels keep their size at any text setting (a long '
      'press shows them)', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 3;
    addTearDown(tester.platformDispatcher.clearAllTestValues);
    await pumpMomentum(tester);

    final label = destination('Analytics');
    final inBar = tester.element(label);
    expect(MediaQuery.textScalerOf(inBar).scale(10), 10);

    final before = find.text('Analytics').evaluate().length;
    await tester.longPress(label);
    await tester.pumpAndSettle();
    // One more: the tooltip over the bar.
    expect(find.text('Analytics'), findsNWidgets(before + 1));
  });

  testWidgets('a long press on a shortened tab label shows the full name', (
    tester,
  ) async {
    await pumpMomentum(tester);

    expect(find.text('Achievements'), findsNothing);
    await tester.longPress(destination('Badges'));
    await tester.pumpAndSettle();
    expect(find.text('Achievements'), findsOneWidget);
  });
}
