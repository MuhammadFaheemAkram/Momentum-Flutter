# Phase 2 — Data Layer

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 2, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 2 gives the app its memory:
- **domain models** for habits (with a sealed schedule), their logs, routines, goals and earned badges;
- a **drift database** whose constraints make invalid rows impossible, ready to be shared with a background isolate later;
- the **fake service** and a **demo** that always looks current;
- the saved **first-launch setting**, and a **Welcome** screen that really loads the demo, or starts empty.

---

## 🧱 What Was Implemented

- **Domain (`domain/model/`, pure Dart):**
  - `CalendarDate` (from SpendWise and DevJourney), now with `weekStart` (the Monday of its ISO week), `monthStart` and `daysUntil`;
  - `TimeOfDayValue`: an extension type over minutes since midnight, stored as `HH:mm`;
  - `HabitSchedule`, a sealed freezed union: `Daily`, `OnWeekdays(weekdays)`, `TimesPerWeek(times)`;
  - `Habit`, `HabitLog` (a skip *or* a count, asserted), `Routine` with its ordered `RoutineItem`s, `RoutineCheck`, `Goal` with a sealed `GoalScope` (all habits or one), `AchievementUnlock`, and `UserData` (everything the user owns, in one value);
  - the enums: 7 categories, 8 colors (matching the design system's palette, tested), 12 icons, routine times, goal periods.
- **Database (`core/database/`, drift v1, exported to `drift_schemas/`):**
  - seven tables: `habits`, `habit_logs`, `routines`, `routine_items`, `routine_checks`, `goals`, `achievement_unlocks`;
  - **constraints:**
    - each schedule has exactly the columns it needs;
    - weekdays are a bitmask (Monday = 1 … Sunday = 64);
    - a log is a skip (count 0) or at least one check-in;
    - targets are in range;
    - a reminder is a real `HH:mm`;
    - a goal names a habit exactly when it counts one;
  - **keys and cascades:** one log per habit per day, one check per item per day, one unlock per badge; deleting a habit takes its logs and goals, a routine its items and their checks;
  - `UserDataDao.replaceAll` (one transaction) and `readAll`; `HabitLogsDao`'s three log operations: **+1** (an upsert that adds to the count), **skip** and **undo**;
  - opened with `shareAcrossIsolates: true`, for the background work of Phase 6.
- **Mappers (`data/mapper/`):** models ⇄ rows, both ways, tested as a round trip of every field; the demo DTO → models, checked before anything is written.
- **The fake service:** `MomentumService.fetchDemo()`, served by `FakeMomentumService` from `assets/json/demo.json` after 600 ms, failing on request (`NetworkSimulator`).
- **The demo:**
  - **six habits:**
    - Drink water (daily, 8 a day);
    - Morning run (Mon / Wed / Fri);
    - Read 20 pages (daily);
    - Learn Spanish (5× a week);
    - No-spend day (3× a week);
    - Plan tomorrow (weekdays);
  - eight weeks of logs with gaps and a few skips;
  - a Morning routine with 4 items and an Evening one with 3;
  - three goals.
- **Repositories and use cases:** `DemoRepository.loadDemo()` (fetch → check → write, every failure an `AppException`), `SettingsRepository` (the onboarded flag, synchronous from the first frame), `LoadDemoUseCase` (data first, then onboarded), `StartEmptyUseCase`.
- **Welcome for real:**
  - `WelcomeCubit` with a spinner in the chosen button;
  - a failed demo shows why (announced to screen readers) and the button becomes **Try again**, while Start empty stays available;
  - the router follows the saved setting (`StreamListenable`);
  - `PlaceholderOnboarding` is gone.
- **DI:** `configureDependencies` is async (`@preResolve` preferences); `AppModule` registers the asset bundle, the clock, the database and its DAOs.
- **Tests:** 224 (103 new), and six mutation checks (below).

### Differences from the plan

- **The demo is anchored to ISO weeks, not to "days ago".** The spec asked for relative days (`daysAgo`) so the demo always shows live streaks. But "3 days ago" is a different weekday every day, so a Mon / Wed / Fri habit's runs would drift off its schedule. So each entry is a weekday N weeks back (`weeksAgo`, `weekday`), resolved against today's week:
  - days from today on are left out (they're the rest of this week);
  - each habit's and item's `today` says how today stands (Drink water: 3 of 8).
  - A test loads the shipped demo as of every day of the week.
- **DAOs arrive with their screens.** This phase has the two the data model itself needs: replacing everything (the demo, later reset and restore) and the three log operations that define "one log per habit per day". The habit, routine, goal and badge queries come in Phases 3–5, with the screens that read them.
- **No `intl` or `IdGenerator` yet:** nothing formats a date or creates a record until Phase 3.
- **`HabitSchedule.onWeekdays` doesn't assert a non-empty set:** freezed's const constructor can't call `isNotEmpty`. The rule lives in validation (Phase 3) and in the database's CHECK.
- **The demo loads no badges:** they are earned, when the rules arrive in Phase 5, not shipped as data.

### Mutation checks

Each was broken on purpose, tested, then restored:

| Broken on purpose | Caught by |
|---|---|
| The log's `CHECK (skipped = (count = 0))` removed | the schema test "a log is a skip with no check-ins, or at least one check-in" |
| `replaceAll` without its transaction | "a broken row rolls everything back" |
| +1 sets the count to 1 instead of adding | "+1 starts a log, then adds to the same one" |
| The first launch ends even when the demo failed | "a failed demo leaves the user on Welcome", and the offline flow |
| Demo days counted back from today instead of by week | the demo mapper and bundled demo tests |
| The weekday bitmask off by one | the bitmask and round-trip tests |

### A drift trap found on the way

A round trip of two goals created 1 µs apart came back in the wrong order. drift stores a `DateTime` as `toIso8601String()`: three fraction digits when the microseconds are zero (`…00.000Z`), six otherwise (`…00.000001Z`), and `'Z'` sorts after `'0'`. So the text sorts by time only to the millisecond. Reads now break ties with an id, and it is trap §11.60 in the conventions.

---

## 💙 Flutter / Dart Concepts Demonstrated

- **Sealed unions with freezed:** `HabitSchedule` and `GoalScope` are `sealed`, so every `switch` over them is exhaustive: the mapper's three schedule cases, and every calculation in Phase 3.
- **Extension types:** `CalendarDate` and `TimeOfDayValue` cost nothing at runtime, but a day can't be passed where a time is expected, and every value goes through a checking factory.
- **Making invalid states unrepresentable, twice:** the models assert their invariants in debug builds, and the database refuses them in every build. Whichever code writes a row, SQLite checks it.
- **Records and destructuring:** the mappers return `(type, weekdays, times)` from a `switch` expression, and patterns pull fields out of DTOs.
- **drift:**
  - table-level CHECKs (`customConstraints`), composite primary keys, `@TableIndex`, `textEnum` and type converters;
  - an upsert that adds to a column (`DoUpdate((old) => … old.count + 1 …)`);
  - transactions, batches, and an exported schema;
  - `shareAcrossIsolates`.
- **Checked JSON:** `@JsonSerializable(checked: true)` turns a missing or mistyped field into one exception type, which the repository maps to "the demo looks damaged".
- **`@preResolve`:** the preferences load before `runApp`, so the router decides between Welcome and Today on the first frame, with no flash.
- **`StreamListenable`:** go_router's `refreshListenable` following a repository's stream.
- **Live regions:** `Semantics(liveRegion: true)` on the error text, so TalkBack and VoiceOver read it when it appears.

---

## 🔁 Data Flow (this phase)

```
Welcome ─▶ WelcomeCubit.exploreDemo() ─▶ LoadDemoUseCase
  DemoRepository.loadDemo()
    MomentumService.fetchDemo()            600 ms, may throw NetworkException
    DemoDto.toUserData(now: clock.now())   (weeksAgo, weekday) → CalendarDate; checked, or FormatException
    UserData.toRows() ─▶ UserDataDao.replaceAll   one transaction
  ok  ─▶ SettingsRepository.setOnboarded(true) ─▶ watch() ─▶ StreamListenable ─▶ redirect ─▶ /today
  err ─▶ WelcomeState(errorMessage) ─▶ the error, and "Try again"

Welcome ─▶ startEmpty() ─▶ StartEmptyUseCase ─▶ setOnboarded(true) ─▶ /today
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `lib/domain/model/*.dart` | The models, value types and enums. |
| `lib/core/database/{app_database,converters}.dart`, `tables/tables.dart`, `daos/*` | The schema, its constraints, and the DAOs. |
| `drift_schemas/app_database/drift_schema_v1.json` | The exported v1 schema, for future migration tests. |
| `lib/core/network/{momentum_service,fake_momentum_service,network_simulator,asset_json_loader}.dart`, `dto/demo_dto.dart` | The fake service and the demo's DTOs. |
| `assets/json/demo.json` | The demo. |
| `lib/data/mapper/{user_data_mappers,demo_mappers}.dart` | Models ⇄ rows; the demo → models, checked. |
| `lib/data/repository/*`, `lib/domain/repository/*`, `lib/domain/usecase/*` | Demo and settings; the two ways to start. |
| `lib/core/storage/settings_local_data_source.dart`, `lib/core/navigation/stream_listenable.dart` | Preferences, and the router following them. |
| `lib/features/welcome/cubit/*` | Welcome's state. |
| `test/helpers/{data_stack,database,test_dependencies,user_data_fixtures}.dart`, `test/helpers/fakes/*` | The real stack in memory, the app's graph for app tests, fixtures and fakes. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `HabitSchedule` (`Daily`, `OnWeekdays`, `TimesPerWeek`) | sealed freezed union | When a habit is due | `domain/model`: the habit engine switches over it |
| `Habit`, `HabitLog`, `Routine`, `Goal`, `AchievementUnlock`, `UserData` | freezed classes | The user's data | `domain/model`: pure Dart |
| `TimeOfDayValue` | extension type | A time of day, `HH:mm` | `domain/model`, beside `CalendarDate` |
| `AppDatabase`, `UserDataDao`, `HabitLogsDao` | drift | Storage and its rules | `core/database`: only `data/` uses it |
| `UserRows` | class | Every table's rows, to write or read | `core/database/daos` |
| `MomentumService`, `FakeMomentumService` | interface / fake | The "remote" demo | `core/network` |
| `DemoRepository`, `SettingsRepository` | contracts + impls | Load the demo; the onboarded flag | `domain/repository`, `data/repository` |
| `LoadDemoUseCase`, `StartEmptyUseCase` | use cases | Welcome's two choices | `domain/usecase` |
| `WelcomeCubit`, `WelcomeState` | Cubit / freezed | Welcome's buttons, spinner and error | `features/welcome` |

---

## 🌱 Folder Structure Changes

- **New:** `assets/json/`, `drift_schemas/`, `lib/core/{common,database,network,storage}`, `lib/data/{mapper,repository}`, `lib/domain/{model,repository,usecase}`, `lib/features/welcome/cubit`, `lib/di/app_module.dart`; tests mirroring them, plus `test/helpers/fakes`.
- **Removed:** `lib/core/navigation/placeholder_onboarding.dart`.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Storage | Room: Habit, HabitCompletion, Routine, RoutineItem, Goal, Achievement, Reminder entities | SwiftData `@Model`s in a `ModelContainer` | drift: seven tables with CHECKs, composite keys, cascades and an exported schema |
| Habit model | stores `currentStreak`, `longestStreak`, `completionRate` | the same | stores none of them: derived from logs (Phase 3) |
| Completion | a timestamp per completion | a `Date` per completion | one log per habit per day, with a count (daily targets) and skips |
| Frequency | an enum | an enum with `custom(days)` | a sealed union: daily, on weekdays (a bitmask), N times a week |
| Goal | stores `currentCount` | the same | counted per window (Phase 4); a sealed scope: all habits or one |
| Achievements | an `unlocked` flag | the same | rules in code (Phase 5); unlocks stored once, with a date |
| Fake API | `syncHabits / syncGoals / syncAchievements`: hard-coded, delayed, optional errors | `FakeHabitSyncService.seed()` | `fetchDemo()` from bundled JSON, 600 ms, a failure switch |
| Demo | demo data | a seed on first launch | chosen on Welcome; anchored to ISO weeks so weekday schedules hold |
| Settings | DataStore | `@AppStorage` | `SharedPreferencesWithCache`, read before the first frame |
| Tests | — | store tests | constraints, cascades, upserts, atomicity, a round trip of every field, the demo as of every weekday, flows, mutation checks |

Both native models store figures derived from the history (streaks, rates, counts). This edition stores only the history, so nothing can disagree with it.

---

## 🎤 Interview Notes

**Q: Why store a log per habit per day instead of a row per completion?**
A: Habits have daily targets ("8 glasses"), and a day can be skipped. One row per (habit, day) with a count and a skip flag says everything about that day, the primary key makes a duplicate impossible, and +1 becomes an upsert that adds to the count. "Not done" is the absence of a row, so there is exactly one way to say it.

**Q: How do you keep invalid data out of the database?**
A: With constraints, not only with code. A CHECK makes a log either a skip or a count; each schedule type must have exactly its columns; targets are ranged; a goal names a habit exactly when it counts one. The models assert the same invariants in debug builds. Tests insert broken rows and expect SQLite to refuse them, and removing a CHECK on purpose fails a test.

**Q: Your demo has relative dates. Why weeks and not days ago?**
A: "3 days ago" is a Saturday one day and a Sunday the next, so a Mon / Wed / Fri habit's history would land on the wrong days and its streak would look broken. Anchoring each entry to a weekday of an ISO week counted back from today's keeps every schedule intact. The test loads the shipped demo as of all seven weekdays.

**Q: How do you make the demo load all-or-nothing?**
A: Check first, write once. The mapper validates everything (ids, limits, schedules, days before a habit's start, duplicates) and throws before any write. The write is one transaction, so a database error rolls back too. Only then does onboarding end. A test breaks a row mid-write and checks that the old data is untouched.

**Q: What did you learn about drift's DateTime storage?**
A: Stored as ISO-8601 text, it sorts in time order only to the millisecond, because the fraction is three digits when the microseconds are zero and six otherwise. A round-trip test caught two goals 1 µs apart coming back reversed. Reads break ties with an id.

---

## 📝 Learning Checklist

- ✅ Model a schedule as a sealed union, and store it as columns with CHECKs
- ✅ Use composite primary keys and an adding upsert for daily logs
- ✅ Make invalid rows impossible with constraints, and test that SQLite refuses them
- ✅ Load data all-or-nothing: check, then write in one transaction
- ✅ Keep a demo current with dates relative to today's ISO week
- ✅ Read preferences before the first frame with `@preResolve`
- ✅ Prove tests with mutation checks
- ⬜ The schedule engine, Today, Habits, the habit form and Habit detail (Phase 3)

---

## 🚀 Future Improvements

- **Phase 3:** `isDue`, streaks, perfect days and the completion rate as pure functions over these models, with Today, Habits, the habit form and Habit detail reading the database through their DAOs.
- **Phase 6:** a backup that maps `UserData` to DTOs in the other direction, and a database shared with the background isolate.
- **Later:** a real backend behind `MomentumService`.
