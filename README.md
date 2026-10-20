# 🌱 Momentum (Flutter)

[![Flutter CI](https://github.com/MuhammadFaheemAkram/Momentum-Flutter/actions/workflows/flutter-ci.yml/badge.svg)](https://github.com/MuhammadFaheemAkram/Momentum-Flutter/actions/workflows/flutter-ci.yml)
![Flutter 3.47.6](https://img.shields.io/badge/Flutter-3.47.6-02569B?logo=flutter)
![Dart 3.13](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

A learning-focused, production-inspired **Flutter** habit and productivity app:
- build **habits** that follow a schedule (every day, chosen weekdays, or N times a week), with daily targets and skips;
- keep **streaks** and a perfect-day streak;
- run **routines**, set **goals** and earn **achievements**;
- read your **analytics** and **search** everything;
- get **reminders** you can mark done straight from the notification.

It is built with **Flutter 3.47**, **Dart 3.13** and a clean, layered architecture, and runs on **Android and iOS**.

Momentum is **local-first**: everything lives in a database on the device, and a fake service in the app delivers the demo and receives simulated backups. There is **no API key and no server**.

> **Why this repo exists**
>
> It is the Flutter edition of an app that also exists natively for [Android](https://github.com/MuhammadFaheemAkram/Momentum) and [iOS](https://github.com/MuhammadFaheemAkram/iMomentum). This edition follows the **Android** one closely (its Jetpack Compose UI is already Material 3) and adapts to iOS where the platform has its own conventions. It focuses on:
> - a **schedule-aware habit engine:** "due today", streaks, perfect days and the consistency score follow each habit's schedule, and a day that wasn't due, or was skipped, never breaks a streak;
> - **derived, never stored:** streaks, rates, goal progress and scores are calculated from dated logs;
> - **achievements as pure rules**, each unlock recorded once with its date;
> - **notifications that are planned:** a pure planner turns habits and logs into the next week of reminders, and a scheduler applies only the difference;
> - **background work in a second isolate** (`workmanager`), sharing the database and the business rules with the app;
> - typed `go_router` navigation with a tab bar *and* a navigation drawer, code-generated DI, and a test suite that includes an accessibility tour.
>
> Each phase ships with a beginner-to-intermediate friendly write-up in [`docs/`](docs/) that also shows how the Android and iOS editions approached the same feature.

---

## 📋 Project Status

Momentum is built in **strict, reviewable phases**. Each phase ends with:
- a building app (Android + iOS);
- a clean analyzer and passing tests;
- a summary doc;
- exactly one commit.

| Phase | Scope | Status |
|------:|-------|:------:|
| 1 | Foundation: FVM project, design system base with the habit palette, typed routes with a first-launch gate, 5-tab shell with a navigation drawer, CI | ✅ Done |
| 2 | Data models, the drift store with its constraints, the fake service and the demo; Welcome for real | ✅ Done |
| 3 | The schedule engine (due days, streaks, perfect days, rates), Today, Habits, the habit form and Habit detail with a calendar you can backfill | ✅ Done |
| 4 | Goals counted per day, ISO week or month; routines with steps reordered by drag or screen reader, checked off each day; both on Today | ✅ Done |
| 5 | Ten badges as rules over the history, unlocked once and celebrated; analytics with the consistency score; debounced search with recent searches | ✅ Done |
| 6 | Notifications, background tasks and settings | ⏳ Next |
| 7 | Open-source polish and final docs | |

---

## ✨ Features (the plan)

- 🚀 **First launch:** explore with a demo (habits, 8 weeks of history, routines, goals) or start empty
- ☀️ **Today:** a ring for today's due habits, the perfect-day streak, complete, +1, skip and undo, today's routines and goals, this week at a glance
- ✅ **Habits:** daily, on chosen weekdays or N times a week; a daily target ("8 glasses"); start date, reminder time, color and icon; search, categories, archive
- 🗓️ **Habit detail:** a calendar heatmap you can backfill, current and longest streak, completion rate, a weekly chart
- 🌅 **Routines:** ordered items, drag to reorder (with screen-reader move actions), checked off for today
- 🎯 **Goals:** daily, weekly and monthly, counted from your logs
- 🏆 **Achievements:** badges with the date you earned them and progress toward the next
- 📈 **Analytics:** completion rate, consistency score, weekly and monthly bars, streak history, your most successful habit, categories
- 🔎 **Search:** habits, routines, goals and achievements
- 🔔 **Reminders:** only on due days and not once done, a "Mark done" action, a missed-habit nudge and a daily summary
- ⚙️ **Settings:** appearance, dynamic color (Android 12+), notifications, simulated backups, reset progress, developer tools
- ♿ **Accessible:** dark mode and large text on every screen, labelled controls, never color alone, checked by a test tour that grows with the app

---

## 🧰 Tech Stack

Packages arrive in the phase that first needs them.

| Area | Choice | Since |
|------|--------|:-----:|
| Toolchain | Flutter 3.47.6 · Dart 3.13, pinned per project with [FVM](https://fvm.app) (`.fvmrc`) | 1 |
| Platforms | Android · iOS 15+ | 1 |
| UI | [`material_ui`](https://pub.dev/packages/material_ui): Material 3 as a standalone package; adaptive widgets on iOS where it matters | 1 |
| Navigation | `go_router` + `go_router_builder` (typed routes, `StatefulShellRoute`, a first-launch `redirect`) | 1 |
| Dependency injection | `get_it` + `injectable` (a code-generated composition root) | 1 |
| Lints / CI | `flutter_lints` + strict analyzer modes; GitHub Actions | 1 |
| State | `flutter_bloc` (Cubits; one Bloc, Search); `bloc_concurrency` (`restartable`) | 2, 5 |
| Models | `freezed` (sealed unions for schedules and goal scopes) + `json_serializable` (checked DTOs) | 2 |
| Database | `drift` + `drift_flutter`: SQLite with CHECK constraints, foreign keys and an exported schema; shared across isolates | 2 |
| Preferences | `shared_preferences` (`SharedPreferencesWithCache`, loaded before the first frame) | 2 |
| Time | `clock` (a fixed clock in tests); `CalendarDate` and `TimeOfDayValue` extension types | 2 |
| Streams | `stream_transform` (`combineLatest`: the clock, habits and logs into one live view) | 3 |
| Charts | `fl_chart` (weekly bars, each with a written summary); the calendar heatmap is built from widgets | 3 |
| Text and time | `intl` (dates, 12- or 24-hour times as the device has them); `characters` (lengths as people count them) | 3 |
| iOS touches | `cupertino_ui`: the time wheel and alerts on iOS | 3 |
| Testing | `flutter_test`, `bloc_test`, `mocktail`, `fake_async` | 1–2 |

Planned: `flutter_local_notifications`, `timezone`, `workmanager`, `dynamic_color`, `package_info_plus` (Phase 6).

---

## 🏛️ Architecture

A clean, layered architecture with a one-directional data flow:

```
lib/
├── app/        → root widget (MaterialApp.router, themes)
├── core/       → design system, navigation, the database, the fake service, storage; (later) notifications, background work
├── data/       → repository implementations + mappers (rows ⇄ models, the demo DTO → models)
├── domain/     → models, the pure habit engine (calculation/), contracts, use cases
├── features/   → one folder per screen (Page + View + Cubit/Bloc)
└── di/         → composition root (get_it + injectable)
```

**Data flow:**

```
Welcome ── Explore with demo data ──▶ WelcomeCubit ──▶ LoadDemoUseCase
                                                         │
          FakeMomentumService (600 ms) ──▶ DemoDto ──▶ toUserData(now)   checked: ids, limits, schedules, days
                                                         │
                                       UserData ──▶ rows ──▶ UserDataDao.replaceAll   one transaction
                                                         │
                                       SettingsRepository.setOnboarded ──▶ the router's gate ──▶ Today
```

- **drift is the source of truth.** Everything the user owns lives in seven tables, and the fake service only delivers the demo.
- **Invalid rows can't exist:** CHECK constraints (a log is a skip *or* a count; each schedule has exactly its columns; targets in range), primary keys (one log per habit per day, one unlock per badge) and cascades (deleting a habit takes its logs and goals).
- **Derived, never stored:** no column holds a streak, a rate, a goal's count or a score; they are calculated from the logs.
- **The demo moves with today**, anchored to ISO weeks so a Mon / Wed / Fri habit stays on its days.

**The habit engine** (`domain/calculation/`, pure Dart, 67 tests):

```
habits + logs + today ──▶ HabitHistory ──▶ isDue · stateOn · weekOutcome
                                ├──▶ habitStreak      days, or ISO weeks for N× a week
                                ├──▶ perfectDayStreak nothing due missed, something done
                                ├──▶ completionRate   done ÷ (due − skipped)
                                ├──▶ goalProgress     done habit-days in today / the ISO week / the month
                                └──▶ Today · Habits · Habit detail · Goals (built again on every change, and at midnight)
routines + check-offs + today ──▶ routinesToday    in the order of the day; only today's check-offs count
everything + unlocks ──────────▶ achievementProgress · newlyEarned   ten rules; an unlock is recorded once, and stays
habits + logs + today ─────────▶ consistencyScore · buildAnalytics  30 days, the last 7 counted twice
```

- **Fixed days** (daily, on weekdays) are judged per day: a due day not done breaks the streak; days not due and skipped days pass over it; today counts once done and never breaks it.
- **Times a week** is judged per ISO week: the week has N slots, a skip uses one, and the streak counts weeks that met their target. A weekly habit's empty day is never a "miss".
- **Goals** count a habit's done days (its daily target reached) in the current window: today, the ISO week, or the month. Nothing resets; the next window simply counts from zero.
- **Badges** are rules in code; only the moment each is earned is stored. While the app runs, a watcher re-checks the rules once a burst of writes settles, records what's newly earned (once, in a transaction) and celebrates it with a SnackBar on whatever screen is showing.
- **Routines** are written whole: a save rewrites every step's position in one transaction, and steps keep their ids, so their check-offs follow them when reordered.

**Navigation:**

```
GoRouter ── redirect: firstLaunchRedirect(onboarded, location)   ◀── refreshListenable
  │
  ├─ /welcome          (until the user has started)
  │
  ├─ tab shell         StatefulShellRoute ── MainShell (NavigationBar + navigation drawer)
  │                      /today · /habits · /analytics · /achievements · /settings
  │
  └─ root-level        /habits/new, /habits/:habitId (+ /edit), /routines (+ /new, /:routineId/edit),
     screens           /goals, /search, /about
                       → pushed above the tab bar; forms open as full-screen dialogs
```

Key rules:
- **The router owns the gate.** No screen navigates after Welcome's choice: it records the choice, and `refreshListenable` re-runs the pure `firstLaunchRedirect`.
- **Typed routes only:** no string paths in widgets.
- **Tabs and a drawer, as in the Android edition.** The five tabs are a `NavigationBar`; Routines, Goals, Search and About live in a drawer that slides over the whole screen. Every tab's app bar opens it, and Today and Habits also have a Search button (one tap on iOS, where drawers are less expected).
- **Screens above the tabs** are pushed on the root navigator, so Back, and the iOS edge swipe, return to the tab with its state intact. Links work: `/habits/h1/edit` opens the form over its habit, and a link opened cold gets a Close button.
- **Widgets render state; logic lives elsewhere.** Each screen is a Page plus a View.
- **Layer boundaries:** `domain/` is pure Dart, Views never import `data/`, and only `data/` touches the database.

---

## 🗂️ Folder Structure

```
Momentum/
├── .fvmrc                          # pinned Flutter version (3.47.6)
├── .github/workflows/flutter-ci.yml
├── analysis_options.yaml           # lints + strict analyzer modes
├── build.yaml                      # lint-free generated files; drift options
├── assets/json/demo.json           # the fake service's demo
├── drift_schemas/                  # every exported schema version (v1)
├── lib/
│   ├── main.dart                   # binding → await configureDependencies() → runApp
│   ├── app/                        # MomentumApp: themes and the router
│   ├── core/
│   │   ├── design_system/          # theme/ (AppTheme, AppColors, HabitPalette, tokens), widgets/ (state views, SectionHeader), large_text
│   │   ├── common/                 # Result, AppException, guardWrite, IdGenerator, CalendarClock
│   │   ├── database/               # AppDatabase, tables/, daos/, converters
│   │   ├── navigation/             # app_routes (+ .g.dart), app_router, first_launch_redirect, stream_listenable, fallback Close button
│   │   ├── network/                # MomentumService (fake), dto/, NetworkSimulator, AssetJsonLoader
│   │   └── storage/                # SettingsLocalDataSource
│   ├── data/                       # mapper/ (rows ⇄ models, the demo), repository/ (habits, logs, routines, goals, badges, search, demo, settings)
│   ├── domain/                     # model/ (Habit, HabitSchedule, HabitLog, …, read models), calculation/ (the engine, validation), repository/, usecase/
│   ├── features/                   # welcome, shell (tabs + drawer), today, habits, habit_actions (shared), habit_form, habit_detail,
│   │                               # routines, routine_editor, goals, analytics, achievements, search, settings, about
│   └── di/                         # injection.dart (+ .config.dart), app_module.dart
└── test/                           # mirrors lib/, plus app/ (the accessibility tour) and helpers/
```

---

## ▶️ How to Run

Prerequisites:
- [FVM](https://fvm.app);
- Xcode, for iOS;
- the Android SDK, with Java 17+ (Android Studio's bundled JDK works).

```bash
fvm install            # installs the version pinned in .fvmrc (3.47.6)
fvm flutter pub get
fvm flutter run        # pick an Android emulator or an iOS simulator
```

Generated code (`*.g.dart`, `*.config.dart`) is committed, so the app runs straight after cloning. After changing annotated code, regenerate it:

```bash
fvm dart run build_runner build
```

---

## ✅ Testing

```bash
fvm flutter analyze
fvm dart format --output=none --set-exit-if-changed .
fvm flutter test
```

**541 tests** after Phase 5:

| Area | Tests | What they cover |
|---|---:|---|
| `domain/` | 156 | the engine: every schedule and streak edge, perfect days, the rate, goal windows and progress, today's routines; every badge rule at its edge (6 vs 7 days, 99 vs 100, 4 vs 5 mornings, a score of 79 vs 80, a week of skips is no comeback) and unlocks that stay; the consistency score's weights and minimum; the analytics series; validation; the use cases' rules |
| `data/` | 49 | the demo mapper, the shipped demo as of every weekday, a round trip of every field through the database, the repositories |
| `core/` | 148 | the schema's constraints and cascades; the DAOs (a badge recorded once, `LIKE` with `%` and `_` as plain characters, routines saved in one transaction); the midnight clock and a debounce that cancels its timer; navigation; the design system |
| `features/`, `di/` | 107 | every screen's Cubit on the real data stack; the SearchBloc in fake time (the debounce) and real time (switching, live results); the views with mocked Cubits; the composition root |
| `app/` | 81 | first launch, habit, routine, goal, badge and search flows end to end (the first completion celebrated where you are; the demo's badges celebrated together), and the accessibility tour |

- **Navigation:** every rule of the first-launch gate; typed locations; the app on its real DI graph (first launch, each tab, the drawer over every tab, each drawer screen and Back, Search from the app bars, the habit form from both "New habit" buttons and over its habit, the routine editor, deep links with a Close button, an unknown location).
- **Design system:** the themes, and WCAG AA contrast of every status color (done, skipped, missed, streak) on the page, cards and filled fields, and of all eight habit colors with their text, in both themes.
- **The accessibility tour:** Welcome (also after a failed demo), the drawer and every screen, with the demo where it has content (Today, Habits, a counted and a weekly habit's page, the forms with their errors, Routines and the editor, Goals and the goal sheet, Analytics, Achievements, Search with results), in light and dark at 200 % text: no overflow, tap targets ≥ 48 × 48, labels, contrast. The tab labels keep their size at 300 % (a long press shows them, with the full name for Badges).
- **Mutation checks:** thirty-three behaviours were broken on purpose, and each made a test fail.
  - Phases 2–4: twenty-three, covering the schema and the demo, the habit engine, goals and routines.
  - Phase 5's ten:
    - a badge at 6 days;
    - a weekly habit's weeks counted as days;
    - a half-checked morning;
    - a week of skips as a comeback;
    - unlocks decided by today's progress;
    - the score without its double week, or from too little history;
    - unescaped `LIKE` wildcards;
    - the watcher without its debounce;
    - a debounce that keeps its timer.

CI (`.github/workflows/flutter-ci.yml`) runs on every push to `main` and every pull request. It installs the FVM-pinned Flutter, checks that the committed generated code is up to date and complete, then runs format, analyze and test.

---

## 📱 Same App on Other Platforms

| Edition | Stack | Repo |
|---------|-------|------|
| Android | Kotlin · Jetpack Compose · Hilt · Room · DataStore · WorkManager | [MuhammadFaheemAkram/Momentum](https://github.com/MuhammadFaheemAkram/Momentum) |
| iOS | Swift 6 · SwiftUI · SwiftData · Swift Charts · UserNotifications · BGTaskScheduler | [MuhammadFaheemAkram/iMomentum](https://github.com/MuhammadFaheemAkram/iMomentum) |
| **Flutter** | Dart · Flutter · Bloc · drift · workmanager | this repo |

| Concept | Android | iOS | Flutter |
|---|---|---|---|
| UI | Jetpack Compose | SwiftUI | widgets + `material_ui` (adaptive where it matters) |
| Navigation | bottom bar + drawer | `TabView` | `StatefulShellRoute` + `NavigationBar` + a `Drawer` |
| Screen state | ViewModel + StateFlow | `@Observable` | Cubit / Bloc |
| Storage | Room + DataStore | SwiftData + `@AppStorage` | drift + `SharedPreferencesWithCache` |
| Background work | WorkManager | BGTaskScheduler | `workmanager` (both), in a second isolate |
| DI | Hilt | `AppEnvironment` | `get_it` + `injectable` |

---

## 📚 Documentation

- [Phase 1 — Foundation](docs/PHASE_1_SUMMARY.md)
- [Phase 2 — Data layer](docs/PHASE_2_SUMMARY.md)
- [Phase 3 — Habits core](docs/PHASE_3_SUMMARY.md)
- [Phase 4 — Goals and routines](docs/PHASE_4_SUMMARY.md)
- [Phase 5 — Achievements, analytics and search](docs/PHASE_5_SUMMARY.md)

---

## 🗺️ Roadmap

The phases above. Ideas after them are collected in `docs/ROADMAP.md` in Phase 7.

---

## 📄 License

[MIT](LICENSE) © 2026 BitFuse
