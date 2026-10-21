import 'dart:developer';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show NotificationResponse;
import 'package:momentum/background/background_graph.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:workmanager/workmanager.dart';

// The two ways the OS runs Momentum's code while it's closed, each in a
// fresh background isolate:
// - `workmanager` runs the periodic maintenance ([callbackDispatcher]);
// - a reminder's "Mark done" runs [onNotificationActionInBackground].
//
// Both are top-level functions marked `@pragma('vm:entry-point')`. The OS
// starts them by name from native code, with nothing in the Dart program
// calling them; without the annotation, a release build's tree shaking
// would remove them as unused. And neither can reach the app's objects:
// an isolate shares no memory, so each builds its own `BackgroundGraph`.

/// The periodic task's name, on both platforms: the WorkManager job's and
/// the iOS BGTaskScheduler identifier (listed in `Info.plist`).
const maintenanceTask = 'co.bitfuse.flutter.momentum.maintenance';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (task, _) => dispatchBackgroundTask(task, BackgroundGraph.open),
  );
}

/// Runs [task] on a graph from [openGraph], and closes it. Always `true`:
/// a failure is logged and the next run tries again, rather than Android
/// retrying it with backoff (correctness rule 12). Unknown tasks (one from
/// an older version) are done at once.
Future<bool> dispatchBackgroundTask(
  String task,
  Future<BackgroundGraph> Function() openGraph,
) async {
  if (task != maintenanceTask && task != Workmanager.iOSBackgroundTask) {
    return true;
  }
  try {
    final graph = await openGraph();
    try {
      await graph.runTasks();
    } finally {
      await graph.close();
    }
  } on Object catch (error, stackTrace) {
    log('Background tasks failed', error: error, stackTrace: stackTrace);
  }
  return true;
}

@pragma('vm:entry-point')
Future<void> onNotificationActionInBackground(
  NotificationResponse response,
) async {
  // A plugin-started isolate: plugins (path_provider, shared_preferences)
  // must be registered before the graph can open the database.
  DartPluginRegistrant.ensureInitialized();
  await handleNotificationAction(
    NotificationInteraction.of(
      actionId: response.actionId,
      payload: response.payload,
    ),
    BackgroundGraph.open,
  );
}

/// "Mark done": today done, then the plan again, so the habit's nudge goes
/// once nothing is left. Anything else needs the app, and is ignored here.
Future<void> handleNotificationAction(
  NotificationInteraction? interaction,
  Future<BackgroundGraph> Function() openGraph,
) async {
  if (interaction is! MarkDoneChosen) return;
  try {
    final graph = await openGraph();
    try {
      await graph.markDone(interaction.habitId);
      await graph.syncNotifications();
    } finally {
      await graph.close();
    }
  } on Object catch (error, stackTrace) {
    log('"Mark done" failed', error: error, stackTrace: stackTrace);
  }
}
