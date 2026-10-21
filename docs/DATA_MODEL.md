# Data Model

Momentum keeps everything the user owns in one SQLite database (drift, `momentum.sqlite` in the app's documents directory). There is no synced content: every table is the user's. Preferences (`SharedPreferencesWithCache`) hold small device-owned settings.

**Nothing derived is stored.** No column holds a streak, a rate, a goal's count or a score: they are calculated from the logs when read ([HABIT_ENGINE.md](HABIT_ENGINE.md)). The one exception is a badge's unlock, which is a moment, not a state.

## Value types

- **`CalendarDate`:** an extension type over a `yyyymmdd` integer (`20261021`): a day in the user's calendar, taken from the injected `Clock`. No time zone; comparing and adding days is arithmetic. Stored as `INTEGER`.
- **`TimeOfDayValue`:** an extension type over the minutes since midnight: a reminder, the nudge, the summary. Stored as `HH:mm` text, which reads well and sorts like the times.
- **Instants** (`created_at`, `archived_at`, `unlocked_at`) are UTC `DateTime`s, stored as ISO-8601 text (`store_date_time_values_as_text`). Text sorts in time order only to the millisecond, so reads that order by an instant break ties by id (conventions §11.60).
- **Enums** are stored by name (`textEnum`): category, color, icon, schedule type, routine time, goal kind and period. Renaming a value is a schema change.

## Tables (schema v1)

`PRAGMA foreign_keys = ON` runs on every connection: SQLite ships with foreign keys off, and every `REFERENCES` and `CASCADE` below depends on it.

| Table | Key | Columns | Relations |
|---|---|---|---|
| `habits` | `id` | title, description (default ''), category, color, icon, schedule_type, weekdays (bitmask), times_per_week?, daily_target, start_date (day), reminder_time? (`HH:mm`), archived_at?, created_at, sort_order | |
| `habit_logs` | `(habit_id, day)` | count, skipped | → habits `CASCADE` |
| `routines` | `id` | title, time, created_at, sort_order | |
| `routine_items` | `id` | routine_id, title, sort_order | → routines `CASCADE` |
| `routine_checks` | `(item_id, day)` | | → routine_items `CASCADE` |
| `goals` | `id` | title, kind, habit_id?, period, target, created_on (day), created_at | → habits `CASCADE` |
| `achievement_unlocks` | `achievement_id` | unlocked_on (day), unlocked_at | |

Indexes: `habits_by_order (sort_order)`, `habit_logs_by_day (day)`, `routine_items_by_routine (routine_id, sort_order)`, `routine_checks_by_day (day)`, `goals_by_habit (habit_id)`.

### How a schedule is stored

`HabitSchedule` is a sealed union in the domain; in the table it's three columns:

| Schedule | `schedule_type` | `weekdays` | `times_per_week` |
|---|---|---|---|
| Daily | `daily` | 0 | null |
| On weekdays `{1, 3, 5}` | `onWeekdays` | 1 + 4 + 16 = **21** (Monday = 1, Tuesday = 2, … Sunday = 64) | null |
| 3 times a week | `timesPerWeek` | 0 | 3 |

A bitmask keeps the schedule in its row, and a weekday test is one `&`.

## Constraints: invalid rows can't exist

| Rule | Constraint |
|---|---|
| A daily target of 1–20 | `CHECK (daily_target BETWEEN 1 AND 20)` |
| Weekdays only for `onWeekdays`, and at least one | `CHECK ((schedule_type = 'onWeekdays') = (weekdays > 0))`, `weekdays BETWEEN 0 AND 127` |
| Times a week only for `timesPerWeek`, 1–6 | `CHECK ((schedule_type = 'timesPerWeek') = (times_per_week IS NOT NULL))`, `BETWEEN 1 AND 6` |
| A reminder is a real `HH:mm` | `GLOB '[0-2][0-9]:[0-5][0-9]' AND < '24:00'` |
| **One log per habit per day** | primary key `(habit_id, day)`: "+1" is an upsert, not a new row |
| **A log is a skip or at least one check-in** | `CHECK (skipped = (count = 0))`, `count ≥ 0`. "Not done" is the absence of a row: one way to say it |
| A goal's target of 1–200 | `CHECK (target BETWEEN 1 AND 200)` |
| A goal names a habit exactly when it counts one | `CHECK ((kind = 'habit') = (habit_id IS NOT NULL))` |
| A badge is unlocked once | primary key `achievement_id` |
| An item checked once a day | primary key `(item_id, day)` |

Validation in the domain (`validation.dart`) gives the forms their messages; these constraints make sure no code path can write what the forms would refuse.

## Cascades

- **Deleting a habit** deletes its logs and its goals (a goal can't count a habit that's gone). The form asks first. **Archiving** keeps everything: the habit is never due again, and its history still counts toward goals and analytics.
- **Deleting a routine** deletes its items, and their check-offs with them; a step removed in the editor takes its check-offs.
- Nothing else cascades: badges stay when habits go.

## Writes that touch several rows

All in **one transaction**: they land completely or not at all.

| Write | DAO | Notes |
|---|---|---|
| Load the demo (or replace everything) | `UserDataDao.replaceAll` | deletes every table (children first), then batch-inserts; running it twice gives the same result |
| Save a routine | `RoutinesDao.saveRoutine` | upsert the routine, delete steps no longer listed, upsert each step at its new position. Steps keep their ids, so check-offs follow them when reordered. `ON CONFLICT DO UPDATE`, never `REPLACE`, which would delete and cascade (§11.53) |
| Record badges | `AchievementsDao.recordUnlocks` | reads what's unlocked and inserts only the rest, in one transaction, so the app and a background task evaluating at once can't both claim a badge; returns what it recorded. A badge keeps its first date |
| **Reset progress** | `UserDataDao.resetProgress` | deletes logs, routine check-offs and unlocks; habits, routines and goals stay. Nothing derived needs resetting |
| Read for a backup | `UserDataDao.readAll` | every table in a stable order, in one transaction so the tables agree |

Single-row writes: a log is upserted (+1 adds to `count`; a skip sets `skipped` and zeroes `count`; undo deletes the row); a goal's update writes every column, so moving it from one habit to all habits writes the `null` (§11.57).

## Reads

drift's `watch()` streams re-run when a table they read changes. Screens combine them with the clock (`combineLatest`, the clock first, §11.61), so Today moves to a new day at midnight by itself. Search is a `LIKE` with `%`, `_` and `\` escaped; the data is small, so there's no FTS index.

## Across isolates

The database opens with `driftDatabase(name: 'momentum', native: DriftNativeOptions(shareAcrossIsolates: true))`. The background isolate (workmanager, "Mark done") connects to the same drift server as the app; see [BACKGROUND_WORK.md](BACKGROUND_WORK.md).

## Preferences

`SharedPreferencesWithCache`, created before the first frame (`@preResolve`) so the router knows where to open, with an allow-list of keys:

| Key | Value |
|---|---|
| `settings.onboarded` | left Welcome |
| `settings.themeMode` | `system` / `light` / `dark` |
| `settings.dynamicColor` | the wallpaper's colors (Android 12+); default on |
| `settings.notificationsEnabled` | the master switch; on only while allowed |
| `settings.nudgeEnabled`, `settings.nudgeTime` | default on, `20:00` |
| `settings.summaryEnabled`, `settings.summaryTime` | default on, `21:30` |
| `settings.defaultReminder` | a new habit's reminder; `09:00` |
| `settings.autoBackup` | default off |
| `settings.lastBackupAt` | the last receipt's time, UTC ISO-8601 |
| `search.recent` | the last searches |

Missing or unreadable values fall back to the defaults. Only changed keys are written (§11.64).

## The backup's shape

`BackupDto` (`lib/core/network/dto/backup_dto.dart`) is the whole state with **absolute** values: days as `yyyy-MM-dd`, times as `HH:mm`, instants in UTC, a schedule as its type plus weekdays or times, a goal's habit as `habitId` or `null`. It's mapped from the domain models (`backup_mappers.dart`), and a test proves every field survives the JSON round trip. See [API_SIMULATION.md](API_SIMULATION.md).

## Migrations

Schema v1 is exported to `drift_schemas/` (`drift_dev make-migrations`). A future change bumps `schemaVersion`, exports the new version, and ships a `stepByStep` migration with a generated migration test.
