# Contributing to Momentum (Flutter)

Thanks for your interest! Momentum is a learning-focused reference project, so contributions that improve clarity, correctness or teaching value are especially welcome.

## Ground Rules

- Be respectful. See the [Code of Conduct](CODE_OF_CONDUCT.md).
- **Keep the architecture intact:**
  - Respect the layer boundaries: View → Cubit/Bloc → UseCase → Repository → drift.
  - `domain/` stays pure Dart, Views never import `data/`, and drift files never import `material_ui`.
  - **The logs are the only history. Nothing derived is stored:** no streak, rate, goal count or score column. Pure functions in `domain/calculation/` derive them when read; a badge's unlock is the one recorded moment.
  - **Skipped and not-due days stay neutral**, weekly habits are judged per ISO week, and today pending never breaks anything. A change to these rules needs tests at the edges (see [HABIT_ENGINE.md](docs/HABIT_ENGINE.md)).
  - **Days are `CalendarDate`, times of day `TimeOfDayValue`, and "now" comes from the injected `Clock`**, never `DateTime.now()`.
  - **Platform services stay behind `domain/service` interfaces** (`NotificationScheduler`, `NotificationInteractions`, `BackgroundWork`, `DynamicColorSource`), so no plugin is reachable from a Cubit or use case test.
  - **Notifications change only through the plan:** edit `planNotifications` and let `SyncNotificationsUseCase` apply the difference; never schedule from a screen.
  - **Background code runs the same use cases** through `BackgroundGraph`; anything new it needs is added there by hand (`getIt` is empty in that isolate).
  - **The router owns navigation decisions.** Screens use typed routes only.
- **UI:** import `package:material_ui/material_ui.dart`, never `package:flutter/material.dart`.
- **Writes:** upsert with `ON CONFLICT DO UPDATE`, never `INSERT OR REPLACE` (it deletes and cascades); several rows that belong together go in one transaction.
- **Settings:** write only the keys that changed (the background isolate has its own cache).
- **Dependencies:** keep them few and mainstream, and explain each new one in the README's tech stack.

## Development Setup

- Install [FVM](https://fvm.app), then run `fvm install`. It reads `.fvmrc`, which pins Flutter 3.47.6.
- iOS needs Xcode. Android needs the Android SDK and Java 17+ (Android Studio's bundled JDK works).
- Get the packages with `fvm flutter pub get`, then start the app with `fvm flutter run` and choose **Explore with demo data**.
- After changing annotated code (freezed, json_serializable, injectable, drift, typed routes), regenerate it:

  ```bash
  fvm dart run build_runner build
  ```

  Generated files are committed, and CI fails if they are stale or missing.
- **Changing the database schema:**
  1. Bump `schemaVersion` in `app_database.dart`.
  2. Run `fvm dart run drift_dev make-migrations`. It exports the new version to `drift_schemas/` and generates the steps and the migration tests.
  3. Write the new step in the migration strategy.
  4. Add a data test for the migration.
- **Changing the demo:** keep ids stable and dates as `(weeksAgo, weekday)`, so weekday habits stay on their days. `test/data/bundled_demo_test.dart` loads it as of every weekday; tests that assert the demo's figures say which numbers they expect (see [HABIT_ENGINE.md](docs/HABIT_ENGINE.md)).
- **Trying notifications and background work** on a device: see the README and [BACKGROUND_WORK.md](docs/BACKGROUND_WORK.md).

## Coding Conventions

- **Lints:** `fvm flutter analyze` must report **no issues**. The rules are `flutter_lints` plus strict casts, inference and raw types.
- **Formatting:** `fvm dart format .` (the tall style).
- **Pages and Views:** Pages create and provide a Cubit/Bloc. Views render state and forward intents.
- **Cubit or Bloc:** use a Cubit by default. Use a Bloc only when event transformers (debounce, `restartable`) earn their place, as in `SearchBloc`.
- **Writes return a `Result`** and never throw (`guardWrite`); validation rules are pure functions shared by forms and use cases.
- **Immutable state:** freezed classes and sealed unions, rendered with an exhaustive `switch`.
- **Accessibility:** every tappable is at least 48 × 48 and has a label, text contrast meets WCAG AA in both themes, and color is never the only signal. Above 130 % text (`context.prefersStackedLayout`), side-by-side controls stack. Charts carry a written summary. The accessibility tour (`test/app/accessibility_tour_test.dart`) checks this, so add new screens and states to it.
- **Comments** explain *decisions*, not obvious code.

## Commits

This project uses **[Conventional Commits](https://www.conventionalcommits.org/)**:

```
<type>(<scope>): <message>
```

Examples: `feat(habits): add a monthly schedule`, `test(reminders): cover a habit archived mid-week`, `docs(project): update the data model`.

## Pull Requests

1. Fork the repository and create a topic branch.
2. Make sure `fvm flutter analyze`, `fvm dart format --output=none --set-exit-if-changed .` and `fvm flutter test` all pass.
3. Update or add documentation where relevant.
4. Open a PR with a clear description of the change and its motivation.

## Tests

- **The engine:** pure unit tests with the builders in `test/helpers/habit_builders.dart` (`habit()`, `done()`, `skip()`, `oct(21)`); test each rule at its edge.
- **Cubits/Blocs and use cases:** on the real data stack (`DataStack`: real repositories, an in-memory database, the real fake service, a fixed clock, a `FakeNotificationScheduler`), with `waitFor` for bounded waits.
- **Views:** widget tests with `MockCubit` / `MockBloc` from `bloc_test`, and `mocktail`.
- **drift:** `NativeDatabase.memory()`; insert broken rows to prove a constraint.
- **Timing:** debounce timing in fake time (`fake_async`); anything that switches streams in real time with a short delay.
- **App-level flows:** `pumpMomentum` (with `preferences:` and `notifications:`), and `tearDown(getIt.reset)`. A plugin touched while the graph is built needs its channel mocked in `configureTestDependencies`.
- **Background entry points:** pass a graph built from `DataStack` to `dispatchBackgroundTask` or `handleNotificationAction`.

See [docs/TESTING.md](docs/TESTING.md).
