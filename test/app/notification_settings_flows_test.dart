import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/app/momentum_app.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

import '../helpers/app_harness.dart';
import '../helpers/fakes/fake_notification_scheduler.dart';
import '../helpers/habit_builders.dart';

// Notifications, background work and Settings on the real app, as of
// Wednesday 21 October 2026, 15:00.
void main() {
  tearDown(getIt.reset);

  /// The notification watcher waits for writes to settle (300 ms of fake
  /// time) and syncs on the real event loop: both have to move.
  Future<void> letSyncSettle(WidgetTester tester, bool Function() done) async {
    for (var i = 0; i < 20 && !done(); i++) {
      await tester.pump(const Duration(milliseconds: 400));
      await tester.settleRealAsync();
    }
    expect(done(), isTrue, reason: 'never synced');
  }

  group('notification taps', () {
    testWidgets("a reminder's tap opens its habit, over where you were", (
      tester,
    ) async {
      final notifications = FakeNotificationScheduler();
      await pumpMomentum(tester, withDemo: true, notifications: notifications);
      await tester.tapAndSettle(destination('Settings'));

      notifications.tap(const NotificationTarget.habit('habit_read'));
      await tester.pumpUntilFound(appBarTitled('Read 20 pages'));

      // Back leads to where the user was.
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(appBarTitled('Settings'), findsOneWidget);
    });

    testWidgets('the nudge opens Today', (tester) async {
      final notifications = FakeNotificationScheduler();
      await pumpMomentum(tester, withDemo: true, notifications: notifications);
      await tester.tapAndSettle(destination('Habits'));

      notifications.tap(const NotificationTarget.today());
      await tester.pumpAndSettle();

      expect(tester.selectedTab, 0);
    });

    testWidgets('a tap that launched the app opens straight on the habit', (
      tester,
    ) async {
      await pumpMomentum(
        tester,
        withDemo: true,
        initialLocation: MomentumApp.locationFor(
          const NotificationTarget.habit('habit_read'),
        ),
      );
      await tester.settleRealAsync();

      expect(appBarTitled('Read 20 pages'), findsOneWidget);
      expect(MomentumApp.locationFor(const NotificationTarget.today()), isNull);
    });

    testWidgets('"Mark done" reaching the app completes the habit today', (
      tester,
    ) async {
      final notifications = FakeNotificationScheduler();
      await pumpMomentum(
        tester,
        withDemo: true,
        tall: true,
        notifications: notifications,
      );

      notifications.chooseMarkDone('habit_read');
      await tester.settleRealAsync();

      final log = await tester.runAsync(
        () => getIt<HabitLogRepository>().findLog('habit_read', today),
      );
      expect(log!.count, 1);
    });
  });

  group('Settings', () {
    testWidgets('turning notifications on asks, then plans the next 7 days', (
      tester,
    ) async {
      final notifications = FakeNotificationScheduler();
      await pumpMomentum(
        tester,
        withDemo: true,
        tall: true,
        notifications: notifications,
      );
      await tester.tapAndSettle(destination('Settings'));

      await tester.tap(find.widgetWithText(SwitchListTile, 'Notifications'));
      await letSyncSettle(tester, () => notifications.pendingById.isNotEmpty);

      expect(notifications.calls.first, 'request');
      expect(find.text('Missed-habit nudge'), findsOneWidget);
      final reminders = notifications.scheduled.values.where(
        (n) => n.kind == NotificationKind.reminder,
      );
      expect(reminders, isNotEmpty);
    });

    testWidgets('denied: stays off, with the way to the system settings', (
      tester,
    ) async {
      final notifications = FakeNotificationScheduler(grantsWhenAsked: false);
      await pumpMomentum(tester, tall: true, notifications: notifications);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tap(find.widgetWithText(SwitchListTile, 'Notifications'));
      await tester.settleRealAsync();
      await tester.tapAndSettle(find.text('Open settings'));

      expect(notifications.calls, ['request', 'openSettings']);
      expect(getIt<SettingsRepository>().current.notificationsEnabled, isFalse);
    });

    testWidgets('a permission revoked while away turns the switch off on '
        'resume, and nothing stays scheduled', (tester) async {
      final notifications = FakeNotificationScheduler(permitted: true);
      await pumpMomentum(
        tester,
        withDemo: true,
        tall: true,
        notifications: notifications,
        preferences: const {'settings.notificationsEnabled': true},
      );
      await letSyncSettle(tester, () => notifications.pendingById.isNotEmpty);
      await tester.tapAndSettle(destination('Settings'));

      notifications.permitted = false;
      // Away and back, through every state between (as the engine reports
      // them).
      for (final state in [
        AppLifecycleState.inactive,
        AppLifecycleState.hidden,
        AppLifecycleState.paused,
        AppLifecycleState.hidden,
        AppLifecycleState.inactive,
        AppLifecycleState.resumed,
      ]) {
        tester.binding.handleAppLifecycleStateChanged(state);
      }
      await letSyncSettle(tester, () => notifications.pendingById.isEmpty);

      expect(getIt<SettingsRepository>().current.notificationsEnabled, isFalse);
      expect(
        tester
            .widget<SwitchListTile>(
              find.widgetWithText(SwitchListTile, 'Notifications'),
            )
            .value,
        isFalse,
      );
    });

    testWidgets('Dark applies app-wide at once, and is kept', (tester) async {
      await pumpMomentum(tester);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tapAndSettle(find.text('Dark'));

      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );
      await tester.tapAndSettle(destination('Today'));
      expect(
        Theme.of(tester.element(find.text('Today').first)).brightness,
        Brightness.dark,
      );
    });

    testWidgets("a new habit's reminder starts at the default reminder time", (
      tester,
    ) async {
      await pumpMomentum(
        tester,
        tall: true,
        preferences: const {'settings.defaultReminder': '07:30'},
      );

      await tester.tapAndSettle(find.text('New habit').first);
      await tester.tapAndSettle(find.text('Remind me'));

      expect(find.textContaining(RegExp(r'^7:30\sAM$')), findsOneWidget);
    });

    testWidgets('Back up now: the result, and the last backup', (tester) async {
      await pumpMomentum(tester, withDemo: true, tall: true);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tap(find.text('Back up now'));
      await tester.pumpUntilFound(find.textContaining('Backed up 6 habits'));

      expect(
        find.textContaining(RegExp(r'^Last backup: Today, 3:00\sPM$')),
        findsOneWidget,
      );
    });

    testWidgets(
      'Reset progress: confirmed, the history goes, the habits stay',
      (tester) async {
        await pumpMomentum(tester, withDemo: true, tall: true);
        await tester.tapAndSettle(destination('Settings'));

        await tester.tapAndSettle(find.text('Reset progress'));
        await tester.tapAndSettle(find.text('Reset'));
        await tester.pumpUntilFound(find.textContaining('Progress reset.'));
        await tester.tapAndSettle(destination('Today'));

        expect(find.text('0 of 6 done'), findsOneWidget);
        expect(find.text('Read 20 pages'), findsWidgets);
        final logs = await tester.runAsync(
          () => getIt<HabitLogRepository>().watchLogs().first,
        );
        expect(logs, isEmpty);
      },
    );

    testWidgets('Run background tasks now: the same tasks, reported', (
      tester,
    ) async {
      await pumpMomentum(tester, withDemo: true, tall: true);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tap(find.text('Run background tasks now'));
      await tester.pumpUntilFound(find.textContaining('Background tasks done'));

      expect(find.textContaining('notifications off'), findsOneWidget);
    });

    testWidgets('Show planned notifications lists the plan', (tester) async {
      await pumpMomentum(tester, withDemo: true, tall: true);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tap(find.text('Show planned notifications'));
      await tester.pumpUntilFound(find.text('Planned notifications'));

      expect(
        find.textContaining('Notifications are off, so nothing is scheduled'),
        findsOneWidget,
      );
      expect(find.text('Read 20 pages'), findsWidgets);
    });

    testWidgets('About shows the version and the other editions', (
      tester,
    ) async {
      await pumpMomentum(tester, tall: true);
      await tester.tapAndSettle(destination('Settings'));

      await tester.tapAndSettle(find.text('About Momentum'));

      expect(find.text('Version 1.0.0 (1)'), findsOneWidget);
      expect(find.text('Android'), findsOneWidget);
      expect(find.text('iOS'), findsOneWidget);
    });
  });
}
