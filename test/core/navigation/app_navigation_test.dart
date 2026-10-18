import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';

import '../../helpers/app_harness.dart';

void main() {
  tearDown(getIt.reset);

  // (the tab bar's label, the drawer's)
  const tabs = [
    ('Today', 'Today'),
    ('Habits', 'Habits'),
    ('Analytics', 'Analytics'),
    ('Badges', 'Achievements'),
    ('Settings', 'Settings'),
  ];

  group('first launch', () {
    testWidgets('opens on Welcome, without the tab bar', (tester) async {
      await pumpMomentum(tester, onboarded: false);

      expect(find.text('Explore with demo data'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('a deep link waits behind Welcome', (tester) async {
      await pumpMomentum(
        tester,
        onboarded: false,
        initialLocation: '/habits/h1',
      );

      expect(find.text('Explore with demo data'), findsOneWidget);
    });

    for (final choice in ['Explore with demo data', 'Start empty']) {
      testWidgets('"$choice" lands on Today, and Welcome is gone', (
        tester,
      ) async {
        await pumpMomentum(tester, onboarded: false);

        await tester.tapAndSettle(find.text(choice));

        expect(appBarTitled('Today'), findsOneWidget);
        expect(tester.selectedTab, 0);
        expect(find.text(choice), findsNothing);
      });
    }
  });

  group('tabs', () {
    testWidgets('the app opens on Today', (tester) async {
      await pumpMomentum(tester);

      expect(appBarTitled('Today'), findsOneWidget);
      expect(tester.selectedTab, 0);
    });

    testWidgets('each tab shows its own screen', (tester) async {
      await pumpMomentum(tester);

      for (final (index, tab, title) in [
        (1, 'Habits', 'Habits'),
        (2, 'Analytics', 'Analytics'),
        (3, 'Badges', 'Achievements'),
        (4, 'Settings', 'Settings'),
        (0, 'Today', 'Today'),
      ]) {
        await tester.tapAndSettle(destination(tab));
        expect(tester.selectedTab, index);
        expect(appBarTitled(title), findsOneWidget);
      }
    });
  });

  group('the drawer', () {
    testWidgets('opens over the whole screen, tab bar included, from every '
        'tab', (tester) async {
      await pumpMomentum(tester);

      for (final (tab, item) in tabs) {
        await tester.tapAndSettle(destination(tab));
        await tester.openDrawer();
        expect(find.byType(Drawer), findsOneWidget);
        // The modal barrier sits above the tab bar.
        expect(destination(tab).hitTestable(), findsNothing);
        await tester.tapAndSettle(drawerItem(item));
        expect(find.byType(Drawer), findsNothing);
      }
    });

    testWidgets('marks the current tab, and switches tabs', (tester) async {
      await pumpMomentum(tester);
      await tester.openDrawer();

      final selected = tester
          .widgetList<ListTile>(
            find.descendant(
              of: find.byType(Drawer),
              matching: find.byType(ListTile),
            ),
          )
          .where((tile) => tile.selected);
      expect(selected.map((tile) => (tile.title! as Text).data), ['Today']);

      await tester.tapAndSettle(drawerItem('Achievements'));
      expect(appBarTitled('Achievements'), findsOneWidget);
      expect(tester.selectedTab, 3);
    });

    for (final screen in ['Routines', 'Goals', 'Search', 'About']) {
      testWidgets('$screen opens above the tabs, and Back returns to the '
          'tab', (tester) async {
        await pumpMomentum(tester);
        await tester.tapAndSettle(destination('Habits'));
        await tester.openDrawer();

        await tester.tapAndSettle(drawerItem(screen));
        expect(appBarTitled(screen), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);

        await tester.tapAndSettle(find.byType(BackButton));
        expect(appBarTitled('Habits'), findsOneWidget);
        expect(tester.selectedTab, 1);
      });
    }
  });

  group('search', () {
    for (final tab in ['Today', 'Habits']) {
      testWidgets("$tab's app bar opens Search", (tester) async {
        await pumpMomentum(tester);
        await tester.tapAndSettle(destination(tab));

        await tester.tapAndSettle(find.byTooltip('Search'));

        expect(appBarTitled('Search'), findsOneWidget);
      });
    }
  });

  group('the habit form', () {
    for (final tab in ['Today', 'Habits']) {
      testWidgets("$tab's New habit opens the form as a full-screen dialog, "
          'and Close returns', (tester) async {
        await pumpMomentum(tester);
        await tester.tapAndSettle(destination(tab));

        await tester.tapAndSettle(find.text('New habit'));
        expect(appBarTitled('New habit'), findsOneWidget);
        expect(find.byType(NavigationBar), findsNothing);

        await tester.tapAndSettle(find.byType(CloseButton));
        expect(appBarTitled(tab), findsOneWidget);
      });
    }

    testWidgets('"/habits/new" by link: Close goes to Habits', (tester) async {
      await pumpMomentum(tester, initialLocation: '/habits/new');

      expect(appBarTitled('New habit'), findsOneWidget);
      await tester.tapAndSettle(find.byType(CloseButton));
      expect(appBarTitled('Habits'), findsOneWidget);
    });

    testWidgets('an edit link opens over its habit, and Close returns to it', (
      tester,
    ) async {
      await pumpMomentum(tester, initialLocation: '/habits/h1/edit');

      expect(appBarTitled('Edit habit'), findsOneWidget);
      await tester.tapAndSettle(find.byType(CloseButton));
      expect(appBarTitled('Habit'), findsOneWidget);
    });
  });

  group('routines', () {
    testWidgets('"/routines/new" is the editor, and Close returns to '
        'Routines', (tester) async {
      await pumpMomentum(tester, initialLocation: '/routines/new');

      expect(appBarTitled('New routine'), findsOneWidget);
      await tester.tapAndSettle(find.byType(CloseButton));
      expect(appBarTitled('Routines'), findsOneWidget);
    });

    testWidgets('a routine link opens the editor for it', (tester) async {
      await pumpMomentum(tester, initialLocation: '/routines/r1/edit');

      expect(appBarTitled('Edit routine'), findsOneWidget);
    });
  });

  group('deep links above the tabs', () {
    for (final (location, title, home) in [
      ('/habits/h1', 'Habit', 'Habits'),
      ('/routines', 'Routines', 'Today'),
      ('/goals', 'Goals', 'Today'),
      ('/search', 'Search', 'Today'),
      ('/about', 'About', 'Settings'),
    ]) {
      testWidgets('$location opens with a Close button to $home', (
        tester,
      ) async {
        await pumpMomentum(tester, initialLocation: location);
        expect(appBarTitled(title), findsOneWidget);

        await tester.tapAndSettle(find.byTooltip('Close'));

        expect(appBarTitled(home), findsOneWidget);
      });
    }
  });

  testWidgets('an unknown location shows "Page not found", with a way back', (
    tester,
  ) async {
    await pumpMomentum(tester, initialLocation: '/nowhere');
    expect(find.text('Page not found'), findsOneWidget);

    await tester.tapAndSettle(find.text('Go to Today'));
    expect(appBarTitled('Today'), findsOneWidget);
  });
}
