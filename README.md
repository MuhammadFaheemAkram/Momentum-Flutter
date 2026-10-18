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
| 2 | Data models, the drift store, the fake service and the demo; Welcome | ⏳ Next |
| 3 | The schedule engine, Today, Habits, the habit form and Habit detail | |
| 4 | Goals and routines | |
| 5 | Achievements, analytics and search | |
| 6 | Notifications, background tasks and settings | |
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
| Testing | `flutter_test` | 1 |

Planned: `flutter_bloc`, `freezed`, `json_serializable`, `drift` (shared across isolates), `shared_preferences`, `clock`, `intl` (Phase 2); `bloc_concurrency`, `stream_transform`, `fl_chart` (Phase 3); `flutter_local_notifications`, `timezone`, `workmanager`, `dynamic_color`, `package_info_plus` (Phase 6).

---

## 🏛️ Architecture

A clean, layered architecture with a one-directional data flow:

```
lib/
├── app/        → root widget (MaterialApp.router, themes)
├── core/       → design system, navigation, (later) the database, the fake service, notifications, background work
├── data/       → repository implementations + mappers               (Phase 2)
├── domain/     → models, the pure habit engine, contracts, use cases (Phase 2)
├── features/   → one folder per screen (Page + View + Cubit/Bloc)
└── di/         → composition root (get_it + injectable)
```

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
├── build.yaml                      # lint-free generated files
├── lib/
│   ├── main.dart                   # binding → configureDependencies() → runApp
│   ├── app/                        # MomentumApp: themes and the router
│   ├── core/
│   │   ├── design_system/          # theme/ (AppTheme, AppColors, HabitPalette, tokens), widgets/ (state views, SectionHeader), large_text
│   │   └── navigation/             # app_routes (+ .g.dart), app_router, first_launch_redirect, fallback Close button
│   ├── features/                   # welcome, shell (tabs + drawer), today, habits, habit_form, habit_detail,
│   │                               # routines, routine_editor, goals, analytics, achievements, search, settings, about
│   └── di/                         # injection.dart (+ .config.dart)
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

**121 tests** after Phase 1:
- **Navigation:** every rule of the first-launch gate; typed locations; the app on its real DI graph (first launch, each tab, the drawer over every tab, each drawer screen and Back, Search from the app bars, the habit form from both "New habit" buttons and over its habit, the routine editor, deep links with a Close button, an unknown location).
- **Design system:** the themes, and WCAG AA contrast of every status color (done, skipped, missed, streak) on the page, cards and filled fields, and of all eight habit colors with their text, in both themes.
- **The drawer:** its order, the selected tab, where each item leads, and the tab bar's short label for Achievements.
- **The accessibility tour:** Welcome, the drawer and every screen, in light and dark at 200 % text: no overflow, tap targets ≥ 48 × 48, labels, contrast. The tab labels keep their size at 300 % (a long press shows them, with the full name for Badges).

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

---

## 🗺️ Roadmap

The phases above. Ideas after them are collected in `docs/ROADMAP.md` in Phase 7.

---

## 📄 License

[MIT](LICENSE) © 2026 BitFuse
