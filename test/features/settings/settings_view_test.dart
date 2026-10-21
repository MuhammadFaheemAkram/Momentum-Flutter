import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/device_info.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/features/settings/cubit/settings_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_state.dart';
import 'package:momentum/features/settings/cubit/settings_tools_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_tools_state.dart';
import 'package:momentum/features/settings/settings_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class _MockToolsCubit extends MockCubit<SettingsToolsState>
    implements SettingsToolsCubit {}

void main() {
  late _MockSettingsCubit settings;
  late _MockToolsCubit tools;

  setUpAll(() => registerFallbackValue(AppThemeMode.system));
  setUp(() {
    settings = _MockSettingsCubit();
    tools = _MockToolsCubit();
    when(() => settings.setThemeMode(any())).thenAnswer((_) async {});
    when(() => tools.setNotificationsEnabled(enabled: any(named: 'enabled')))
        .thenAnswer((_) async {});
    when(() => tools.setNudge(enabled: any(named: 'enabled')))
        .thenAnswer((_) async {});
    when(() => tools.openNotificationSettings()).thenAnswer((_) async {});
    when(() => tools.resetProgress()).thenAnswer((_) async {});
  });

  final idle = SettingsToolsState(today: today);

  Future<void> pump(
    WidgetTester tester, {
    AppSettings values = const AppSettings(),
    DeviceColors device = const DeviceColors(),
    SettingsToolsState? state,
    double textScale = 1,
  }) async {
    when(() => settings.state)
        .thenReturn(SettingsState(settings: values, deviceColors: device));
    when(() => tools.state).thenReturn(state ?? idle);
    tester.useTallPhoneSurface();
    await tester.pumpThemed(
      MediaQuery(
        // A 24-hour clock, so times read "20:00".
        data: MediaQueryData(
          textScaler: TextScaler.linear(textScale),
          alwaysUse24HourFormat: true,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>.value(value: settings),
            BlocProvider<SettingsToolsCubit>.value(value: tools),
          ],
          child: const SettingsView(version: '1.0.0 (1)'),
        ),
      ),
    );
  }

  Finder switchTile(String title) => find.widgetWithText(SwitchListTile, title);

  group('notifications', () {
    testWidgets('off: the switch asks; only the default reminder shows', (
      tester,
    ) async {
      await pump(tester);

      expect(find.text('Missed-habit nudge'), findsNothing);
      expect(find.text('For new habits: 09:00'), findsOneWidget);

      await tester.tap(switchTile('Notifications'));
      verify(() => tools.setNotificationsEnabled(enabled: true)).called(1);
    });

    testWidgets('denied: a card leads to the system settings', (tester) async {
      await pump(tester, state: idle.copyWith(notificationsDenied: true));

      expect(
        find.textContaining('Notifications are off for Momentum'),
        findsOneWidget,
      );
      await tester.tap(find.text('Open settings'));
      verify(() => tools.openNotificationSettings()).called(1);
    });

    testWidgets('on: the nudge and the summary, with their times', (
      tester,
    ) async {
      await pump(tester, values: const AppSettings(notificationsEnabled: true));

      expect(find.text('At 20:00, if habits are still open'), findsOneWidget);
      expect(find.text('At 21:30: how the day went'), findsOneWidget);
      expect(find.text('Nudge time'), findsOneWidget);
      expect(find.text('Summary time'), findsOneWidget);

      await tester.tap(switchTile('Missed-habit nudge'));
      verify(() => tools.setNudge(enabled: false)).called(1);
    });

    testWidgets('a nudge turned off hides its time', (tester) async {
      await pump(
        tester,
        values: const AppSettings(
          notificationsEnabled: true,
          nudgeEnabled: false,
        ),
      );

      expect(find.text('Nudge time'), findsNothing);
      expect(find.text('Summary time'), findsOneWidget);
    });

    testWidgets('while asking, the switch waits', (tester) async {
      await pump(
        tester,
        state: idle.copyWith(running: SettingsTask.notifications),
      );

      expect(
        tester.widget<SwitchListTile>(switchTile('Notifications')).onChanged,
        isNull,
      );
    });
  });

  group('appearance', () {
    testWidgets('three segments; dynamic color only where the device has it', (
      tester,
    ) async {
      await pump(tester);

      expect(find.byType(SegmentedButton<AppThemeMode>), findsOneWidget);
      expect(find.text('Dynamic color'), findsNothing);

      await tester.tap(find.text('Dark'));
      verify(() => settings.setThemeMode(AppThemeMode.dark)).called(1);
    });

    testWidgets('Android 12+: the dynamic color switch', (tester) async {
      await pump(
        tester,
        device: const DeviceColors(wallpaperColor: 0xFF3355AA),
      );

      expect(switchTile('Dynamic color'), findsOneWidget);
    });

    testWidgets('switch tiles have their icons at normal sizes', (
      tester,
    ) async {
      await pump(tester);

      expect(
        find.descendant(
          of: switchTile('Notifications'),
          matching: find.byIcon(Icons.notifications_outlined),
        ),
        findsOneWidget,
      );
    });

    testWidgets('at large text, switch tiles drop their icons, so a title '
        'like "Notifications" keeps its width beside the switch', (
      tester,
    ) async {
      // Checked on an iPhone at the largest accessibility size, where the
      // title broke mid-word with the icon; the test font's square glyphs
      // can't measure that, so this pins the rule.
      await pump(
        tester,
        values: const AppSettings(notificationsEnabled: true),
        textScale: 2,
      );

      // Every switch tile built, those of the notifications among them.
      final tiles = tester.widgetList<SwitchListTile>(
        find.byType(SwitchListTile),
      );
      expect(tiles.length, greaterThanOrEqualTo(3));
      expect(switchTile('Missed-habit nudge'), findsOneWidget);
      for (final tile in tiles) {
        expect(tile.secondary, isNull);
      }
    });

    testWidgets('at large text: a radio list, every label whole', (
      tester,
    ) async {
      await pump(tester, textScale: 2);

      expect(find.byType(RadioListTile<AppThemeMode>), findsNWidgets(3));
      expect(find.byType(SegmentedButton<AppThemeMode>), findsNothing);
    });
  });

  group('backup and data', () {
    testWidgets('never backed up', (tester) async {
      await pump(tester);

      expect(find.text('Never backed up'), findsOneWidget);
    });

    testWidgets("the last backup's day and time", (tester) async {
      await pump(
        tester,
        values: AppSettings(lastBackupAt: DateTime(2026, 10, 20, 23, 4)),
      );

      expect(find.text('Last backup: Yesterday, 23:04'), findsOneWidget);
    });

    testWidgets('backing up: a progress indicator, and the tools wait', (
      tester,
    ) async {
      await pump(tester, state: idle.copyWith(running: SettingsTask.backup));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester
            .widget<ListTile>(find.widgetWithText(ListTile, 'Reset progress'))
            .enabled,
        isFalse,
      );
    });

    testWidgets('Reset progress asks first', (tester) async {
      await pump(tester);

      await tester.tap(find.text('Reset progress'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => tools.resetProgress());

      await tester.tap(find.text('Reset progress'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();
      verify(() => tools.resetProgress()).called(1);
    });
  });

  testWidgets('a message shows once, as a SnackBar', (tester) async {
    whenListen(
      tools,
      Stream.value(idle.copyWith(message: 'Backed up', messageSerial: 1)),
      initialState: idle,
    );
    await pump(tester);
    await tester.pump();

    expect(find.text('Backed up'), findsOneWidget);
  });

  testWidgets('the plan opens in a sheet', (tester) async {
    final reminder = PlannedNotification(
      id: 1,
      kind: NotificationKind.reminder,
      day: today,
      time: TimeOfDayValue(18, 0),
      title: 'Drink water',
      body: '3 of 8 so far today',
      target: const NotificationTarget.habit('water'),
      habitId: 'water',
    );
    whenListen(
      tools,
      Stream.value(
        idle.copyWith(
          plan: NotificationPlanPreview(
            plan: [reminder],
            pending: 1,
            enabled: true,
          ),
          planSerial: 1,
        ),
      ),
      initialState: idle,
    );
    await pump(tester);
    await tester.pumpAndSettle();

    expect(find.text('Planned notifications'), findsOneWidget);
    expect(
      find.text('1 planned for the next 7 days; 1 scheduled on this device.'),
      findsOneWidget,
    );
    // The sheet is on the root navigator, outside the test's 24-hour
    // MediaQuery; intl puts a narrow no-break space before "PM".
    expect(
      find.textContaining(
        RegExp(r'^Today, 6:00\sPM · Reminder\n3 of 8 so far today$'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('About shows the version', (tester) async {
    await pump(tester);

    expect(find.text('Version 1.0.0 (1)'), findsOneWidget);
  });
}
