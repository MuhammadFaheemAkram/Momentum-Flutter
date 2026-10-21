# Testing

```bash
fvm flutter analyze                                   # no issues allowed
fvm dart format --output=none --set-exit-if-changed .
fvm flutter test                                      # 667 tests, about 35 s
```

CI (`.github/workflows/flutter-ci.yml`) runs the same commands on every push to `main` and every pull request, on the Flutter version pinned in `.fvmrc`. It also regenerates the code and fails if a committed file is stale or a generated one was never committed.

## What is covered

Counted from `fvm flutter test --reporter json`, grouped by folder:

| Area | Tests | Highlights |
|---|---:|---|
| The habit engine and the planner (`domain/calculation`) | 134 | `isDue` for every schedule (start dates, archived, weekday sets, **a weekly habit's slots used by done and skipped days**, a part week); **streaks** (weekdays across days off, skips, **today pending**, weeks for N× a week, this week under way, gaps, month and year ends); perfect days; the completion rate and **the consistency score** (its weights and its minimum); goal windows (ISO weeks across months) and progress; today's routines; **every badge rule at its edge** (6 vs 7 days, 99 vs 100, a score of 79 vs 80, a week of skips is no comeback); the analytics series; validation; **the notification planner** (done or skipped today, a met week, weekdays, the horizon, the 60 cap, past times and midnight, wall-clock times across a DST change, stable ids, payloads) |
| Cubits, the Bloc and views (`features/`) | 140 | every screen's Cubit on the **real** data stack (Today's live figures and **coming-up reminders moving on by themselves**, the habit form, the heatmap's backfill, the routine editor's reorder, goals, badges, analytics, **Settings' permission flow, backup, reset and developer tools**); `SearchBloc` (the debounce in fake time, switching in real time); each view with mocked Cubits (large-text layouts, reorder semantics actions, the denied card, the plan sheet) |
| Accessibility tour | 68 | every screen and key state (with the demo, empty, errors, sheets, Settings with notifications on and denied), light and dark, at 200 % text: no overflow, tap targets ≥ 48 × 48, every tappable labelled, text contrast; the tab labels at 300 % |
| Design system | 68 | the themes, **WCAG AA contrast of every status color and all eight habit colors** in both themes, labels and dates, the cards, the heatmap, the large-text rule |
| Data (`data/`) | 57 | the demo mapper (every rule, **as of every weekday**), the shipped demo itself, **a round trip of every field through the database and through the backup JSON**, the repositories, **settings: every field saved, only what changed written, reloaded from "another isolate"** |
| Use cases (`domain/usecase`) | 45 | the day rules (no future days, 30 days back, not while archived), +1 / skip / undo / backfill / "Mark done", routines and goals, badges recorded once, **the sync's diff against a fake scheduler** (cancel stale, schedule new, keep unchanged, permission revoked, one at a time), backups (due a day after the last; failures reported), reset |
| Database (`core/database`) | 39 | the schema's `CHECK`s, keys and cascades; the DAOs: a log per habit per day, +1 adding, a routine saved in one transaction (and its rollback), check-offs following their step, a badge recorded once, `LIKE` with `%` and `_` literal, **reset** |
| App-level flows (`app/`) | 33 | the real app on the real DI graph: first launch (demo, empty, offline and Try again), create → due → complete → the ring and streak, skip, backfill, archive and Undo, delete; routines and goals; a badge celebrated where you are, the demo's celebrated together; search; **a notification tap opening its habit (cold and warm), "Mark done", notifications on / denied / revoked while away, Dark app-wide, the default reminder, back up, reset, run the background tasks, the plan**, About |
| Navigation | 33 | every rule of the first-launch gate, typed locations, the tabs and the drawer over every tab, screens above the shell and Back, deep links with a Close button, an unknown location |
| Domain models | 25 | `CalendarDate` (ISO weeks, months, leap days), `TimeOfDayValue`, the freezed models' rules |
| Background (`background/`) | 15 | **`RunBackgroundTasks`** (badges, a backup only when due, the plan; a failing step stops nothing), **the entry points' dispatch** (the maintenance task, iOS's fetch, an unknown task, a graph that fails to open), "Mark done" in the background, parsing taps and actions |
| Common and network | 9 | the midnight clock, `Stream.settled` cancelling its timer, the fake service's delay and failure |
| DI | 1 | the real container resolves every Cubit, the Bloc, repository, DAO and service |
| **Total** | **667** | |

## How the tests are built

- **The real data stack.** `DataStack` (`test/helpers/`) wires the real repositories and use cases to an in-memory database, the real fake service (zero latency, reading the bundled JSON), a fixed `Clock` (`demoNow`: **Wednesday 21 October 2026, 15:00**), a seeded `IdGenerator`, a `FakeSettingsRepository`, a `FakeRecentSearchesRepository` and a `FakeNotificationScheduler`. Cubit and use-case tests run on it, so they exercise the real SQL.
- **The real app.** `pumpMomentum` builds the real composition root with only these swaps: an in-memory database, a zero-latency network, a fixed clock, in-memory preferences (plus any given), a fake notification scheduler (which also plays taps and "Mark done"), no background registration, a mocked dynamic color channel and `PackageInfo` values. Pair it with `tearDown(getIt.reset)`.
- **Builders and fixtures.** `habit_builders.dart` (`habit()`, `done()`, `skip()`, `doneEvery()`, `oct(21)`) for the engine; `fullUserData()`, which uses every field and every case of every sealed type, for round trips.
- **Figures worked out by hand.** The demo as of `demoNow` (9 perfect days, Read 20 pages at 19 days, a consistency score of 89, 10 of 25 this week…) is worked through in [HABIT_ENGINE.md](HABIT_ENGINE.md).
- **Fakes over mocks.** Fakes behave like the real thing (their streams emit the current value, then every change; the scheduler keeps pending notifications and logs every call). Mocks (`mocktail`, `MockCubit` / `MockBloc`) appear only in view tests.
- **Background entry points take their graph as a function**, so `dispatchBackgroundTask` and `handleNotificationAction` run on the in-memory stack.
- **Bounded waits.** `waitFor(bloc, predicate)` times out; `pumpUntilFound` settles real-loop work in slices and fails after 20. App-wide watchers (badges, notifications) settle 300 ms of fake time, then do database work in real time: tests move both.
- **Accessibility.** The tour runs on a phone-width but very tall surface, so every list item is built and checked with `meetsGuideline(androidTapTargetGuideline / labeledTapTargetGuideline / textContrastGuideline)`; any layout overflow fails the test.

## Proving the tests can fail

Each of these was checked by breaking the code on purpose (a mutation check), running the tests, then restoring it. **53 in all, each caught.**

| Phase | Broken on purpose |
|:---:|---|
| 2 | the log's skip-or-count `CHECK` removed · the demo written without its transaction · +1 setting the count to 1 · the first launch ending after a failed demo · demo days counted back from today instead of by week · the weekday bitmask off by one |
| 3 | a weekly habit due one day past its slots · a skipped day breaking a streak · today, pending, breaking a streak · this week, under way, breaking a weekly streak · a weekly habit spoiling a perfect day · the rate counting today before it's done · backfill reaching 31 days back · the calendar day's tap left off its semantics node · the clock as `combineLatest`'s `other` |
| 4 | partial days counting toward a goal · weeks starting on Sunday · a routine saved without its transaction · a save deleting and re-adding every step · a goal update as an upsert from its row · any day's check-offs counting today · a move one place off · the drawer's large-text width removed |
| 5 | the 7-day badge at 6 · a weekly habit's weeks counted as days · a half-checked morning · a week of skips as a comeback · unlocks decided by today's progress · the score without its double week · a score from one habit-day · unescaped `LIKE` wildcards · the watcher without its debounce · a debounce keeping its timer |
| 6 | a habit done today still reminded · past times kept · no cap · every notification rescheduled on every sync · stale notifications never cancelled · a revoked permission ignored · every setting rewritten on any change · a backup due a minute late · "Coming up" not filtered by the time · any background task name run · "Mark done" lowering a count · a tap replacing the screen stack · switch icons kept at large text |
| 7 | see below |

Phase 7's checks, of key behaviours not yet proven, with how many tests each broke:

| Broken on purpose | Tests that failed |
|---|---:|
| "Done" needs more than the daily target (`>` for `≥`) | 103 |
| `PRAGMA foreign_keys` not turned on (no cascades) | 14 |
| A habit due before its start date | 13 |
| The first-launch gate lets everyone through | 9 |
| An archived habit stays due | 3 |
| Reset progress keeps the badges | 2 |
| A backup drops `archivedAt` | 1 (every field's round trip) |

Tests also found real bugs while they were written: drift's text dates sorted only to the millisecond (§11.60), cancelling a screen left its midnight timer running (§11.61), the heatmap's days were buttons nothing could press (§11.62), stream_transform's debounce left a timer behind (§11.63), and a burst of writes celebrated each badge on its own until the watcher waited for them to settle.

## Gotchas worth knowing

- **A plugin call while the DI graph is built hangs every app-level test:** mock its channel in `configureTestDependencies` (conventions §11.58); here the dynamic color channel and `PackageInfo`.
- **Async work before the first pump waits on fake time:** load the demo inside `tester.runAsync` (§11.44); flows that alternate fake delays and database work need `pumpUntilFound` (§11.54).
- **`firstValue`, not `first`, on drift streams in widget tests:** `first` waits for a cancel that never finishes under fake async (§11.27).
- **The clock goes first in `combineLatest`**, or cancelling a screen leaves its midnight timer (§11.61).
- **Switching streams** (`restartable`) is tested in real time; only the debounce's timing goes in fake time (§11.29).
- **A lazy list builds only what's near the screen:** `useTallPhoneSurface()` / `pumpMomentum(tall: true)`.
- **The test font's glyphs are em squares,** so it can't show where a real font breaks a line: pin the large-text rule, and check on a device (§11.68).
- **App lifecycle in tests** must walk the real sequence (inactive, hidden, paused and back), or `AppLifecycleListener` asserts.
- **`MultiStreamController` delivers asynchronously:** wait for a Cubit's state (`waitFor`) rather than reading it right after a write.

These, and more, are recorded as verified traps in the shared Flutter conventions (`00-CONVENTIONS.md` §11).
