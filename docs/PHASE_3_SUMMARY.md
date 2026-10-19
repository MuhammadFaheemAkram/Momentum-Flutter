# Phase 3 — Habits Core

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 3, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 3 makes habits real:
- a **schedule-aware habit engine**: what's due, streaks, perfect days and the completion rate, as pure functions over the logs;
- **Today**: the ring, the perfect-day streak, this week, and today's habits with complete, +1, skip and undo;
- **Habits**: every habit, searchable, by category, archived ones on request;
- the **habit form**: frequency, weekdays, times a week, daily target, start date, reminder, color and icon, with validation and a discard guard;
- **Habit detail**: the figures, a calendar of the last twelve weeks you can backfill, and a weekly chart.

---

## 🧱 What Was Implemented

- **The engine (`domain/calculation/`, pure Dart):**
  - `HabitHistory`: one habit and its logs. It answers `isDue`, `isDoneOn`, `stateOn` (done, partly done, skipped, missed, to do, nothing due, still to come), `weekOutcome` and `canSetDay`;
  - `habitStreak` (current and longest, in days or weeks), `perfectDayStreak` and the week strip, `completionRate`;
  - `buildTodayOverview`, `buildHabitList`, `buildHabitDetail`: what each screen shows, as read models (`HabitToday`, `TodayOverview`, `HabitDetail`);
  - `validation.dart`: the form's rules, shared with the use cases (lengths in characters as people count them).
- **The rules, in one place:**
  - *Fixed days* (daily, on weekdays) are judged per day. A due day not done breaks the streak. Days not due and skipped days pass over it, and today counts once done but never breaks it.
  - *Times a week* is judged per ISO week. The week has N slots (fewer in a week the habit starts part-way through), and a done or a skipped day uses one. The habit is due each day until the slots are used. The streak counts weeks that met their target, and a weekly habit's empty day is never a "miss".
  - *A perfect day*: nothing due was missed, and something was done.
  - *The rate*: done ÷ (due − skipped). Today and this week count only once done.
  - *Backfill*: any day from the habit's start, up to 30 days back, never ahead, not while archived.
- **Data:** `HabitsDao` (an update is an `UPDATE`, never a `REPLACE` that would cascade the history away), `HabitLogsDao.putLog`, `HabitRepository` and `HabitLogRepository` (every write through `guardWrite`), `IdGenerator`.
- **Use cases:**
  - one per action: save, archive, delete, add a check-in, skip, clear, set a day (backfill), restore a day (Undo);
  - each checks the day's rules first, so a stale screen or a link can't log an archived habit or a future day;
  - three live views (`WatchToday`, `WatchHabits`, `WatchHabitDetail`) combine habits, logs and a `CalendarClock` that emits again at midnight.
- **Screens:**
  - **Today:**
    - a ring (done ÷ due, skips left out), the perfect-day banner and the week strip;
    - due habits (open, then done, then skipped), and "Not due today" folded away;
    - an empty state with New habit.
  - **Habits:** a search field, category chips, a Show archived switch, and each card's menu (skip, undo, archive or unarchive, open).
  - **The habit form:** a full-screen dialog with Save, errors after a first Save, the discard guard, Delete (confirmed), and the adaptive time picker (Material dialog, iOS wheel).
  - **Habit detail:** the habit, four stat tiles, the calendar heatmap with a written summary and a legend, an 8-week chart with "5/7" over each bar, and Edit, Archive or Unarchive, Delete.
- **Shared widgets:** `HabitCard` (its buttons move under the text at large text), `HabitAvatar`, `CompletionRing`, `StreakBanner`, `WeekStrip`, `CalendarHeatmap`, `WeeklyBarsChart`, `StatTile`, `CountStepper`, `WeekdayPicker`, `HabitColorPicker`, `HabitIconPicker`, and from DevJourney `ConfirmDialog`, `AppSearchField`, `FilterChipGroup`, `SegmentedChoice`, `showAppSheet`, `ChartAxisLabel`.
- **Tests:** 398 (174 new), and nine more mutation checks (below).

### Differences from the plan

- **Archive and Delete in Habit detail, Delete in the form.** The spec put both in both places. Archiving is an action on the habit, not an edit, so the form keeps only Delete. If the form deletes the habit, the detail page underneath leaves too.
- **Completing a habit on a day it isn't due is allowed** (an extra run on a Tuesday). It shows as done on that day and is neutral for the streak and the rate. Only a habit that hasn't started, or is archived, refuses.
- **The calendar heatmap is built from widgets, not a `CustomPainter`.** Each day must be its own screen-reader node ("Fri, 16 Oct: Missed"), and a button of at least 48 points when it can be backfilled. A painter would need all of that rebuilt by hand. Seven columns of 51 points fit a phone; the dates grow with the text setting up to 130 %.
- **No `bloc_concurrency` yet.** The Habits search filters a few dozen habits in memory, so it needs no debounce. The debounced, restartable `SearchBloc` comes in Phase 5.
- **Today's "upcoming reminders" and routines and goals** arrive with Phases 4 and 6.

### Mutation checks

Each was broken on purpose, tested, then restored:

| Broken on purpose | Caught by |
|---|---|
| A weekly habit due one day past its slots (`<` → `<=`) | the Today ordering test |
| A skipped day breaks a streak | "a skipped day neither breaks nor extends it" |
| Today, still pending, breaks a streak | six streak tests |
| This week, under way, breaks a weekly streak | "this week, still under way, neither counts nor breaks it" |
| A weekly habit not done spoils a perfect day | "a weekly habit not done that day does not spoil it" |
| The rate counts today before it's done | the habit page's figures |
| Backfill reaches 31 days back | "canSetDay … up to 30 days back" |
| The calendar day's tap left off its semantics node | "the last 30 days are buttons that toggle" |
| The clock as `combineLatest`'s `other` | "cancelling a view stops its midnight timer" |

### Three traps found on the way

- **`combineLatest` on a broadcast source never cancels a single-subscription `other`** (conventions §11.61).
  - drift's query streams are broadcast. stream_transform turns the clock (`other`) into `asBroadcastStream()`, which never cancels its own subscription.
  - So Today's midnight timer outlived the screen. Every widget test failed with "A Timer is still pending even after the widget tree was disposed".
  - The clock is now the source in every combination, and a fake-time test cancels each view and expects no timer.
- **`Semantics(excludeSemantics: true)` over an `InkWell` drops its tap** (§11.62).
  - The calendar's days and the color swatches were announced as buttons that a screen reader couldn't press.
  - The tour didn't notice, because its tap-target checks only look at nodes that have a tap action.
  - The `Semantics` nodes now carry their own `onTap`, and tests check `hasTapAction`.
- **A heading flag spreads over a merged node.**
  - Today's date (`Semantics(header: true)`) merged into its list item, so the ring, the summary and the week strip were all announced as one heading.
  - Every heading is now its own node (`container: true`), and a view test checks the date alone is the heading.

---

## 💙 Flutter / Dart Concepts Demonstrated

- **Pure functions over plain models:** the engine has no Flutter, no database and no clock of its own. Every rule is a unit test over a few logs, at an exact date.
- **Exhaustive `switch` over sealed types:** each calculation handles `Daily`, `OnWeekdays` and `TimesPerWeek`. Adding a schedule would be a compile error everywhere it's not handled.
- **Read models:** `HabitToday`, `TodayOverview`, `HabitDetail` are built for their screens from the history. Nothing derived is stored.
- **Combining streams:** `combineLatest` merges the clock, the habits and the logs. drift re-runs a query when its table changes, so one check-in updates every open screen.
- **A clock that ticks at midnight:** `Stream.multi` with a `Timer` to the next local midnight, cancelled with the subscription.
- **Optimistic UX without optimistic writes:** the write is local and fast, so the screens simply follow the database. Undo puts the previous log back (`RestoreHabitDayUseCase`).
- **Forms:** a Cubit holds the values and the original, so the discard guard is `values != original`. Each schedule keeps its own choice, so switching back and forth isn't a change. `PopScope` guards Back and the gesture.
- **Adaptive widgets:** `SwitchListTile.adaptive`, `AlertDialog.adaptive` with `CupertinoDialogAction`, a Material time dialog or an iOS wheel, `CircularProgressIndicator.adaptive`.
- **Large text:** `prefersStackedLayout` stacks the ring, the stat tiles and the cards' buttons; the calendar's dates clamp at 130 %; chart labels at 150 %.
- **Semantics:**
  - one merged button per card, with its own action buttons beside it;
  - a node per calendar day with an `onTapHint` ("mark done");
  - live regions on the steppers;
  - written summaries for the chart, the calendar and the week strip.

---

## 🔁 Data Flow (this phase)

```
CalendarClock.watchToday() ──┐   (today, then each midnight)
HabitsDao.watchAll() ────────┼─ combineLatest ─▶ buildTodayOverview ─▶ TodayCubit ─▶ TodayView
HabitLogsDao.watchAll() ─────┘

Tap ✓ ─▶ TodayCubit.checkIn ─▶ HabitDayActions ─▶ AddCheckInUseCase
           checkHabitDay (exists, not archived, started, not ahead, ≤ 30 days back)
           HabitLogsDao.addCheckIn: INSERT … ON CONFLICT DO UPDATE count = count + 1
         ─▶ drift re-runs the logs query ─▶ every open screen rebuilds its overview

Skip ─▶ notice "Skipped … today" + Undo ─▶ RestoreHabitDayUseCase(previous log)
Calendar day ─▶ HabitDetailCubit.toggleDay ─▶ SetHabitDayUseCase(done: count = daily target, or no log)
Form Save ─▶ habitDraftError? ─▶ SaveHabitUseCase ─▶ HabitRepository.create / update (UPDATE, never REPLACE)
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `lib/domain/calculation/{habit_history,streaks,perfect_days,completion_rate,overviews,validation}.dart` | The engine and the rules. |
| `lib/domain/model/{habit_draft,habit_overviews}.dart` | What the form saves; what the screens show. |
| `lib/core/database/daos/habits_dao.dart` | Habits: list, one, create, update, archive, delete. |
| `lib/core/common/{calendar_clock,guard_write,id_generator,first_value}.dart` | Today and midnight; writes as `Result`s; ids. |
| `lib/data/repository/{habit_repository_impl,habit_log_repository_impl}.dart` | Habits and their history. |
| `lib/domain/usecase/{habit_use_cases,habit_day_use_cases,habit_day_rules,watch_habit_use_cases}.dart` | One use case per action, and the live views. |
| `lib/features/{today,habits,habit_form,habit_detail,habit_actions}/**` | The four screens and their shared actions. |
| `lib/core/design_system/widgets/*` | The habit widgets, pickers, heatmap and chart. |
| `test/helpers/{habit_builders,overview_fixtures,wait_for}.dart` | Short builders for the engine; real read models for views. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `HabitHistory`, `DayState`, `WeekOutcome` | class / enum / value | A habit's days, as the engine sees them | `domain/calculation`: pure Dart |
| `HabitStreak`, `CompletionRate`, `DayDot` | values / enum | The figures | `domain/calculation` |
| `HabitToday`, `TodayOverview`, `HabitDetail`, `HeatmapDay`, `WeekBar` | freezed read models | What each screen shows | `domain/model` |
| `HabitDraft` | freezed | What the form saves | `domain/model` |
| `CalendarClock` | injectable | Today, and a new day at midnight | `core/common` |
| `HabitDayActions`, `HabitNotice` | class | Today's actions and their Undo, shared by two screens | `features/habit_actions` |
| `TodayCubit`, `HabitsCubit`, `HabitFormCubit`, `HabitDetailCubit` | Cubits | The four screens | `features/*/cubit` |

---

## 🌱 Folder Structure Changes

- **New:** `lib/domain/calculation/`, `lib/features/habit_actions/`, the screens' `cubit/` folders, and many design-system widgets; tests mirroring them, plus `test/helpers/fakes` and the overview fixtures.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Scope | Habit CRUD, completion, Dashboard, Habit detail, streak calculations, tests | the same, plus quick-complete; use case and view model tests | the same, plus a schedule-aware engine and backfill |
| Streaks | "streak calculations" | current/longest, "tricky date logic" | per schedule: days for fixed days, ISO weeks for N× a week; skips and days off neutral; today pending never breaks it |
| Dashboard / Today | today's habits, completion percentage, streak | summary, today's habits, quick-complete | a ring (skips left out), perfect days, the week strip, due first and "Not due today" folded away |
| Habit form | date and time pickers, state hoisting | title, frequency, reminder, start date, goal count, color/icon, validation | the same, as a full-screen dialog; each schedule keeps its choice; errors after Save; discard guard; adaptive pickers |
| Habit detail | completion and streak history, statistics, edit, delete, archive | a calendar/heatmap, Swift Charts | a 12-week calendar you can backfill (30 days back), four figures, an 8-week chart, each with a written summary |
| Stored figures | `currentStreak`, `completionRate` on the habit | the same | none: derived from the logs on every read |
| Tests | tests | use case + view model tests | the engine's edge cases, the DAOs, the Cubits on a real in-memory database, views, app flows, the tour, mutation checks |

Both native specs store the streak and the rate on the habit. Here they're derived, so a backfilled day, a skip or an edited schedule changes them everywhere at once.

---

## 🎤 Interview Notes

**Q: How does a "3 times a week" habit work with streaks?**
A: It's judged per ISO week. Each week has three slots, and a done or skipped day uses one. The habit is due every day until they're used. The streak counts consecutive weeks that met their target, and this week counts once met but never breaks the streak while it's under way. A first week that starts on Saturday only asks for two.

**Q: Why aren't skips just "done"?**
A: A skip says "not today, on purpose": travelling, ill. Counting it as done would inflate streaks and rates; counting it as missed would punish honesty. So it's neutral: it neither breaks nor extends a streak, and it's left out of the rate.

**Q: How does Today stay right past midnight?**
A: The views combine the habits, the logs and a clock stream that emits today, then each new day at the next local midnight. The clock has to be the *source* of `combineLatest`. drift's streams are broadcast, and on a broadcast source stream_transform wraps the other stream in `asBroadcastStream()`, which never cancels. My first version leaked the timer, and every widget test caught it.

**Q: How do you make a calendar heatmap accessible?**
A: Each day is a semantics node with its date and state ("Fri, 16 Oct: Missed"). The days that can be backfilled are buttons, at least 48 points square, with a hint ("mark done"). There's a written summary above, and an icon in every cell besides its color. One bug: `excludeSemantics` had dropped the tap action, so the days were buttons nothing could press. A test now checks `hasTapAction`.

**Q: Why derive streaks instead of storing them?**
A: A stored streak is a second copy of the truth. A backfilled day, a skip, an edited schedule or a deleted log would each have to update it, and one missed path makes it wrong forever. Derived from the logs, it can't disagree, and the history is small enough to compute on every change.

---

## 📝 Learning Checklist

- ✅ Model schedules as a sealed union and judge each kind by its own unit (day or week)
- ✅ Derive streaks, perfect days and rates from logs, with skips and days off neutral
- ✅ Combine drift streams with a clock that ticks at midnight, and cancel it properly
- ✅ Build a form with a discard guard, deferred errors and adaptive pickers
- ✅ Make a calendar heatmap accessible: a node per day, buttons that really press
- ✅ Prove the engine's rules with mutation checks
- ⬜ Goals and routines (Phase 4)

---

## 🚀 Future Improvements

- **Phase 4:** goals counted from the same logs per window (today, ISO week, month), and routines with drag-to-reorder, both shown on Today.
- **Phase 5:** achievements from the same history, analytics (the consistency score), and search.
- **Phase 6:** reminders planned from `isDue` and today's logs: a habit done today gets no reminder left today.
