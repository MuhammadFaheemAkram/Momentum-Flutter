import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/di/injection.dart';

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
      }) async {
        tester.platformDispatcher
          ..textScaleFactorTestValue = 2
          ..platformBrightnessTestValue = brightness;
        addTearDown(tester.platformDispatcher.clearAllTestValues);
        await pumpMomentum(tester, onboarded: onboarded, initialLocation: at);
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

      for (final (name, location) in [
        ('Today', '/today'),
        ('Habits', '/habits'),
        ('Analytics', '/analytics'),
        ('Achievements', '/achievements'),
        ('Settings', '/settings'),
        ('New habit', '/habits/new'),
        ('Habit detail', '/habits/h1'),
        ('Edit habit', '/habits/h1/edit'),
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
