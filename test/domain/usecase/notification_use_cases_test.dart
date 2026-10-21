import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  // 18:00 every day: from 15:00 today, 7 reminders, 7 nudges, 7 summaries.
  final water = habit(id: 'water', reminder: TimeOfDayValue(18, 0));
  const planSize = 21;

  setUp(() async {
    stack = DataStack();
    await stack.seed(UserData(habits: [water]));
  });
  tearDown(() => stack.close());

  void turnOn() {
    stack.notifications.permitted = true;
    stack.settings.publish(const AppSettings(notificationsEnabled: true));
  }

  NotificationSyncReport reportOf(Result<NotificationSyncReport> result) =>
      (result as Ok<NotificationSyncReport>).value;

  group('SyncNotificationsUseCase', () {
    test('on: the whole plan is scheduled', () async {
      turnOn();

      final report = reportOf(await stack.syncNotifications());

      expect(report.enabled, isTrue);
      expect(report.planned, planSize);
      expect(report.scheduled, planSize);
      expect(stack.notifications.pendingById, hasLength(planSize));
    });

    test('an unchanged plan is left alone', () async {
      turnOn();
      await stack.syncNotifications();
      stack.notifications.calls.clear();

      final report = reportOf(await stack.syncNotifications());

      expect(report.kept, planSize);
      expect(report.scheduled, 0);
      expect(stack.notifications.calls, isEmpty);
    });

    test('a habit done today: its reminder and nudge today are cancelled; '
        'today\'s and tomorrow\'s summaries rescheduled', () async {
      turnOn();
      await stack.syncNotifications();
      final before = {...stack.notifications.scheduled};
      stack.notifications.calls.clear();

      await stack.addCheckIn('water');
      final report = reportOf(await stack.syncNotifications());

      PlannedNotification find(
        Iterable<PlannedNotification> plan,
        NotificationKind kind, {
        int days = 0,
      }) => plan.singleWhere(
        (n) => n.kind == kind && n.day == today.addDays(days),
      );
      final now = stack.notifications.scheduled.values;
      expect(report.cancelled, 2);
      expect(stack.notifications.calls, [
        'cancel ${find(before.values, NotificationKind.reminder).id}',
        'cancel ${find(before.values, NotificationKind.nudge).id}',
        'schedule ${find(now, NotificationKind.summary).id}',
        'schedule ${find(now, NotificationKind.summary, days: 1).id}',
      ]);
      expect(
        find(now, NotificationKind.summary).body,
        '1 of 1 done today, 1 perfect day',
      );
      // Tomorrow, as it will be if nothing else changes: today was perfect.
      expect(
        find(now, NotificationKind.summary, days: 1).body,
        '0 of 1 done today, 1 perfect day',
      );
      expect(report.kept, planSize - 4);
    });

    test('a reminder moved to 18:30: the same ids, rescheduled', () async {
      turnOn();
      await stack.syncNotifications();
      final reminderIds = {
        for (final n in stack.notifications.scheduled.values)
          if (n.kind == NotificationKind.reminder) n.id,
      };
      stack.notifications.calls.clear();

      await stack.habits.updateHabit(
        'water',
        HabitDraft.of(water).copyWith(reminder: TimeOfDayValue(18, 30)),
      );
      final report = reportOf(await stack.syncNotifications());

      expect(report.scheduled, reminderIds.length);
      expect(report.cancelled, 0);
      expect(stack.notifications.calls, [
        for (final id in reminderIds) 'schedule $id',
      ]);
      expect(stack.notifications.scheduled[reminderIds.first]!.at.minute, 30);
    });

    test('off: everything pending is cancelled', () async {
      turnOn();
      await stack.syncNotifications();

      stack.settings.publish(const AppSettings());
      final report = reportOf(await stack.syncNotifications());

      expect(report.enabled, isFalse);
      expect(report.cancelled, planSize);
      expect(stack.notifications.pendingById, isEmpty);
    });

    test('permission revoked in system settings: the switch turns off, and '
        'everything is cancelled', () async {
      turnOn();
      await stack.syncNotifications();

      stack.notifications.permitted = false;
      final report = reportOf(await stack.syncNotifications());

      expect(report.permissionRevoked, isTrue);
      expect(stack.settings.current.notificationsEnabled, isFalse);
      expect(stack.notifications.pendingById, isEmpty);
    });

    test('calls queue up: two at once never interleave', () async {
      turnOn();

      final first = stack.syncNotifications();
      final second = stack.syncNotifications();

      expect(reportOf(await first).scheduled, planSize);
      expect(reportOf(await second).kept, planSize);
    });
  });

  group('SetNotificationsEnabledUseCase', () {
    test('on: asks, and turns on when allowed', () async {
      expect(await stack.setNotificationsEnabled(enabled: true), isTrue);

      expect(stack.notifications.calls, ['request']);
      expect(stack.settings.current.notificationsEnabled, isTrue);
    });

    test('denied: stays off', () async {
      stack.notifications.grantsWhenAsked = false;

      expect(await stack.setNotificationsEnabled(enabled: true), isFalse);

      expect(stack.settings.current.notificationsEnabled, isFalse);
    });

    test('off: no question asked', () async {
      turnOn();

      expect(await stack.setNotificationsEnabled(enabled: false), isTrue);

      expect(stack.notifications.calls, isEmpty);
      expect(stack.settings.current.notificationsEnabled, isFalse);
    });
  });

  test('KeepNotificationsInSyncUseCase: syncs at the start, and again after '
      'a change settles', () async {
    turnOn();
    final reports = <NotificationSyncReport>[];
    final subscription = stack.keepNotificationsInSync().listen(
      (result) => reports.add(reportOf(result)),
    );
    addTearDown(subscription.cancel);

    await _waitFor(() => reports.isNotEmpty);
    expect(reports.single.scheduled, planSize);

    await stack.addCheckIn('water');
    await _waitFor(() => reports.length == 2);
    expect(reports.last.cancelled, 2);
  });

  test('PreviewNotificationPlanUseCase: the plan, even while off', () async {
    final preview = await stack.previewPlan();

    expect(preview.enabled, isFalse);
    expect(preview.plan, hasLength(planSize));
    expect(preview.pending, 0);
  });
}

Future<void> _waitFor(bool Function() done) async {
  for (var i = 0; i < 100 && !done(); i++) {
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  expect(done(), isTrue, reason: 'timed out');
}
