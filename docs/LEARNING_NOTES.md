# Learning Notes

Every Flutter / Dart concept Momentum uses, grouped by topic, each pointing to where it lives in the code. The phase write-ups ([1](PHASE_1_SUMMARY.md) · [2](PHASE_2_SUMMARY.md) · [3](PHASE_3_SUMMARY.md) · [4](PHASE_4_SUMMARY.md) · [5](PHASE_5_SUMMARY.md) · [6](PHASE_6_SUMMARY.md) · [7](PHASE_7_SUMMARY.md)) explain the *why* in more depth.

---

## 1. Toolchain and project setup

| Concept | Where | Notes |
|---|---|---|
| FVM per-project pinning | `.fvmrc` | The Flutter version (3.47.6) is part of the repo. Run everything as `fvm flutter …`. |
| `material_ui` package | every UI file | Material as a standalone package: import `package:material_ui/material_ui.dart`; `cupertino_ui` for the iOS time wheel and alert actions. |
| Strict analysis | `analysis_options.yaml` | `strict-casts`, `strict-inference`, `strict-raw-types`; generated files stay in scope, with lint headers from `build.yaml`. |
| Code generation | `build.yaml`, `*.g.dart`, `*.freezed.dart`, `*.config.dart`, `app_routes.g.dart` | `build_runner` output is committed; CI fails if it is stale or missing. |
| drift options | `build.yaml` | ISO-8601 text dates, and the `make-migrations` folders. |
| Schema exports | `drift_schemas/` | `drift_dev make-migrations` exports every version for migration tests. |
| Assets | `assets/json/demo.json` | The fake service's demo, read through the injected `AssetBundle`. |
| Native setup | `android/app/build.gradle.kts`, `AndroidManifest.xml`, `res/drawable/ic_notification.xml`, `res/raw/keep.xml`, `ios/Runner/AppDelegate.swift`, `Info.plist` | Desugaring; notification permissions and the plugin's receivers; a monochrome notification icon kept from shrinking; the iOS notification delegate, background registrant callbacks and BGTask launch handler; `BGTaskSchedulerPermittedIdentifiers` and the `fetch` mode. |

## 2. Dart language

- **Extension types:** `CalendarDate` (a `yyyymmdd` `int`) and `TimeOfDayValue` (minutes since midnight), each with a private representation constructor, so every value goes through a validating factory. Zero runtime cost, real compile-time types. Static constants (`TimeOfDayValue.eightPm`) let freezed models use them as `@Default`s.
- **Sealed classes + exhaustive `switch`:** `HabitSchedule` (`Daily` / `OnWeekdays` / `TimesPerWeek`), `GoalScope`, `NotificationTarget`, `NotificationInteraction`, `BackupOutcome`, `Result`, `AppException`, `HabitFormExit`, `RoutineEditorExit`, `GoalEditorResult`, `DrawerDestination`, the `SearchEvent`s. Adding a schedule kind is a compile error everywhere one is handled.
- **Primary constructors (Dart 3.13):** `final class const Ok<T>(final T value) extends Result<T>;` (`core/common/result.dart`).
- **Private named parameters (Dart 3.13):** `BackgroundGraph({…, required this._close})`, passed as `close:`.
- **Patterns:** `if (result case Ok(value: final receipt))`, `case NotificationOpened(target: OpenHabit(:final habitId))`, `if (habit.reminder case final time?)`, `when` guards, and record destructuring: `final (((habits, logs), (routines, checks)), goals) = data;`.
- **Records:** streams combined into nested records, `(habits, logs)` pairs, `(type, weekdays, times)` when mapping a schedule to columns.
- **Class modifiers:** `final class`, `abstract final class` (namespaces such as `AppTheme`, `DateLabels`), `abstract interface class` (every repository and service contract).
- **Enhanced enums** carry their words: `HabitCategory('Health')`, `AchievementId('First step', 'Complete a habit for the first time.')`, `NotificationKind('Reminder')`.
- **`characters`:** title limits count grapheme clusters, so "👩‍💻" is one character (`validation.dart`).
- **Integer hashing:** a 32-bit FNV-1a over UTF-8 bytes, masked to Android's positive 31 bits (`notificationId`).

## 3. Architecture

- **Layers:** View → Cubit/Bloc → UseCase → Repository → drift, with `domain/` pure Dart. See [ARCHITECTURE.md](ARCHITECTURE.md).
- **Derived, never stored:** streaks, rates, perfect days, goal progress, scores and the notification plan are pure functions of the logs. See [HABIT_ENGINE.md](HABIT_ENGINE.md).
- **Live views as use cases:** `WatchToday` combines the clock, habits, logs, routines, check-offs and goals, and builds `TodayOverview` with the engine.
- **Services as interfaces:** `NotificationScheduler`, `NotificationInteractions`, `BackgroundWork`, `DynamicColorSource` in `domain/service/`, implemented in `core/platform`.
- **Validation as pure functions** shared by the forms and the use cases, backed by `CHECK`s.
- **App-wide watchers** in the root widget's `State`: badges and notifications follow every write without any write calling them.

## 4. State management (flutter_bloc)

| Concept | Where |
|---|---|
| A Cubit per screen, subscribing in `start()` and cancelling in `close()` | `TodayCubit`, `HabitsCubit`, `HabitDetailCubit`, `GoalsCubit`, … |
| A Bloc with an event transformer (`debounce` → `restartable`) | `SearchBloc`, `search_transformers.dart` |
| An app-wide Cubit above `MaterialApp.router` | `SettingsCubit` (theme mode, dynamic color) |
| A form's values in the Cubit, so a discard guard knows what changed | `HabitFormCubit`, `RoutineEditorCubit` |
| One-time effects as a value + a serial | `TodayState.notice`, `SettingsToolsState.message` / `plan` |
| A Cubit with a `Timer` for time passing, not data changing | `TodayCubit`'s "Coming up" |
| `@factoryParam` ids | `getIt<HabitFormCubit>(param1: habitId)` |
| `BlocListener` with `listenWhen`, `MultiBlocListener` | the views; Settings' message and plan sheet |

## 5. Dependency injection (get_it + injectable)

- **Annotations** (`@injectable`, `@lazySingleton`, `@LazySingleton(as: Interface)`) and a generated composition root (`injection.config.dart`).
- **`@module`** for third-party objects (`AppModule`: the asset bundle, the clock, the database and its DAOs, `LocalNotifications` under two interfaces).
- **`@preResolve`:** async values awaited before `runApp` (preferences, app info, the wallpaper's color), so the first frame needs no loading state.
- **`@ignoreParam`** for test-only knobs (`settle` durations, the network's latency).
- **A hand-built graph** for the background isolate (`BackgroundGraph`), where `getIt` is empty.
- **Test overrides:** `getIt.unregister` / `registerSingleton` in `configureTestDependencies`.

## 6. Navigation (go_router + go_router_builder)

- **Typed routes** generated from `@TypedGoRoute` classes; widgets never build path strings.
- **`StatefulShellRoute.indexedStack`:** five tabs that keep their state, and root-level routes pushed above the tab bar.
- **A drawer above nested Scaffolds** (`ShellDrawerScope`).
- **A pure redirect** (`firstLaunchRedirect`) re-run through a `refreshListenable` (`StreamListenable` over the settings stream).
- **Deep links** with a Close fallback; a notification's tap as the initial location (cold) or a push (warm).

## 7. UI, Material 3 and accessibility

| Concept | Where |
|---|---|
| A theme from a seed, and from the wallpaper | `AppTheme.light()/dark()`, `fromWallpaper` (`ColorScheme.fromSeed`, `DynamicSchemeVariant.fidelity`) |
| `ThemeExtension` for app colors | `AppColors` (done, skipped, missed, streak); `HabitPalette` maps a stored color name to a seed-derived pair per brightness, contrast-tested |
| Adaptive widgets | `SwitchListTile.adaptive`, `AlertDialog.adaptive` via `showAdaptiveDialog`, `CircularProgressIndicator.adaptive`, the time picker per platform |
| `ReorderableListView` with handles and `onReorderItem` | the routine editor; its built-in Move up / down semantics actions |
| A calendar built from widgets, each day a semantics node | `CalendarHeatmap` |
| `fl_chart` bars with written summaries | `WeeklyBarsChart`, `CountBarsChart` |
| A ring from a `CircularProgressIndicator` in a `Stack`, with its label | `CompletionRing` |
| `RadioGroup` / `SegmentedButton` / wrapping chips by text size | `SegmentedChoice`, Settings' appearance |
| The large-text rule | `context.prefersStackedLayout` (above 130 %) |
| `Semantics` done right: `container: true` for a header, its own `onTap` when excluding children | Today's date, the heatmap (§11.62) |
| Bottom sheets on the root navigator | `showAppSheet` |
| A global `ScaffoldMessenger` key | badge celebrations on any screen |
| Unique FAB hero tags in a shell | Today and Habits (§11.59) |

## 8. Data and persistence

- **drift:** tables with `CHECK`s, composite primary keys, foreign keys with `CASCADE`, indexes, `textEnum`, type converters (`CalendarDateConverter`, `TimeOfDayConverter`), DAOs, `watch()` streams, transactions, `ON CONFLICT DO UPDATE`, `LIKE` with an escape character. See [DATA_MODEL.md](DATA_MODEL.md).
- **`shareAcrossIsolates`:** one drift server for the app and the background isolate.
- **`SharedPreferencesWithCache`** with an allow-list, writing only changed keys, reloaded on resume.
- **DTOs both ways:** checked `json_serializable` DTOs in (the demo, with relative dates) and out (the backup, with a round-trip test).

## 9. Time, notifications and background work

| Concept | Where |
|---|---|
| An injected `Clock` for "now"; `CalendarDate` for days | everywhere; `Clock.fixed` in tests |
| A stream that emits at each local midnight | `CalendarClock.watchToday` |
| `combineLatest` with the clock first; a debounce that cancels its timer | §11.61; `Stream.settled` (§11.63) |
| Planning as data, then diffing against the device | `planNotifications`, `SyncNotificationsUseCase` |
| Zoned scheduling in the device's time zone | `timezone`, `flutter_timezone`, `TZDateTime(tz.local, …)` |
| Notification channels, an action, an iOS category | `LocalNotifications` |
| Cold and warm notification taps | `launchTarget()`, `interactions` |
| Background isolates and `@pragma('vm:entry-point')` | `background_entry.dart` |
| `DartPluginRegistrant.ensureInitialized()` | the notification action's isolate |
| WorkManager / BGTaskScheduler through `workmanager` | `WorkmanagerBackgroundWork`, `AppDelegate.swift`, `Info.plist` |
| `AppLifecycleListener(onResume:)` | `MomentumApp` |
| Serialising async calls by chaining futures | `SyncNotificationsUseCase._queue` |

## 10. Testing

- **`flutter_test`**, **`bloc_test`** (`MockCubit`, `whenListen`), **`mocktail`**, **`fake_async`**.
- **The real data stack** with an in-memory database (`NativeDatabase.memory()`), a fixed clock and fakes (`DataStack`).
- **The real app** on the real DI graph (`pumpMomentum`), with notification taps and actions played by a fake.
- **Accessibility guidelines** (`androidTapTargetGuideline`, `labeledTapTargetGuideline`, `textContrastGuideline`) in a tour of every screen.
- **Semantics actions in tests:** `find.semantics.byPredicate` and `owner.performAction`.
- **Lifecycle in tests:** `handleAppLifecycleStateChanged` through the real state sequence.
- **Mutation checks:** 53 behaviours broken on purpose, each caught. See [TESTING.md](TESTING.md).

## 11. Tooling and repo hygiene

- **Conventional Commits**, one commit per phase, each with a phase summary.
- **CI** on the pinned Flutter: generated code current and committed, format, analyze, test.
- **Docs that teach:** the habit engine worked through on the demo, notifications and background work explained per platform, the Android and iOS editions compared in every phase.
