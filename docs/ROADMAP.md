# Roadmap

All seven build phases are complete. These are natural next steps, roughly in order of learning value.

## Done

- ✅ **Phase 1 — Foundation:** FVM toolchain, `material_ui`, the design system base with the habit palette, typed routes with a first-launch gate, five tabs and a navigation drawer, CI, an accessibility tour from day one.
- ✅ **Phase 2 — Data layer:** the drift store with its constraints, the fake service and a demo anchored to ISO weeks, Welcome.
- ✅ **Phase 3 — Habits core:** the schedule engine (due days, streaks, perfect days, rates), Today, Habits, the habit form, Habit detail with a calendar you can backfill.
- ✅ **Phase 4 — Goals and routines:** goals per day, ISO week or month; routines reordered by drag or screen reader, checked off each day.
- ✅ **Phase 5 — Achievements, analytics and search:** ten badge rules unlocked once and celebrated, the consistency score and charts, debounced search.
- ✅ **Phase 6 — Notifications, background tasks and settings:** reminders planned a week ahead and diffed, "Mark done", background work in a second isolate, Settings with dynamic color and backups.
- ✅ **Phase 7 — Documentation and CI:** the docs, screenshots and community files, and mutation checks of the key behaviours.

## Next ideas

- **Restore from a backup:** the DTO already reads back (`BackupDto.toUserData`); add a restore flow with a confirmation, through `UserDataDao.replaceAll`.
- **A real backend** behind `MomentumService`: accounts, backups kept server-side, and syncing habits across devices (conflict rules per log day).
- **Smarter notifications:** snooze ("remind me in an hour"), grouping a day's reminders on Android, and a reminder per habit at more than one time.
- **Habit notes and moods:** a short note on a day's log, shown on the heatmap.
- **Home-screen widgets:** today's ring and a quick check-in (`home_widget`), and an iOS Live Activity for a routine.
- **Health integration:** count steps or workouts toward a habit (Health Connect, HealthKit).
- **Adaptive layout:** a `NavigationRail` on tablets and in landscape, with Today and a habit's page side by side.
- **Localization:** `flutter_localizations` + `gen-l10n`, with first-day-of-week per locale (the engine uses ISO weeks today).
- **Export:** the history as CSV.
- **Integration tests** on devices (`integration_test`), including a notification firing and a background task; golden tests for the charts and the heatmap.
- **CI:** an iOS simulator build on a macOS runner, and coverage reporting.
- **A screen-reader pass on devices:** TalkBack and VoiceOver reading order. The tour checks labels, tap targets and contrast, but not the order.
