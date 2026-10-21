# Changelog

All notable changes to this project are documented here. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the project follows [Conventional Commits](https://www.conventionalcommits.org/).

## [Unreleased]

_All seven build phases are complete. See [`docs/ROADMAP.md`](docs/ROADMAP.md) for what's next._

## [0.7.0] — 2026-10-21 — Phase 7: Documentation & CI

### Added
- **Docs:** ARCHITECTURE, DATA_MODEL, HABIT_ENGINE (every rule worked through on the demo), NOTIFICATIONS, BACKGROUND_WORK, API_SIMULATION, TESTING (tests per area and all 53 mutation checks), LEARNING_NOTES, INTERVIEW_NOTES, ROADMAP, and SCREENSHOTS (light, dark, large text, and Android dynamic color); the Phase 7 summary.
- **Open-source files:** CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, this CHANGELOG, and the GitHub issue and PR templates.
- **Mutation checks** of seven more key behaviours ("done" at the target, foreign keys on, start dates, the first-launch gate, archived habits, reset clearing badges, the backup round trip), each caught.

### Changed
- The README is final: features, a short test summary linking to TESTING, screenshots, and every doc.
- The Android build file's template TODOs are now notes that say what the settings are.
- The Phase 6 summary's backup example uses the demo's real count (209 logs).

## [0.6.0] — 2026-10-21 — Phase 6: Notifications, Background + Settings

### Added
- **The notification planner:** reminders on due days (none once done or skipped), the missed-habit nudge and the daily summary, over a rolling 7-day window, at most 60, with stable ids and the time in the payload.
- **`SyncNotificationsUseCase`:** plan → compare with what's pending → cancel stale, schedule new or changed; after every change, at midnight, on resume and in the background; a revoked permission turns notifications off.
- **`LocalNotifications`:** two Android channels, the device's time zone, inexact alarms, the permission flow with a way to the system settings, **"Mark done"** on both platforms, and taps routed on cold and warm start.
- **Background work** with `workmanager` in a second isolate with its own hand-built graph on the shared database: badges, a daily backup when due, and the notification sync.
- **Settings:** System / Light / Dark from an app-wide `SettingsCubit`; dynamic color on Android 12+; notifications with the nudge and summary times; a default reminder time; Back up now and automatic backup; reset progress; developer tools (simulate failure, run the background tasks, show the plan); About with the version and the other editions.
- **The backup DTO,** mapped out from the domain, with a round trip of every field.
- Today's "Coming up": the next reminders still to ring.
- Android desugaring, notification permissions, receivers and icon; the iOS notification delegate, background registrants and the BGTask identifier.
- 126 tests (667 in total); thirteen mutation checks.

### Fixed
- At the largest text sizes, a switch's title broke mid-word beside its icon: switch tiles drop their icons at large text (conventions §11.68).

## [0.5.0] — 2026-10-21 — Phase 5: Achievements, Analytics + Search

### Added
- **Ten badges** as rules over the history, each with its progress, unlocked once with its date, and celebrated with a SnackBar on any screen (an app-wide watcher, settled so the demo's badges celebrate together).
- **Analytics:** the 30-day rate, the consistency score (the last week counted twice), weekly and monthly bars, streak history, the most successful habit, categories; a written summary for every chart.
- **Search:** a debounced, restartable `SearchBloc` over habits, routines, goals and badges (escaped `LIKE`), with recent searches.
- 59 tests (541 in total); ten mutation checks.

### Fixed
- stream_transform's `debounce` kept its timer after a cancel: the app uses `Stream.settled` (conventions §11.63).

## [0.4.0] — 2026-10-20 — Phase 4: Goals + Routines

### Added
- **Goals** for a day, an ISO week or a month, on all habits or one, counted from the history; a goal sheet.
- **Routines:** ordered steps checked off each day; an editor with drag to reorder and screen-reader move actions, saved in one transaction.
- Both on Today.
- 84 tests (482 in total); eight mutation checks.

## [0.3.0] — 2026-10-20 — Phase 3: Habits Core

### Added
- **The schedule engine:** due days for every schedule (weekly habits by their slots), streaks in days or weeks, perfect days, the completion rate.
- **Today** (the ring, the perfect-day streak, the week strip; complete, +1, skip, undo), **Habits** (search, categories, archived), **the habit form** (frequency, weekdays, target, start date, reminder, color, icon, validation, a discard guard) and **Habit detail** (a calendar heatmap you can backfill, stats, a weekly chart, archive, delete).
- 174 tests (398 in total); nine mutation checks.

### Fixed
- Cancelling a screen left its midnight timer running: the clock goes first in `combineLatest` (§11.61).
- The heatmap's days were buttons nothing could press: `Semantics` gets its own `onTap` (§11.62).

## [0.2.0] — 2026-10-20 — Phase 2: Data Layer

### Added
- **drift v1:** seven tables with `CHECK`s, composite keys, cascades and indexes; the exported schema; shared across isolates.
- **The fake service** and a demo anchored to ISO weeks, validated before it's written in one transaction.
- **Welcome:** explore with the demo (with an error and Try again) or start empty; the saved onboarding flag.
- 103 tests (224 in total); six mutation checks.

### Fixed
- drift's text dates sort only to the millisecond: reads break ties by id (§11.60).

## [0.1.0] — 2026-10-19 — Phase 1: Foundation

### Added
- The FVM-pinned project, strict lints, CI, the MIT license.
- The design system base (themes from a green seed, contrast-tested status and habit colors, state views), typed routes with a first-launch gate, five tabs plus a navigation drawer, placeholder screens, and an accessibility tour.
- 121 tests.
