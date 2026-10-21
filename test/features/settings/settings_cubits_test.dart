import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/device_info.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';
import 'package:momentum/domain/usecase/settings_use_cases.dart';
import 'package:momentum/features/settings/cubit/settings_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_tools_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_tools_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/user_data_fixtures.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  group('SettingsCubit', () {
    SettingsCubit open({int? wallpaper}) {
      final cubit = SettingsCubit(
        stack.settings,
        UpdateThemeModeUseCase(stack.settings),
        UpdateDynamicColorUseCase(stack.settings),
        DeviceColors(wallpaperColor: wallpaper),
      )..load();
      addTearDown(cubit.close);
      return cubit;
    }

    test('follows the settings: a theme mode applies at once', () async {
      final cubit = open();

      await cubit.setThemeMode(AppThemeMode.dark);

      await waitFor(cubit, (s) => s.settings.themeMode == AppThemeMode.dark);
    });

    test(
      'the wallpaper seeds the theme only while dynamic color is on',
      () async {
        final cubit = open(wallpaper: 0xFF3355AA);
        expect(cubit.state.dynamicSeed, 0xFF3355AA);

        await cubit.setDynamicColor(enabled: false);

        await waitFor(cubit, (s) => s.dynamicSeed == null);
      },
    );

    test('a device without a palette: the app\'s own colors', () {
      expect(open().state.dynamicSeed, isNull);
    });
  });

  group('SettingsToolsCubit', () {
    SettingsToolsCubit open() {
      final cubit = SettingsToolsCubit(
        stack.setNotificationsEnabled,
        OpenNotificationSettingsUseCase(stack.notifications),
        UpdateNudgeUseCase(stack.settings),
        UpdateSummaryUseCase(stack.settings),
        UpdateDefaultReminderUseCase(stack.settings),
        SetAutoBackupUseCase(stack.settings),
        stack.backUpNow,
        stack.resetProgress,
        stack.runBackgroundTasks,
        stack.previewPlan,
        stack.network,
        stack.calendar,
      );
      addTearDown(cubit.close);
      return cubit;
    }

    test('notifications allowed: on, no card', () async {
      final cubit = open();

      await cubit.setNotificationsEnabled(enabled: true);

      expect(stack.settings.current.notificationsEnabled, isTrue);
      expect(cubit.state.notificationsDenied, isFalse);
      expect(cubit.state.running, isNull);
    });

    test('notifications denied: off, and the card shows; it opens the '
        'system settings', () async {
      stack.notifications.grantsWhenAsked = false;
      final cubit = open();

      await cubit.setNotificationsEnabled(enabled: true);
      await cubit.openNotificationSettings();

      expect(stack.settings.current.notificationsEnabled, isFalse);
      expect(cubit.state.notificationsDenied, isTrue);
      expect(stack.notifications.calls, ['request', 'openSettings']);
    });

    test('the nudge, the summary and the default reminder', () async {
      final cubit = open();

      await cubit.setNudge(enabled: false);
      await cubit.setSummary(time: TimeOfDayValue(22, 15));
      await cubit.setDefaultReminder(TimeOfDayValue(6, 45));
      await cubit.setAutoBackup(enabled: true);

      expect(
        stack.settings.current,
        AppSettings(
          nudgeEnabled: false,
          summaryTime: TimeOfDayValue(22, 15),
          defaultReminder: TimeOfDayValue(6, 45),
          autoBackup: true,
        ),
      );
    });

    test('Back up now: what was backed up', () async {
      await stack.seed(fullUserData());
      final cubit = open();

      await cubit.backUpNow();

      expect(cubit.state.message, 'Backed up 3 habits, 3 logs');
      expect(cubit.state.messageSerial, 1);
    });

    test('Back up now, offline: why it failed', () async {
      final cubit = open()..setFailRequests(enabled: true);

      await cubit.backUpNow();

      expect(stack.network.failRequests, isTrue);
      expect(cubit.state.message, contains("Couldn't reach the server"));
    });

    test('one task at a time', () async {
      final cubit = open();

      final backup = cubit.backUpNow();
      await cubit.resetProgress();
      await backup;

      expect(cubit.state.messageSerial, 1);
    });

    test('Reset progress: says what stays', () async {
      await stack.seed(fullUserData());
      final cubit = open();

      await cubit.resetProgress();

      expect(cubit.state.message, startsWith('Progress reset.'));
      expect((await stack.userData.readAll()).logs, isEmpty);
    });

    test('Run background tasks now: what each task did', () async {
      await stack.seed(fullUserData());
      final cubit = open();

      await cubit.runBackgroundTasks();

      expect(
        cubit.state.message,
        'Background tasks done: 1 new badge, no backup due, '
        'notifications off.',
      );
    });

    test('Show planned notifications: the plan, once per request', () async {
      await stack.seed(fullUserData());
      final cubit = open();

      await cubit.showPlan();
      final state = await waitFor(cubit, (s) => s.planSerial == 1);

      expect(state.plan!.plan, isNotEmpty);
      expect(state.plan!.enabled, isFalse);
      expect(state.running, isNull);
      expect(state.today, today);
    });

    test('starts idle, with the simulator\'s switch as it is', () {
      stack.network.failRequests = true;

      expect(
        open().state,
        SettingsToolsState(today: today, failRequests: true),
      );
    });
  });
}
