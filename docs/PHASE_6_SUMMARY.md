# Phase 6 — Notifications, Background Tasks and Settings

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 6, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 6 connects Momentum to the device:
- **reminders** on the days a habit is due, gone once it's done, with a **"Mark done"** action that works without opening the app;
- a **missed-habit nudge** and a **daily summary**;
- **background work** in a second isolate: badges, a daily backup, and keeping the notifications rolling;
- **Settings:** appearance, dynamic color, notifications, backup, reset, developer tools, and About with the version.

---

## 🧱 What Was Implemented

- **The notification planner** (`planNotifications`, pure Dart):
  - for each of the next **7 days**, the habits that day asks for (due, not done, not skipped):
    - each one's **reminder** at its time;
    - the **nudge** ("2 habits left today") while any is open;
    - the **summary** ("4 of 5 done today, 6 perfect days") on any day something is due;
  - a day ahead is planned as it will be if nothing else changes; any change plans again;
  - **stable ids** (an FNV-1a hash of kind, habit and day, kept to 31 bits for Android), with a probe on a collision;
  - past times dropped, at most **60** (iOS keeps only the 64 soonest), soonest first;
  - each payload carries its target and its time (`habit:habit_read#2026-10-21T21:00`).
- **`SyncNotificationsUseCase`:** plan → compare with what's pending → cancel what's stale, schedule what's new or changed, leave the rest.
  - **Off**, or permission revoked: everything is cancelled, and a revoked permission turns the switch off.
  - **One sync at a time:** calls queue up.
  - The app runs it after every change to habits, logs or settings (`KeepNotificationsInSyncUseCase`: the clock first, settled 300 ms), at midnight, and on every resume, after reloading the settings.
- **`LocalNotifications`** (`flutter_local_notifications` + `timezone` + `flutter_timezone`):
  - two Android channels (habit reminders; nudge and summary);
  - the device's time zone, looked up before scheduling;
  - inexact alarms (no exact-alarm permission needed);
  - permission asked only from the switch, and the plugin's own `openAppNotificationSettings` when denied;
  - **"Mark done":** an iOS category and an Android action, run in a background isolate;
  - taps: the launch tap opens the app straight on its habit (`MomentumApp.locationFor`); a tap while running pushes the habit, or goes to Today.
- **Background work** (`workmanager`):
  - one periodic task, `co.bitfuse.flutter.momentum.maintenance`, about every 6 hours, only while the battery isn't low;
  - `callbackDispatcher` → `dispatchBackgroundTask` → **`RunBackgroundTasksUseCase`**:
    1. record new badges;
    2. back up if automatic backup is on and a day has passed;
    3. sync notifications.
    Each step runs whatever the others did.
  - **`BackgroundGraph`**: the same use cases, built by hand, on the same database (`shareAcrossIsolates`) and preferences.
- **Settings:**
  - `AppSettings` gained the theme mode, dynamic color, notifications, nudge and summary (on, time), the default reminder time, automatic backup and the last backup's time;
  - the repository writes **only the keys that changed**, and `reload()` reads what the background isolate saved;
  - an **app-wide `SettingsCubit`** above `MaterialApp.router` (theme mode, dynamic color from the wallpaper's palette on Android 12+, as in DevJourney), and a screen-level **`SettingsToolsCubit`** (permission flow, backup, reset, developer tools).
- **Backup:**
  - **`BackupDto`**, the whole user state, mapped *out* from the domain models and readable back; the fake service keeps the latest in memory;
  - **Back up now** ("Backed up 6 habits, 209 logs"), automatic backup, "Last backup: Yesterday, 23:04".
- **Reset progress:** logs, routine check-offs and unlocks in one transaction; habits, routines, goals and settings stay.
- **Developer tools:**
  - Simulate network failure;
  - **Run background tasks now** (the same use case the OS runs, with what each step did);
  - **Show planned notifications** (a sheet: the plan, and how many are scheduled).
- **Elsewhere:**
  - Today shows the next three reminders still to ring ("Coming up", refreshed by a timer when one rings);
  - a new habit's reminder starts at the default reminder time;
  - About shows the version (`package_info_plus`) and the other editions.
- **Platform setup:**
  - Android: desugaring, `POST_NOTIFICATIONS`, `RECEIVE_BOOT_COMPLETED`, the plugin's receivers (scheduled, boot, action), a monochrome `ic_notification` kept from resource shrinking;
  - iOS: the notification-center delegate, the plugin registrant callbacks for background engines, the BGTask launch handler registered in `didFinishLaunching` (a UIScene app must), `BGTaskSchedulerPermittedIdentifiers` and the `fetch` background mode.
- **Tests:** 667 (126 new), and thirteen mutation checks (below).

### Differences from the plan

- **The nudge and the summary are planned for every day of the window**, not only today. Planned as "if nothing else changes", they stay right without the app: any completion goes through the app or "Mark done", and both plan again.
- **No `nextOccurrence` helper.** Each notification keeps its calendar day and wall-clock time, and the scheduler builds the zoned time from them (`TZDateTime(tz.local, …)`). That's what keeps 20:00 at 20:00 across a daylight-saving change; a test plans across the end of European summer time.
- **No `app_settings` package:** `flutter_local_notifications` 22 opens the app's notification settings itself.
- **Two Settings Cubits**, as in DevJourney: the app-wide one for what every screen needs (the theme), and one for the Settings screen's tools.
- **No initial delay on the periodic task.** WorkManager won't run periodic work before its initial delay, even when forced from `adb`; without one, the first run comes soon after install (the tasks are safe at any time), and the real worker can be checked on a device.
- **At large text, switch tiles drop their leading icons.** On an iPhone at the largest accessibility size, "Notifications" broke mid-word between its icon and its switch.

### Mutation checks

Each was broken on purpose, tested, then restored:

| Broken on purpose | Caught by |
|---|---|
| A habit done today still reminded | "done today: no reminder left today, the next ones stay" |
| Past times kept in the plan | "times already past are dropped: 07:00 starts tomorrow" |
| No cap on the plan | "at most 60, the soonest kept" |
| Every notification rescheduled on every sync | "an unchanged plan is left alone" |
| Stale notifications never cancelled | "a habit done today: its reminder and nudge today are cancelled; …" |
| A revoked permission ignored | "permission revoked in system settings: the switch turns off, …" |
| Every setting rewritten on any change | "only what changed is written: a value saved meanwhile by the background isolate stays" |
| A backup due only after more than a day | "a day after the last one, not before" |
| "Coming up" not filtered by the time | "the next three still to ring today, for habits not done" |
| Any background task name run | "an unknown task is done at once, with nothing opened" |
| "Mark done" lowering a count past the target | "already past its target: the count stays" |
| A notification tap replacing the screen stack | "a reminder's tap opens its habit, over where you were" |
| Switch icons kept at large text | "at large text, switch tiles drop their icons, …" |

### Checked on devices

- **iPhone 17 Pro simulator:**
  - the permission prompt, then 43 notifications planned and 43 scheduled;
  - a real reminder delivered at 07:00, and its **Mark done** run from the lock screen in a background engine (the habit done when the app opened);
  - dark mode, and the largest text size (which found the switch-title break above).
- **Pixel 10 Pro emulator (Android 16):**
  - dynamic color on and off, the wallpaper's blue and the app's green;
  - **Don't allow** (stays off, with the card), then Allow;
  - a reminder moved to the next minutes rang on the reminders channel, and **Mark done** from the shade completed it while the app's open habit page updated live;
  - the real WorkManager worker ran in its isolate, alongside the app, and returned `SUCCESS`;
  - **Run background tasks now** reported "no new badges, backed up, notifications off", and "Last backup" updated.

---

## 💙 Flutter / Dart Concepts Demonstrated

- **Planning as a pure function:** `planNotifications(now, histories, settings)` returns a list, and the side effects live in one place, the sync. The rules (weekdays, a met week, done, skipped, past times, the cap) are plain unit tests.
- **Diffing against the device:** the pending notifications are the "before", the plan the "after". Ids are stable hashes, and the payload carries the time (the pending list doesn't report it), so a moved reminder is rescheduled and an unchanged one left alone.
- **Background isolates:**
  - top-level `@pragma('vm:entry-point')` functions, kept by the compiler for the OS to call;
  - `DartPluginRegistrant.ensureInitialized()` in a plugin-started isolate;
  - a hand-built dependency graph, because `getIt` is empty in a new isolate;
  - drift's `shareAcrossIsolates`, one database server for both isolates, so the app's streams see the background's writes;
  - a preferences cache per isolate: write only what changed, and reload on resume.
- **A testable entry point:** `dispatchBackgroundTask(task, openGraph)` and `handleNotificationAction(interaction, openGraph)` take the graph as a function, so tests run them on the in-memory stack.
- **One sync at a time** by chaining futures (`_queue = _queue.then(...)`), and **app-wide watchers** with `Stream.settled` and `asyncMap`, as for badges.
- **Lifecycle:** `AppLifecycleListener(onResume:)`; tests walk the real state sequence (inactive, hidden, paused, and back).
- **Dynamic color** from the palette only (`DynamicColorPlugin.getCorePalette`), read before the first frame with `@preResolve`, and the app's own `ColorScheme.fromSeed`.
- **Private named parameters** (Dart 3.13): `required this._close` in `BackgroundGraph`, passed as `close:`.

---

## 🔁 Data Flow (this phase)

```
                   habits + logs + settings + now
                                │
                        planNotifications  (pure: 7 days, ≤ 60, stable ids, payload with its time)
                                │
SyncNotificationsUseCase ── pending ──▶ cancel stale · schedule new/changed · keep the rest ──▶ LocalNotifications
        ▲            ▲              ▲
   app watcher    resume       background tasks / "Mark done"
   (settled,      (settings    (BackgroundGraph in its own isolate,
    midnight)      reloaded)    same database via shareAcrossIsolates)

workmanager ──▶ callbackDispatcher ──▶ dispatchBackgroundTask ──▶ RunBackgroundTasks
                                                                    1. EvaluateAchievements
                                                                    2. AutoBackup (if due) ──▶ BackupDto ──▶ fake service
                                                                    3. SyncNotifications
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `lib/domain/calculation/notification_plan.dart` | The planner, `remindersOn`, `notificationId`. |
| `lib/domain/model/planned_notification.dart` | `PlannedNotification`, `NotificationTarget`, the sync report, the plan preview. |
| `lib/domain/usecase/{notification,backup,background,settings}_use_cases.dart` | Sync, keep in sync, permission, preview; backups and reset; the background tasks; one use case per setting. |
| `lib/core/platform/{local_notifications,workmanager_background_work,material_you_color_source}.dart` | The plugins, behind domain interfaces. |
| `lib/background/{background_entry,background_graph}.dart` | The OS's entry points and their own small graph. |
| `lib/core/network/dto/backup_dto.dart`, `lib/data/mapper/backup_mappers.dart` | The backup going out, and read back. |
| `lib/features/settings/**` | Both Cubits, the view, the plan sheet. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `PlannedNotification`, `NotificationTarget` | freezed | One notification the app wants; where a tap leads | `domain/model` |
| `NotificationScheduler`, `NotificationInteractions` | interfaces | The device's notifications; taps and actions | `domain/service` (fakes in tests) |
| `SyncNotificationsUseCase` | lazy singleton | Plan → diff → apply, one at a time | `domain/usecase` |
| `RunBackgroundTasksUseCase`, `BackgroundReport` | use case | The maintenance, step by step | `domain/usecase` |
| `BackgroundGraph` | class | The background isolate's dependencies | `background/` |
| `SettingsCubit`, `SettingsToolsCubit` | Cubits | The theme app-wide; the Settings screen's actions | `features/settings/cubit` |

---

## 🌱 Folder Structure Changes

- **New:** `lib/background/`, `lib/core/platform/`, `lib/domain/service/`, `lib/features/settings/{cubit,widgets}`, `test/background/`; `android/app/src/main/res/{drawable,raw}`.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Reminders | `ReminderScheduler` → WorkManager → NotificationManager, with channels | a `NotificationScheduler` protocol over `UNUserNotificationCenter`, with categories and actions | a pure planner over 7 days, and a sync that applies the difference through `flutter_local_notifications` (channels on Android, a category on iOS) |
| Missed-habit and summary | notifications | notifications | planned per day: the nudge only while something is open, the summary with the day's numbers |
| Background jobs | WorkManager: reminders, summary, achievement checks, fake sync (periodic and one-time, constraints, Hilt workers) | `BackgroundTaskCoordinator` over BGTaskScheduler: summary, achievement checks, fake sync | `workmanager` on both: badges, the backup when due, the plan, in a background isolate with its own graph |
| Settings | dark mode, dynamic color, notifications, reminders, backup simulation, reset, About (DataStore) | appearance, notifications, reminder defaults, reset, backup simulation, About (`@AppStorage`) | all of these, plus the nudge and summary times and developer tools; `SharedPreferencesWithCache`, reloaded on resume |
| Permission | — | — | asked from the switch; denied, a card to the system settings; revoked, the switch turns off |
| Tests | tests | scheduling with fakes | the planner, the diff against a fake, background tasks, entry-point dispatch, flows, the tour, mutation checks |

The native specs schedule each reminder as its own job or request. Planning a whole window and applying only the difference makes reminders follow the history ("done today → no reminder") without any code at the moment of completion.

---

## 🎤 Interview Notes

**Q: Why not one repeating notification per habit?**
A: A repeating notification can't skip a day the habit is already done, can't follow a Mon / Wed / Fri schedule or a "3 times a week" target, and can't say how many habits are left. I plan each day's notifications for a week, and plan again after every change, at midnight, on resume and in the background, so the window keeps rolling.

**Q: How do you avoid rescheduling 60 notifications on every tap?**
A: The sync compares the plan with what's pending. Ids are stable hashes of the kind, the habit and the day, and the payload includes the time, because the pending list doesn't return it. Only stale ones are cancelled and only new or changed ones scheduled; a test proves an unchanged plan makes no calls.

**Q: What runs in the background, and how does it get its dependencies?**
A: A top-level `@pragma('vm:entry-point')` function, in a fresh isolate where `getIt` is empty. It builds a small graph by hand from the same classes and runs the same use cases. The database is opened with drift's `shareAcrossIsolates`, so if the app is open both talk to one server and the app's screens update at once. Preferences have a cache per isolate, so the repository writes only what changed, and the app reloads on resume.

**Q: Is background work guaranteed to run?**
A: No. Android defers it in Doze and batches it; iOS runs a refresh task when it sees fit, often not at all for a rarely used app. So nothing time-critical depends on it: the notifications are already with the OS, a week ahead. The task keeps the window rolling, records badges and backs up.

---

## 📝 Learning Checklist

- ✅ Plan notifications as data, and apply only the difference
- ✅ Handle permission: asked in context, denied with a way out, revoked detected on resume
- ✅ Run Dart in a background isolate (workmanager, notification actions) with its own graph on a shared database
- ✅ Keep preferences consistent across isolates
- ✅ Theme the app from the wallpaper on Android 12+
- ✅ Back up the whole state as a DTO, and prove the round trip
- ⬜ Final docs, ROADMAP and screenshots (Phase 7)

---

## 🚀 Future Improvements

- **Phase 7:** `docs/NOTIFICATIONS.md` and `docs/BACKGROUND_WORK.md` in depth, the rest of the docs, screenshots (including dynamic color), and the open-source files.
- **Later:**
  - restore from a backup (the DTO already reads back);
  - a snooze action;
  - grouping the day's reminders on Android.
