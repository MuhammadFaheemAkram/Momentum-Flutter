# API Simulation

Momentum is **local-first**: everything the user owns lives in drift, and every screen reads it there. The only "remote" API delivers the demo and receives backups. There is no server: a fake service in the app plays one, close enough to a real client that a real one could replace it without changing any caller.

```
MomentumService (abstract, lib/core/network)
  └── FakeMomentumService
        ├── AssetJsonLoader   → assets/json/demo.json
        ├── NetworkSimulator  → 600 ms per request; fails every request when switched on
        └── Clock             → the time a backup is "received"
```

```dart
abstract interface class MomentumService {
  /// The demo: habits with eight weeks of logs, routines, goals.
  Future<DemoDto> fetchDemo();

  /// Receives a full backup; answers with what it stored.
  Future<BackupReceiptDto> uploadBackup(BackupDto backup);
}
```

Both throw a `NetworkException` when the request fails. Repositories turn every failure into an `AppException` with a message for the user; nothing above them sees a raw exception.

## The demo (incoming)

`demo.json` holds **6 habits** in every kind of schedule, **2 routines** and **3 goals**:

| Habit | Schedule | Target | Reminder | Category |
|---|---|---|---|---|
| Drink water | daily | 8 a day | 10:00 | Health |
| Morning run | Mon · Wed · Fri | 1 | 07:00 | Fitness |
| Read 20 pages | daily | 1 | 21:00 | Reading |
| Learn Spanish | 5 times a week | 1 | 19:00 | Learning |
| No-spend day | 3 times a week | 1 | none | Finance |
| Plan tomorrow | weekdays | 1 | 21:30 | Productivity |

- **Routines:** Morning (4 steps), Evening (3 steps), with check-offs.
- **Goals:** "Complete 25 habits this week" (all habits), "Read on 20 days this month" (one habit), "Complete 4 habits today".
- **About eight weeks of logs** with realistic gaps, a partial day and a few skips. **No badges:** they are earned, not loaded (loading the demo earns eight).

### Dates that move with today

Days in the file are **relative**, so the demo always shows live streaks. But not "days ago": three days ago falls on a different weekday every day, and a Mon / Wed / Fri habit's runs would drift off its schedule. So each entry is a **`(weeksAgo, weekday)`**, resolved to that weekday of the ISO week `weeksAgo` weeks before this one. Days from today on are left out (the rest of this week), and each habit's and routine item's **`today`** says how today stands (Drink water: 3 check-ins so far). A habit starts on the Monday `startWeeksAgo` weeks back.

The result is the same wherever the week is cut: a test loads the demo as of every weekday.

### Checked before anything is written

`demo.toUserData(now:)` (`lib/data/mapper/demo_mappers.dart`) checks the whole payload first, and throws on the first problem:
- ids unique per kind;
- titles and targets within the app's limits (the same rules as the forms);
- schedules complete (weekdays for a weekday habit, times for a weekly one);
- no log or check-off before its habit or routine began, and none twice on one day;
- a log is a skip or a count, never both;
- goals name habits that exist.

Then `UserDataDao.replaceAll` writes it in **one transaction**. A damaged demo becomes "The demo data looks damaged. Please try again." and nothing is half-written. The DTOs use `checked: true`, so a field of the wrong type fails the same way, not as a crash.

## Backups (outgoing)

**Settings → Back up now**, or **Automatic backup** (daily, from the background tasks):

```
UserDataRepository.readAll()  ──▶  UserData  ──toBackupDto(exportedAt)──▶  BackupDto
                                                                               │
                                       FakeMomentumService.uploadBackup ◀──────┘
                                         600 ms · jsonEncode (the "wire") · keep the latest in memory
                                                                               │
"Backed up 6 habits, 209 logs"  ◀── BackupReceipt ◀── BackupReceiptDto(receivedAt, habits, logs)
                                         └─▶ settings.lastBackupAt = receivedAt   ("Last backup: Today, 15:00")
```

- **DTO mapping in the outgoing direction:** domain models → `BackupDto` with absolute values (days `yyyy-MM-dd`, times `HH:mm`, instants in UTC, a schedule as its type plus weekdays or times, a goal's habit or `null`). `BackupDto.fromJson` and `toUserData` read it back, and a test proves **every field survives the JSON round trip**; restoring is a natural next step (see [ROADMAP.md](ROADMAP.md)).
- **What the "server" keeps:** the latest backup's JSON, in memory, lost on restart (or when the background isolate that sent it ends). Only the receipt's time is saved on the device.
- **A failure is reported, never retried in a loop:** Back up now shows why ("Couldn't reach the server. Check your connection and try again."); an automatic backup reports `BackupFailed` and the next run tries again.

## Errors

| Situation | Exception | What the user sees |
|---|---|---|
| Simulated network failure | `NetworkException` | "Couldn't reach the server. Check your connection and try again." (Welcome: Try again) |
| Malformed or invalid demo | `DataFormatException` | "The demo data looks damaged. Please try again." |
| Anything else | `UnknownException` | "Something went wrong. Please try again." |

## The developer switch

**Settings → Developer → Simulate network failure** makes every request fail after the delay. It lives in memory (`NetworkSimulator.failRequests`) and is off at every launch, as a real server's state would be. Try it on a fresh install's Welcome (Explore with demo data → the error and Try again), or with Back up now.

## Other outside effects

All behind `domain/service` interfaces, faked in tests:
- **Notifications** (`NotificationScheduler`, `NotificationInteractions`): see [NOTIFICATIONS.md](NOTIFICATIONS.md).
- **Background work** (`BackgroundWork`): see [BACKGROUND_WORK.md](BACKGROUND_WORK.md).
- **Wallpaper colors** (`DynamicColorSource`): read once before the first frame.
