# Notifications

Momentum's reminders follow the history: a habit done today has no reminder left today, a Mon / Wed / Fri habit rings only on its days, and the evening nudge says how many habits are left. That takes two pieces:
- a **pure planner** that turns habits, logs and settings into the notifications the app wants;
- a **sync** that makes the device match the plan, changing only what differs.

```
habits + logs + settings + now
            │
   planNotifications            lib/domain/calculation/notification_plan.dart (pure)
            │  List<PlannedNotification>
            ▼
   SyncNotificationsUseCase ◀── pending() ── NotificationScheduler (interface)
            │                                       ▲
   cancel stale · schedule new or changed           │
            └──────────────────────────────▶ LocalNotifications (flutter_local_notifications)
```

---

## Why a rolling window, not repeating notifications

A repeating notification ("daily at 07:00") can't skip a day the habit is already done, can't follow a weekday schedule or a "3 times a week" target, and can't say how many habits are left. So the plan lists **each day's notifications one by one for the next 7 days**, and is made again after every change. That keeps the window rolling forward.

## The planner (`planNotifications`)

For each of the next 7 days, the habits that day **asks for**: due (see [HABIT_ENGINE.md](HABIT_ENGINE.md)), not skipped. Of those, the **open** ones are not done yet.

| Kind | When | Says | Opens |
|---|---|---|---|
| **Reminder** | each open habit with a reminder time, at that time | the habit's title; its description, "Due today", or "3 of 8 so far today" for a counted habit | the habit |
| **Nudge** | at the nudge time (20:00 by default), while any habit is open | "2 habits left today"; their titles, "… and 3 more" past three | Today |
| **Summary** | at the summary time (21:30), on any day something is asked | "Your day"; "4 of 5 done today, 6 perfect days" | Today |

- **Days ahead** are planned as they'll be if nothing else changes: nothing done yet, and the perfect-day streak as it would stand. Any change (a check-in, "Mark done", an edit) plans again, so they stay right.
- **A weekly habit whose week is met** isn't due, so it isn't reminded.
- **Archived habits** are never planned; a habit starting later is planned from its start date.
- **Times already past are dropped**, and the plan keeps the **60 soonest** (iOS keeps only the 64 soonest pending notifications per app and silently drops the rest).
- **Sorted** by time, then reminder before nudge before summary, then habit id, so the plan never depends on the input's order.

### Ids

Each notification's id is the **32-bit FNV-1a hash** of `kind | habitId | yyyymmdd`, kept positive (Android's ids are signed 32-bit). The same notification gets the same id in every plan, which is what lets the sync recognise it. Two different notifications with the same hash would replace each other on the device, so the later one moves to the next free id.

### The payload

The pending list a device returns has the id, title, body and payload, **but not the time**. So the payload carries both the tap target and the time:

```
habit:habit_read#2026-10-21T21:00      a reminder: opens the habit
today#2026-10-21T20:00                 the nudge or the summary: opens Today
```

`NotificationTarget.parse` reads only the part before `#`. A reminder moved from 07:00 to 07:30 has a new payload, so the sync reschedules it (conventions §11.65).

### Time zones and daylight saving

A planned notification keeps its **calendar day and wall-clock time** (`CalendarDate` + `TimeOfDayValue`), not an instant. The scheduler builds `TZDateTime(tz.local, …)` in the device's zone, looked up with `flutter_timezone` (at most once a minute). So "20:00" stays 20:00 local across a daylight-saving change and after travelling; a test plans across the end of European summer time.

## The sync (`SyncNotificationsUseCase`)

1. Notifications **off**: cancel everything pending.
2. On, but the system **no longer allows** them: turn the switch off, cancel everything (the switch never reads "on" while nothing can ring).
3. Otherwise: plan, read what's pending, **cancel** pending ids not in the plan, **schedule** planned ones that are new or differ in title, body or payload, and **leave the rest**. Scheduling an existing id replaces it, so there's no cancel before.

It returns a report (planned, scheduled, cancelled, kept). Calls **queue up** (each waits for the one before), so two syncs never interleave their cancels and schedules; the use case is a singleton, so the app's watcher, a resume and Settings share the queue.

### When it runs

| Trigger | How |
|---|---|
| Any change to habits, logs or settings | `KeepNotificationsInSyncUseCase`: the clock, habits, logs and settings combined (the clock first, conventions §11.61), **settled 300 ms** so a burst of writes (the demo, a reset) syncs once |
| Midnight | the same watcher: the clock emits a new day, and the window moves |
| Resume | `MomentumApp` reloads the settings (the background isolate may have changed them), then syncs: catches a permission revoked in system settings |
| In the background | `RunBackgroundTasksUseCase`, so the window keeps rolling even if the app isn't opened for days |
| "Mark done" | after marking, in the background isolate |

## The platform side (`LocalNotifications`)

`lib/core/platform/local_notifications.dart` implements both domain interfaces: `NotificationScheduler` (permission, pending, schedule, cancel, the system settings) and `NotificationInteractions` (taps and actions).

- **Initialization** is lazy, once, without asking for permission.
- **Android channels:** *Habit reminders* and *Nudge and summary*, so the user can silence one and keep the other. A monochrome `ic_notification` (kept from resource shrinking by `res/raw/keep.xml`).
- **Inexact alarms** (`inexactAllowWhileIdle`): a reminder doesn't need the minute, and exact alarms need a special permission since Android 14. In practice a reminder rings within a minute or so.
- **Reboots:** the plugin's boot receiver reschedules after a reboot or an app update.

### "Mark done"

| | Android | iOS |
|---|---|---|
| Declared | an `AndroidNotificationAction('mark_done', 'Mark done')` on each reminder | a `DarwinNotificationCategory('habit_reminder')` with a plain action, registered at initialization; reminders use the category |
| Shown | under the notification in the shade | swipe the notification left → View (or a long press on a device) |
| Runs | in a **background isolate**, since it doesn't open the app | the same |

The action runs `onNotificationActionInBackground` (top-level, `@pragma('vm:entry-point')`), which builds a `BackgroundGraph`, marks the habit done today (at its full target, keeping a higher count), and syncs, so the habit's nudge disappears once nothing is left. See [BACKGROUND_WORK.md](BACKGROUND_WORK.md).

### Taps

- **Cold start:** `main()` asks `launchTarget()`; a reminder's tap opens the app straight on its habit (`MomentumApp.locationFor`), with a Close button.
- **While running:** `interactions` delivers taps; a reminder **pushes** its habit over wherever the user was (Back returns there), the nudge and the summary go to Today.

## Permission

| Platform | Asked | Denied |
|---|---|---|
| Android 13+ | when the switch is turned on (`POST_NOTIFICATIONS`); the system shows it at most twice | the switch stays off; a card explains and opens the app's notification settings |
| Android 12 and older | allowed by default | the user may have turned them off: same card |
| iOS | when the switch is turned on (alert and sound) | asked once ever; the same card leads to Settings |

Revoked later in system settings: the next sync (on resume) turns the switch off.

## Today's "Coming up"

Today lists the next three reminders still to ring today (`TodayOverview.reminders`, built with the planner's own `remindersOn`), and a timer refreshes the list when the first one rings.

## Settings

Notifications (the master switch), the missed-habit nudge (on/off, time), the daily summary (on/off, time), and the default reminder time for new habits. **Developer → Show planned notifications** lists the plan and how many are scheduled.

## Testing

- **The planner** (27 tests): done or skipped today, partial counts, weekdays only, a met week, start dates, archived, past times, the nudge's wording and its absence once all is done, the summary, the 7-day horizon, the 60 cap, past midnight, wall-clock times across a DST change, stable and unique ids, payloads.
- **The sync**, against `FakeNotificationScheduler`: the whole plan scheduled; an unchanged plan left alone (no calls at all); a habit done today cancelling its reminder and nudge and rescheduling the summaries; a moved reminder rescheduled under the same ids; off; permission revoked; two syncs queued.
- **Entry points:** "Mark done" in the background marks and re-plans; app flows for a tap (cold and warm), "Mark done" in the app, notifications on, denied, and revoked while away.
- **On devices:** a real reminder rang and "Mark done" worked on an iPhone simulator and an Android 16 emulator (Phase 6).
