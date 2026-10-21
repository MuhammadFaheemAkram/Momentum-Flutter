# Architecture

Momentum is a layered, local-first app with a one-directional data flow. The database is the source of truth: screens watch it, and every figure (due today, streaks, perfect days, rates, goals, badges' progress, analytics, the notification plan) is derived when it's read.

```
lib/
├── main.dart     → binding → configureDependencies() (awaits @preResolve values) → background work registered
│                   → the launch notification's screen → runApp
├── app/          → MomentumApp: the app-wide SettingsCubit, themes, the router, and what runs while the app does
│                   (badge celebrations, the notification sync, resume, notification taps)
├── background/   → the OS's entry points (workmanager, a notification action) and their hand-built BackgroundGraph
├── core/
│   ├── common/        Result, AppException (sealed), guardWrite, firstValue, IdGenerator, CalendarClock, Stream.settled
│   ├── database/      AppDatabase (drift v1, shared across isolates), tables/, daos/, converters
│   ├── design_system/ theme/ (AppTheme, AppColors, HabitPalette), formatting/, widgets/, the large-text rule
│   ├── navigation/    typed routes, the router, firstLaunchRedirect, the Close fallback, StreamListenable
│   ├── network/       MomentumService, FakeMomentumService, NetworkSimulator, AssetJsonLoader, dto/ (demo, backup)
│   ├── platform/      LocalNotifications, WorkmanagerBackgroundWork, MaterialYouColorSource
│   └── storage/       SettingsLocalDataSource (SharedPreferencesWithCache)
├── data/         → repository implementations + mappers (rows ⇄ models, the demo DTO → models, models ⇄ the backup DTO)
├── domain/       → models, the habit engine and the notification planner (calculation/), repository contracts,
│                   service interfaces, use cases: pure Dart
├── features/     → one folder per screen: Page + View (+ cubit/ or bloc/, widgets/)
└── di/           → injection.dart (+ .config.dart), app_module.dart
```

```
View ─intent─▶ Cubit/Bloc ─▶ UseCase ─▶ Repository ─▶ drift ◀── watch() streams ── UseCase (+ clock) ─▶ Cubit ─▶ state ─▶ View
                                   └─▶ Service (notifications, background work, wallpaper colors)

app-wide watchers:   history changes ──settled──▶ EvaluateAchievements ──▶ SnackBar on any screen
                     history / settings / midnight ──settled──▶ SyncNotifications ──▶ the device
background isolate:  workmanager / "Mark done" ──▶ BackgroundGraph ──▶ the same use cases, the same database
```

## Layers and their rules

Checked against the imports in the code:

| Layer | May import | Never imports |
|---|---|---|
| `domain/` | Dart, `freezed_annotation`, `injectable`, `clock`, `characters`, `stream_transform`, `core/common` | Flutter, drift, `data/`, other `core/` |
| `data/` | `domain/`, `core/database`, `core/network`, `core/storage` | `features/`, `material_ui` |
| `core/database/` | drift | `material_ui`, JSON packages (name clashes, conventions §11.1) |
| `core/platform/` | plugins, `domain/` | `features/`, `data/` |
| `features/` | `domain/`, `core/design_system`, `core/navigation`, `di/` (Pages only) | `data/`, drift |
| `background/` | everything it wires (it's a composition root, like `di/`) | `features/` |

- **Pages and Views:** a Page creates and provides its Cubit (`getIt<…>()`); a View renders state and forwards intents. View tests mock the Cubit; Cubit tests use the real data stack.
- **One use case per user action** (`AddCheckIn`, `SkipHabit`, `SetHabitDay`, `SaveRoutine`, `SaveGoal`, `MarkHabitDone`, `BackUpNow`, `ResetProgress`, `SetNotificationsEnabled`, one per setting…). They hold the rules that aren't SQL: "an archived habit can't be logged", "backfill reaches 30 days", "denied permission keeps notifications off".
- **Live views as use cases:** `WatchToday`, `WatchHabits`, `WatchHabitDetail`, `WatchRoutines`, `WatchGoals`, `WatchAchievements`, `WatchAnalytics` combine repository streams with `CalendarClock.watchToday()` (the clock first, §11.61) and build read models with the pure engine.
- **Pure calculations** in `domain/calculation/`: the schedule engine, streaks, perfect days, the completion rate and consistency score, goal windows, today's routines, the ten badge rules, analytics, validation, and `planNotifications`. Tested without Flutter or a database. See [HABIT_ENGINE.md](HABIT_ENGINE.md).

## Who owns what

| Data | Owner | Written by |
|---|---|---|
| habits, logs, routines and their items and check-offs, goals | the user | their repositories, through use cases |
| badge unlocks | the user, recorded by the app | `EvaluateAchievements` (the app's watcher, and the background tasks), once per badge |
| settings, recent searches | the device | `SettingsRepository`, `RecentSearchesRepository` |
| the notifications on the device | derived from the above | `SyncNotificationsUseCase` only |
| the latest backup | the (fake) service, in memory | `BackupRepository` |
| the network failure switch | developer tools | `NetworkSimulator` (in memory, off at launch) |

## State management

- **Cubits by default:** one per screen (`TodayCubit`, `HabitsCubit`, `HabitFormCubit`, `HabitDetailCubit`, `RoutinesCubit`, `RoutineEditorCubit`, `GoalsCubit`, `AchievementsCubit`, `AnalyticsCubit`, `WelcomeCubit`, `SettingsToolsCubit`). Each subscribes in `start()`/`load()` and cancels in `close()`.
- **One Bloc:** `SearchBloc`, because typing is a stream of events that needs a transformer (`debounceRestartable`: a debounce, then `restartable`, which drops the previous query's live results).
- **One app-wide Cubit:** `SettingsCubit` above `MaterialApp.router` (theme mode, dynamic color). Everything else belongs to its screen.
- **Immutable state:** freezed classes with a status enum, sealed results (`HabitFormExit`, `GoalEditorResult`), exhaustive `switch`es.
- **One-time effects** (SnackBars, a sheet) are a value plus a serial number in the state, so the same message twice still shows twice; `BlocListener` with `listenWhen` on the serial.
- **App-wide work** lives in `MomentumApp`'s `State`: the badge watcher (`WatchNewAchievements`, settled 300 ms, `asyncMap`), the notification watcher (`KeepNotificationsInSync`), `AppLifecycleListener(onResume:)`, and the notification taps.

## Error handling

- **Writes return a `Result`** (`Ok` / `Err`) and never throw. `guardWrite` turns drift and SQLite errors into an `AppException`.
- **`AppException` is sealed:** `NetworkException`, `DataFormatException`, `NotFoundException`, `InvalidInputException`, `UnknownException`, each with a message written for the user.
- **Streams that fail** move their screen to a failure state (`ErrorView` with Try again).
- **Validation is pure** (`validation.dart`), shared by the forms (an error under a field after the first Save) and the use cases (which refuse what slips past). The database's `CHECK`s back it up.
- **Background work never loops:** each task reports its outcome; a failed backup is reported, not retried.

## Writes

- **Atomic:** loading the demo, saving a routine (every step's position), recording badges and resetting progress each run in one transaction.
- **Upserts, never `REPLACE`:** a log is `INSERT … ON CONFLICT DO UPDATE` (+1, skip, backfill); `REPLACE` would delete first and cascade (§11.53).
- **Undo restores the previous log** (or none), through `RestoreHabitDay`.

See [DATA_MODEL.md](DATA_MODEL.md).

## Navigation

- **Typed `go_router` routes** (`go_router_builder`): `StatefulShellRoute.indexedStack` with five tabs (Today, Habits, Analytics, Achievements, Settings), and root-level routes above them: the habit form and Habit detail, Routines and the routine editor, Goals, Search, About.
- **A tab bar and a drawer**, as in the Android edition: the drawer (Routines, Goals, Search, About) belongs to the shell's outer `Scaffold`; `ShellDrawerScope` lets each tab's app bar open it.
- **A pure gate:** `firstLaunchRedirect(onboarded, location)`, re-run through a `refreshListenable` over the settings stream. No screen navigates after Welcome's choice.
- **Full-screen dialogs** for the habit form and the routine editor; **sheets** for goals, the iOS time wheel and the planned notifications (`showAppSheet`, on the root navigator).
- **Deep links** work everywhere, with a Close button when opened cold (§11.47). A reminder's tap uses the same routes: cold, it's the initial location; warm, the habit is pushed.

## Dependency injection

- **`get_it` + `injectable`:** classes are annotated (`@injectable`, `@LazySingleton(as: …)`), and `build_runner` generates the composition root.
- **`AppModule`** provides third-party objects: the asset bundle, the `Clock`, the database and its DAOs, `LocalNotifications` (under both its interfaces), and three `@preResolve` values awaited before `runApp`: `SharedPreferencesWithCache` (the router knows where to open), `AppInfo` (`package_info_plus`) and `DeviceColors` (the wallpaper's color, so the first frame is already in it).
- **The background isolate** builds its own small graph by hand (`BackgroundGraph`), from the same classes: `getIt` is empty in a new isolate.
- **Tests swap a few registrations** (`configureTestDependencies`): an in-memory database, a zero-latency network, a fixed clock, in-memory preferences, a fake notification scheduler, no background work, a mocked dynamic color channel and package info.

## Platform services

All behind `domain/service` interfaces, implemented in `core/platform`:

| Interface | Implementation | Platforms |
|---|---|---|
| `NotificationScheduler`, `NotificationInteractions` | `LocalNotifications`: `flutter_local_notifications` + `timezone` + `flutter_timezone` | both: channels and an action on Android, a category on iOS |
| `BackgroundWork` | `WorkmanagerBackgroundWork`: `workmanager` | WorkManager (Android), BGTaskScheduler (iOS) |
| `DynamicColorSource` | `MaterialYouColorSource`: `dynamic_color` (the palette only, §11.55) | Android 12+; `null` elsewhere |

See [NOTIFICATIONS.md](NOTIFICATIONS.md) and [BACKGROUND_WORK.md](BACKGROUND_WORK.md).

## Accessibility

- **Every screen is in the accessibility tour** (light and dark, 200 % text): no overflow, tap targets ≥ 48 × 48, every tappable labelled, WCAG AA text contrast.
- **The large-text rule:** above 130 % (`context.prefersStackedLayout`), side-by-side layouts stack, segments become chips or a radio list, the drawer widens, and switch tiles drop their leading icons (§11.68).
- **Never color alone:** done, skipped and missed each have an icon and a word; the heatmap's days and the week strip are labelled.
- **Charts are written out:** each chart and the heatmap carry a summary for screen readers.
- **Reorder without dragging:** the routine editor's steps have Move up / down / to the start / to the end actions.
- **Tab labels keep their size** (a long press shows them), as iOS tab bars do.

## Key decisions

| Decision | Why |
|---|---|
| Logs are the only history; nothing derived is stored | Streaks, rates, goals and scores can't disagree with the logs; editing a schedule re-derives everything |
| Skipped and not-due days are neutral; weekly habits judged per ISO week | A sick day or a day off isn't failure; "3 times a week" says nothing about Thursday |
| Badges are rules in code, unlocks stored once | An achievement is a moment: "unlocked 12 Oct" stays true after the streak breaks |
| Notifications planned 7 days ahead and diffed | Reminders follow the history (none once done) without code at the moment of completion; only changes reach the device |
| A background isolate with its own graph, on a shared database | The same use cases run without the app; drift's server keeps the two isolates' writes apart and their streams current |
| Settings write only what changed, and reload on resume | Two isolates, two preference caches |
| Android-first UI, adaptive on iOS | The Android edition is Material 3 already; iOS gets its alerts, switches and time wheel |
| Plugins behind interfaces | Use cases and Cubits are tested with fakes; plugins are checked on devices |
| `material_ui` instead of `flutter/material.dart` | Material as a versioned package |
