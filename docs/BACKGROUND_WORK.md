# Background Work

Momentum runs Dart while the app is closed in two ways:
- a **periodic maintenance task**, scheduled with `workmanager` (WorkManager on Android, BGTaskScheduler on iOS);
- a reminder's **"Mark done"** action, which the notifications plugin runs without opening the app.

Both run **the same use cases as the app**, in a **background isolate**, on **the same database**.

```
OS ──▶ callbackDispatcher                     lib/background/background_entry.dart
         └─ dispatchBackgroundTask(task, BackgroundGraph.open)
               └─ RunBackgroundTasksUseCase
                    1. EvaluateAchievementsUseCase   badges just earned, recorded once
                    2. AutoBackupUseCase             a backup, if on and a day has passed
                    3. SyncNotificationsUseCase      plan the next 7 days again

notification action ──▶ onNotificationActionInBackground
                          └─ handleNotificationAction(interaction, BackgroundGraph.open)
                               └─ MarkHabitDoneUseCase, then SyncNotificationsUseCase
```

---

## What the maintenance does, and why it isn't time-critical

| Step | Why in the background |
|---|---|
| **Badges** | a streak can complete through "Mark done" while the app is closed; the badge is recorded with that day |
| **Automatic backup** | once a day (24 h after the last receipt) when Settings → Automatic backup is on |
| **Notifications** | the plan covers 7 days; planning again keeps the window rolling if the app isn't opened for days |

**Background timing is not guaranteed.** Android defers work in Doze and App Standby and batches it with other apps'; iOS runs a refresh task when it judges best (often overnight, on a charger), and less often, or never, for an app the user rarely opens. So nothing depends on exact timing: the notifications are already with the OS, days ahead.

Each step runs whatever the others did: a failed backup doesn't stop the notifications. Each reports its own outcome (`BackgroundReport`), and nothing is retried in a loop: the dispatcher returns `true` either way, and the next run tries again (correctness rule 12).

## The entry points

```dart
const maintenanceTask = 'co.bitfuse.flutter.momentum.maintenance';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (task, _) => dispatchBackgroundTask(task, BackgroundGraph.open),
  );
}
```

- **Top-level, with `@pragma('vm:entry-point')`.** The OS starts them by name from native code; nothing in the Dart program calls them, so without the annotation a release build's tree shaking would remove them.
- **Testable:** `dispatchBackgroundTask(task, openGraph)` and `handleNotificationAction(interaction, openGraph)` take the graph as a function. Tests pass a graph built on the in-memory database and fakes; the app passes `BackgroundGraph.open`.
- **Dispatch:** the maintenance task, and iOS's background fetch (`Workmanager.iOSBackgroundTask`), run the tasks; any other name (one from an older version) is done at once with nothing opened.
- **The notification isolate** is started by the plugin: `DartPluginRegistrant.ensureInitialized()` registers plugins before the graph opens the database. (`workmanager`'s `executeTask` initializes the binding itself.)

## Its own small dependency graph

A background isolate shares no memory with the app: `getIt` is empty there, and the app may not be running at all. Building the whole app graph (every screen's Cubit, the router's settings stream) would be wasted work in a job with seconds to run. `BackgroundGraph.open()` builds **only what the tasks use, by hand, from the same classes**:

```
AppDatabase()  ─┬─ HabitRepositoryImpl, HabitLogRepositoryImpl, RoutineRepositoryImpl, AchievementRepositoryImpl
                └─ UserDataRepositoryImpl
SharedPreferencesWithCache ── SettingsLocalDataSource ── SettingsRepositoryImpl
FakeMomentumService (AssetJsonLoader, NetworkSimulator) ── BackupRepositoryImpl
LocalNotifications ── SyncNotificationsUseCase
→ RunBackgroundTasksUseCase, MarkHabitDoneUseCase, SyncNotificationsUseCase; close()
```

`close()` disposes the settings repository and closes the database connection.

## The shared database

`AppDatabase` opens with drift's **`shareAcrossIsolates: true`**. The first isolate to open it starts a drift server isolate, registered by name; the next one connects to it. Every connection goes through that one server, so:
- the two isolates never write the SQLite file at once;
- **the app's screens see the background's writes immediately** (drift's change notifications cross isolates): on a device, "Mark done" from the shade updated the open habit page live;
- the server shuts down after its last client disconnects.

## Preferences across isolates

`SharedPreferencesWithCache` keeps a cache **per isolate**. Two rules keep them consistent (conventions §11.64):
- **write only what changed:** a stale copy writing every key would erase what the other isolate saved (a backup's time);
- **reload on resume:** `SettingsRepository.reload()` re-reads the device's values and publishes them, so "Last backup" or a notifications switch turned off in the background shows up.

## Android: WorkManager

- **One periodic job**, unique name and task name `maintenanceTask`, about **every 6 hours** (WorkManager's minimum is 15 minutes), **only while the battery isn't low**, no network needed.
- **No initial delay:** the first run comes soon after install, then every period. WorkManager won't run periodic work before its initial delay, even when forced from `adb` (conventions §11.66), and the tasks are safe at any time.
- **`ExistingPeriodicWorkPolicy.update`:** registering at every launch updates the job in place and keeps its timing.
- It survives reboots and app updates. No manifest entries are needed for it.

Run it now on a device or emulator:

```bash
adb shell dumpsys jobscheduler | grep momentum          # find the job id
adb shell cmd jobscheduler run -f -n androidx.work.systemjobscheduler co.bitfuse.flutter.momentum <id>
adb logcat | grep -E "WM-WorkerWrapper|flutter"        # "Worker result SUCCESS"
```

## iOS: BGTaskScheduler

- `Info.plist` permits the identifier (`BGTaskSchedulerPermittedIdentifiers`: `co.bitfuse.flutter.momentum.maintenance`) and declares the `fetch` background mode.
- `AppDelegate` registers the launch handler **in `didFinishLaunchingWithOptions`** (`WorkmanagerPlugin.registerPeriodicTask(withIdentifier:earliestBeginInSeconds:)`, then `registerLaunchHandlers()`). BGTaskScheduler delivers a task only to a handler registered before launching finishes, and with UIScene (which this app uses) plugins register later, when the scene connects.
- `didInitializeImplicitFlutterEngine` sets the plugin registrant callbacks for `workmanager` and `flutter_local_notifications`, so the headless engines they start have the plugins (database, preferences, notifications).
- The Dart side submits a `BGAppRefreshTaskRequest` with the same identifier. 6 hours is only the earliest it may run.

Run it from Xcode: pause the app in the debugger and enter

```
e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"co.bitfuse.flutter.momentum.maintenance"]
```

## Without the OS

**Settings → Developer → Run background tasks now** runs the same `RunBackgroundTasksUseCase` in the app and reports each step: "Background tasks done: no new badges, backed up, notifications off."

## The fake backup in the background

The fake service keeps the latest backup **in memory**, so a backup made in the background isolate is lost when that isolate ends. Only the receipt's time is saved, in preferences, and the app shows it after its next reload. A real backend would make this a non-issue.

## Testing

- `RunBackgroundTasksUseCase` on the real data stack with a fake scheduler: badges recorded, a backup only when due, the plan applied; a second run with nothing new; a failing backup stopping nothing else.
- The dispatch: the maintenance task opens, runs and closes the graph; iOS's fetch too; an unknown task opens nothing; a graph that fails to open is still "done".
- "Mark done" in the background: today done, the plan applied again, the graph closed; a tap does nothing in the background.
- The settings: a value saved by "the other isolate" (a second repository on the same store) survives a write, and `reload()` publishes it.
- On devices (Phase 6): the real WorkManager worker ran in its isolate alongside the app and returned `SUCCESS`; "Mark done" ran in a background engine on iOS and Android.
