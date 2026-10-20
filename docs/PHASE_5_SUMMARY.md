# Phase 5 — Achievements, Analytics and Search

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 5, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 5 reads the history back to the user:
- **badges**: ten rules over the history; each badge is unlocked once, with its date, and celebrated wherever the user is when it's earned;
- **analytics**: the completion rate, a consistency score, weekly and monthly bars, the longest streaks, the most successful habit, the categories, every chart with a written summary;
- **search**: habits, routines (and their steps), goals and badges, debounced, live, with recent searches.

---

## 🧱 What Was Implemented

- **The badge engine (`domain/calculation/achievements.dart`, pure Dart):**
  - `AchievementId`, ten badges, each with its title and description. Like this project's other enums, the words live on the enum, so search can match them in the domain;
  - `achievementProgress(id, input)`: a rule per badge, returning `current` of `target` and what it counts. The ten rules:
    - **First step:** 1 completion.
    - **7-day and 30-day streak:** the longest run of a habit counted in days. A weekly habit counts in weeks, so it never earns these.
    - **Perfect week:** 7 perfect days in a row.
    - **Century:** 100 completions.
    - **Early bird:** a morning routine with every step checked off, on 5 days.
    - **Habit builder:** 5 habits that aren't archived.
    - **Consistency master:** a score of 80, once there are 30 days of history. Until then, the progress shows the history so far.
    - **Comeback:** a habit done again after 8 or more days, with a due day missed in between. A week of skips isn't "away".
    - **All rounder:** completions in 5 categories.
  - `achievementStatuses` (each badge's progress and unlock) and `newlyEarned` (met now, not yet unlocked).
- **Sticky unlocks:**
  - `AchievementsDao.recordUnlocks` reads what's unlocked and inserts the rest in one transaction, and returns only what it recorded;
  - an unlock never changes, and stays when the progress that earned it is gone.
- **"After every write", in one place:**
  - `WatchNewAchievementsUseCase` watches the history while the app runs. After a burst of writes settles, it runs the rules, records what's new, and emits it;
  - `MomentumApp` shows "Badge unlocked: 7-day streak" (or "8 badges unlocked") with View, through the app's `ScaffoldMessenger`, on whatever screen is showing;
  - `EvaluateAchievementsUseCase` does the same once, for the background tasks of Phase 6.
- **Analytics (`domain/calculation/analytics.dart`):**
  - **`consistencyScore`:** the completion rate of the last 30 days, with the last 7 counted twice, from 0 to 100. It's `null` until 7 habit-days have been asked for. It follows the rate's own rules: skips and days off left out, today only once done.
  - **`buildAnalytics`:**
    - the 30-day rate and the score;
    - the best current streak;
    - completions, and perfect days this month;
    - 8 weekly and 6 monthly counts;
    - each habit's longest run, sorted with a week counted as seven days;
    - the most successful habit: the best rate since its start, among habits with at least 7 days asked;
    - category shares.
  - Archived habits' history counts in every figure but the current streak.
- **Search:**
  - `SearchDao` uses `LIKE` with `%`, `_` and `\` escaped, so "100%" finds "100%". It matches habits by name or description, routines by name or by one of their steps, and goals by name;
  - badges are matched in the use case;
  - recent searches live in preferences (five, latest first, once each).
- **Screens:**
  - **Achievements:**
    - "8 of 10 unlocked";
    - unlocked badges first (filled icon, "Unlocked today"), then the locked ones closest to being earned (the rule, a bar, "Locked · 5 of 7 days");
    - two columns, or one at large text.
  - **Analytics:** five figure tiles, two bar charts, Most successful, Longest streaks, By category, and an empty state.
  - **Search:**
    - the field, recent searches (with Clear) while it has under 2 characters;
    - results grouped by Habits, Routines, Goals and Badges, with a count announced to screen readers;
    - each result opens its screen.
- **`Stream.settled`**: a debounce whose cancel also cancels its timer (see the trap below).
- **Tests:** 541 (59 new), and ten mutation checks (below).

### Differences from the plan

- **Badges are evaluated by a watcher, not by each write.** The spec says "recorded by `EvaluateAchievements` after every write". Calling it from every write use case would scatter the rule across ten places, and one would be forgotten. Instead, the database announces every change, and one watcher re-runs the rules. `EvaluateAchievements` still exists for the background tasks.
- **The demo's badges are celebrated together.** Loading the demo writes table after table. The watcher waits 300 ms for the writes to settle, so the user sees "8 badges unlocked", not eight messages replacing each other. A flow from Welcome guards it.
- **Unlocks are dated the day they're recorded.** The demo's badges read "Unlocked today", rather than a date reconstructed from its history.
- **"Productivity Master"** (Android's name) is **Consistency master**, as in iOS, with a defined rule: a score of 80 and 30 days of history.

### Mutation checks

Each was broken on purpose, tested, then restored:

| Broken on purpose | Caught by |
|---|---|
| The 7-day streak badge at 6 | "7-day and 30-day streaks: at 7 and 30, not at 6 and 29" |
| A weekly habit's weeks counted as days | "a weekly habit counts in weeks, never as a day streak" |
| A morning with one step checked counts | "Early bird: a day with a step left … does not count" |
| A week of skips counts as a comeback | "a week of skips is not away" |
| Unlocks decided by today's progress (not sticky) | "a badge earned and not unlocked is new; unlocked, it is not" |
| The last week not counted twice | "the consistency score: the last 7 days count twice" |
| A score from one habit-day | "none with fewer than 7 habit-days asked" |
| `LIKE` wildcards unescaped | "% and _ are plain characters, not wildcards" |
| The watcher without its debounce | "the demo, loaded from Welcome … celebrated together" |
| The debounce keeps its timer on cancel | its own test, and every app-level widget test |

The debounce check first survived: the demo flow loaded its data before the app started, so the badges arrived in one batch anyway. The test now loads the demo from Welcome, while the app runs, and the check fails it.

### A trap found on the way

**stream_transform's `debounce` keeps its timer after a cancel** (conventions §11.63).
- It's built without a cancel handler, so cancelling the subscription leaves the pending `Timer` to fire once into nothing.
- That's harmless in the app, but the app-wide badge watcher made every widget test fail with "A Timer is still pending even after the widget tree was disposed".
- `Stream.settled` is the fix: a debounce on `Stream.multi` whose `onCancel` cancels the timer, with a fake-time test.

A reminder from DevJourney held too (§11.29): the SearchBloc's switch to a newer query waits on a real cancel. So the debounce is tested in fake time, and the switching in real time.

---

## 💙 Flutter / Dart Concepts Demonstrated

- **Rules as pure functions with a shared input:** `AchievementInput` computes completions and the longest day streak once (`late final`), and each rule is a `switch` case that can be tested at its edge.
- **Derived vs stored, on purpose:** everything is derived, except an unlock, which is a moment. "Unlocked 12 Oct" must stay true after the streak breaks.
- **Reactive side effects:** a use case that turns "the data changed" into "these badges were just earned" (`watch` → `settled` → `asyncMap` → `where`). `asyncMap` runs one evaluation at a time.
- **App-wide UI from a service:** a `GlobalKey<ScaffoldMessengerState>` on `MaterialApp.router` shows the celebration over any route, and a SnackBar action navigates through the router.
- **A Bloc for a stream of events:** `debounceRestartable` = `switchMap` to a delayed event (the debounce) + `restartable` (a newer query cancels the older one's live results).
- **Escaping user text for `LIKE`:** the pattern is a bound parameter, with its wildcards escaped, never SQL.
- **Charts that read:** every chart is excluded from semantics and replaced by a written summary ("Last 8 weeks: 183 completions. Most: the week of 12 Oct, 31.").

---

## 🔁 Data Flow (this phase)

```
habits · logs · routines · check-offs · unlocks · clock
  └─ combineLatest ─▶ (AchievementInput, unlocks)
       ├─▶ WatchAchievements ─▶ achievementStatuses ─▶ Achievements tab
       └─▶ WatchNewAchievements: settled(300 ms) ─▶ newlyEarned ─▶ recordUnlocks (one transaction)
                                  └─▶ recorded? ─▶ MomentumApp ─▶ SnackBar "Badge unlocked: …" · View

habits · logs · clock ─▶ buildAnalytics ─▶ Analytics tab

field ─▶ SearchQueryChanged ─▶ debounceRestartable ─▶ WatchSearchResults(query)
           SearchDao (escaped LIKE: habits, routines and steps, goals) + badges by title ─▶ live results
         result opened ─▶ SaveRecentSearch ─▶ preferences
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `lib/domain/calculation/{achievements,analytics}.dart` | The badge rules; the score and the analytics. |
| `lib/domain/model/{achievement,analytics,search}.dart` | Badges, their progress and status; the analytics overview; search results. |
| `lib/core/database/daos/{achievements_dao,search_dao}.dart` | Unlocks recorded once; escaped `LIKE` search. |
| `lib/core/common/settled_stream.dart` | A debounce that cancels its timer. |
| `lib/domain/usecase/{achievement_use_cases,analytics_search_use_cases}.dart` | The badge sources, watch, evaluate and watch-new; analytics; search and recent searches. |
| `lib/features/{achievements,analytics,search}/**` | The three screens; the SearchBloc and its transformer. |
| `lib/core/design_system/widgets/{achievement_badge,count_bars_chart}.dart` | The badge tile; bars with a summary. |
| `lib/app/momentum_app.dart` | The celebrations. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `AchievementId`, `AchievementProgress`, `AchievementStatus` | enum / freezed | The badges, their progress, their state | `domain/model` |
| `AchievementInput` | class | Everything the rules read, computed once | `domain/calculation` |
| `AnalyticsOverview`, `PeriodCount`, `CategoryShare`, … | freezed | The Analytics tab | `domain/model` |
| `SearchResults` | freezed | What a search found, by kind | `domain/model` |
| `AchievementSources`, `WatchNewAchievementsUseCase`, `EvaluateAchievementsUseCase` | use cases | The badges' data; recording what's earned | `domain/usecase` |
| `SearchBloc` | Bloc | Debounced, restartable, live search | `features/search/bloc` |
| `AchievementsCubit`, `AnalyticsCubit` | Cubits | The two tabs | `features/*/cubit` |

---

## 🌱 Folder Structure Changes

- **New:** `lib/features/{achievements,analytics}/cubit`, `lib/features/search/bloc`; tests mirroring them, plus `test/helpers/fakes/fake_recent_searches_repository.dart`.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Scope | achievement engine, analytics, reports, consistency score, tests | achievement engine + unlock rules; Swift Charts analytics; tests | the same, plus search (scheduled here: neither native spec schedules it) |
| Badges | 7 / 30-day streak, first habit, 100 completions, "Productivity Master" | 7 / 30-day streak, first completed, 100 completions, consistency master | ten, each a pure rule with progress; Consistency master defined (score 80, 30 days) |
| Unlocks | an `unlocked` flag | an `unlocked` flag | a row per badge, recorded once with its date; never un-earned |
| Evaluation | — | — | after every change, by one watcher (debounced); once, for background tasks |
| Consistency score | unspecified | unspecified | the 30-day rate, the last 7 days counted twice, none before 7 habit-days |
| Analytics | rate, streak history, weekly and monthly progress, most successful habit | Swift Charts | the same, plus categories and perfect days, each chart with a written summary |
| Search | Flow debounce | debounced | a `SearchBloc` (debounce + restartable) over escaped `LIKE`, live, with recent searches |

Both native editions keep an `unlocked` flag that something must remember to set. Here the rules are code, the watcher applies them to every change, and only the unlock itself is stored.

---

## 🎤 Interview Notes

**Q: Why store badge unlocks when everything else is derived?**
A: Because an unlock is an event, not a state. "7-day streak, unlocked 12 Oct" stays true after the streak breaks. Deriving it would make the badge vanish with the streak. So the rules are code, and each unlock is one row, inserted once, in a transaction that checks what's already there.

**Q: How do badges get evaluated "after every write" without every write calling it?**
A: The database announces every change: drift streams. One use case watches the history, waits for a burst of writes to settle, runs the rules, and records what's newly earned. A new write path can't forget to evaluate, and the celebration shows wherever the user is, through a `ScaffoldMessenger` key at the app root.

**Q: How is your consistency score defined?**
A: The completion rate of the last 30 days, with the last 7 days counted twice, from 0 to 100. It uses the rate's own rules, so the two never disagree. It's not shown until 7 habit-days have been asked for. A test pins the weights by hand: 6 recent days done out of 29 scores 34, not the plain 21 %.

**Q: What did a mutation check teach you this phase?**
A: Removing the watcher's debounce went unnoticed: my demo test loaded the data before the app started, so the badges arrived in one batch anyway. The real case is loading the demo from Welcome while the app runs. The test does that now, and the mutation fails it.

---

## 📝 Learning Checklist

- ✅ Write badge rules as pure functions, each tested at its edge
- ✅ Store only the moment of an unlock, once, in a transaction
- ✅ Run a side effect after every change from one watcher, debounced
- ✅ Show app-wide messages through a `ScaffoldMessenger` key
- ✅ Weight a score toward recent days, with a minimum before it means anything
- ✅ Search with escaped `LIKE` and a debounced, restartable Bloc
- ✅ Write a debounce that cancels its timer
- ⬜ Notifications, background tasks and settings (Phase 6)

---

## 🚀 Future Improvements

- **Phase 6:** the background tasks run `EvaluateAchievements`, so a badge earned from a notification's "Mark done" is recorded with the app closed; Reset progress clears unlocks.
- **Later:** badges with levels (7, 30, 100 days), and an analytics range picker.
