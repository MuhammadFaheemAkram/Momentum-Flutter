import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/background/background_entry.dart';
import 'package:momentum/background/background_graph.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:workmanager/workmanager.dart';

import '../helpers/data_stack.dart';
import '../helpers/habit_builders.dart';
import '../helpers/test_dependencies.dart';

void main() {
  late DataStack stack;
  final water = habit(id: 'water', reminder: TimeOfDayValue(18, 0));

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [water],
        logs: [done(oct(20), id: 'water')],
      ),
    );
    stack.notifications.permitted = true;
    stack.settings.publish(
      const AppSettings(notificationsEnabled: true, autoBackup: true),
    );
  });
  tearDown(() => stack.close());

  group('RunBackgroundTasksUseCase', () {
    test(
      'records new badges, backs up when due, and applies the plan',
      () async {
        final report = await stack.runBackgroundTasks();

        final badges = (report.badges as Ok<List<AchievementId>>).value;
        expect(badges, contains(AchievementId.firstStep));
        expect(await stack.achievements.watchUnlocks().first, isNotEmpty);
        expect(report.backup, isA<BackupDone>());
        expect(stack.settings.current.lastBackupAt, demoNow);
        final sync = (report.notifications as Ok<NotificationSyncReport>).value;
        expect(sync.scheduled, greaterThan(0));
        expect(stack.notifications.pendingById, hasLength(sync.planned));
      },
    );

    test('a second run: nothing new, no backup due, the plan kept', () async {
      await stack.runBackgroundTasks();

      final report = await stack.runBackgroundTasks();

      expect((report.badges as Ok<List<AchievementId>>).value, isEmpty);
      expect(report.backup, isA<BackupNotDue>());
      final sync = (report.notifications as Ok<NotificationSyncReport>).value;
      expect(sync.scheduled, 0);
      expect(sync.kept, sync.planned);
    });

    test('a failing backup stops nothing else', () async {
      stack.network.failRequests = true;

      final report = await stack.runBackgroundTasks();

      expect(report.backup, isA<BackupFailed>());
      expect(report.badges, isA<Ok<List<AchievementId>>>());
      expect(report.notifications, isA<Ok<NotificationSyncReport>>());
    });
  });

  group('the background entry points', () {
    late List<String> events;

    Future<BackgroundGraph> openGraph() async {
      events.add('open');
      return BackgroundGraph(
        runTasks: stack.runBackgroundTasks,
        markDone: stack.markDone,
        syncNotifications: stack.syncNotifications,
        close: () async => events.add('close'),
      );
    }

    setUp(() => events = []);

    test(
      'the maintenance task runs the tasks, then closes the graph',
      () async {
        expect(
          await dispatchBackgroundTask(maintenanceTask, openGraph),
          isTrue,
        );

        expect(events, ['open', 'close']);
        expect(stack.notifications.pendingById, isNotEmpty);
      },
    );

    test("iOS's background fetch runs them too", () async {
      expect(
        await dispatchBackgroundTask(Workmanager.iOSBackgroundTask, openGraph),
        isTrue,
      );

      expect(events, ['open', 'close']);
    });

    test('an unknown task is done at once, with nothing opened', () async {
      expect(await dispatchBackgroundTask('old-task', openGraph), isTrue);

      expect(events, isEmpty);
    });

    test('a graph that fails to open: done, not retried', () async {
      expect(
        await dispatchBackgroundTask(
          maintenanceTask,
          () async => throw StateError('no database'),
        ),
        isTrue,
      );
    });

    test(
      '"Mark done": today done, the plan applied again, the graph closed',
      () async {
        await handleNotificationAction(
          const MarkDoneChosen('water'),
          openGraph,
        );

        final log = await stack.logs.findLog('water', today);
        expect(log!.count, 1);
        expect(events, ['open', 'close']);
        expect(
          stack.notifications.scheduled.values.where(
            (n) => n.kind == NotificationKind.reminder && n.day == today,
          ),
          isEmpty,
        );
      },
    );

    test('a tap needs the app: nothing runs in the background', () async {
      await handleNotificationAction(
        const NotificationOpened(NotificationTarget.today()),
        openGraph,
      );
      await handleNotificationAction(null, openGraph);

      expect(events, isEmpty);
    });
  });

  group('MarkHabitDoneUseCase', () {
    test('a counted habit: done at its full target', () async {
      await stack.seed(
        UserData(
          habits: [habit(id: 'water', target: 8)],
          logs: [done(today, id: 'water', count: 3)],
        ),
      );

      await stack.markDone('water');

      expect((await stack.logs.findLog('water', today))!.count, 8);
    });

    test('already past its target: the count stays', () async {
      await stack.seed(
        UserData(
          habits: [habit(id: 'water', target: 8)],
          logs: [done(today, id: 'water', count: 9)],
        ),
      );

      await stack.markDone('water');

      expect((await stack.logs.findLog('water', today))!.count, 9);
    });

    test('a habit deleted since the reminder: not found', () async {
      expect(await stack.markDone('gone'), isA<Err<void>>());
    });
  });

  group('NotificationInteraction.of', () {
    test('a tap opens its target', () {
      final tap = NotificationInteraction.of(payload: 'habit:water#x');

      expect((tap! as NotificationOpened).target, const OpenHabit('water'));
    });

    test('"Mark done" on a reminder', () {
      final action = NotificationInteraction.of(
        actionId: markDoneActionId,
        payload: 'habit:water#x',
      );

      expect((action! as MarkDoneChosen).habitId, 'water');
    });

    test('nothing for a payload that isn\'t ours, or an unknown action', () {
      expect(NotificationInteraction.of(payload: 'other'), isNull);
      expect(
        NotificationInteraction.of(actionId: 'reply', payload: 'today#x'),
        isNull,
      );
      expect(
        NotificationInteraction.of(
          actionId: markDoneActionId,
          payload: 'today',
        ),
        isNull,
      );
    });
  });
}
