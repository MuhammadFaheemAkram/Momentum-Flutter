# The Habit Engine

Everything Momentum shows about your habits is **derived from the logs** when it's read: whether a habit is due, its streak, the perfect days, the rates, the consistency score, goal progress and badges. Nothing derived is stored, so nothing can disagree with the history, and editing a habit's schedule re-derives it all.

The engine is pure Dart in `lib/domain/calculation/`, tested without Flutter or a database. The examples below are **the shipped demo as of Wednesday 21 October 2026, 15:00** (`demoNow` in the tests): the numbers the tests assert, and the ones on the screenshots.

---

## The building blocks

- **`CalendarDate`:** a day in the user's calendar (an extension type over a `yyyymmdd` integer), taken from the injected `Clock`. A check-in at 23:59 counts for that day. Weeks are **ISO weeks**, Monday to Sunday.
- **`HabitLog`:** at most one per habit per day: a number of check-ins (`count` ≥ 1), or a skip (`count` 0). No log means "not done". The database's primary key and a `CHECK` make anything else impossible.
- **`HabitHistory`:** one habit and its logs, with the questions the engine asks about a day.

| A day is… | When |
|---|---|
| **done** | its count reached the daily target ("8 / 8"; "9 / 8" is still one done day) |
| **partial** | some check-ins, below the target |
| **skipped** | skipped on purpose: neither done nor missed |
| **missed** | due, over and not done (fixed-day habits only) |
| **open** | due today, not done yet: not a miss until the day ends |
| **none** | nothing asked: not due, not started, archived, or a weekly habit's day off |

## Due days (`isDue`)

A habit is never due before its **start date** or from the day it was **archived** (it keeps its history).

| Schedule | Due |
|---|---|
| **Daily** | every day |
| **On weekdays** (`{1, 3, 5}`) | on those days |
| **N times a week** | every day of the ISO week **until the week's N slots are used**. A done day and a skipped day each use one; a partial day uses none. In a week the habit starts part-way through, it asks for fewer (a 5× habit started on a Friday can't be done five times that week). |

*Demo:* every habit is due today, Wednesday. **Learn Spanish** (5× a week) has 2 of this week's 5 done; it stays due until 5 are.

## Streaks (`habitStreak`)

- **Fixed days** (daily, on weekdays) count **consecutive due days done**. Days not due and skipped days are passed over: a Mon / Wed / Fri habit survives Tuesday, and a skip neither breaks nor extends it. **Today counts once done, and never breaks the streak before then.**
- **N times a week** counts **consecutive ISO weeks that met their target**, in weeks. Judging the week, not the day, is the point of the schedule: any three days make a 3× week. This week counts once met, and doesn't break the run while under way.
- Each streak has its **current** run and the **longest**.

*Demo:*

| Habit | Schedule | Streak | Why |
|---|---|---|---|
| Drink water | daily, 8 a day | **9 days** | the 11th had only some glasses (partial): a miss. The 12th to the 20th were done; today's 3 / 8 is still open |
| Morning run | Mon · Wed · Fri | **9 days** | nine due days done in a row; the Tuesdays and weekends in between don't count |
| Read 20 pages | daily | **19 days** | done every day from the 2nd to yesterday; today open |
| Learn Spanish | 5× a week | **3 weeks** | the last three weeks met 5; this week (2 so far) neither counts nor breaks |
| No-spend day | 3× a week | **5 weeks** | |
| Plan tomorrow | weekdays | **9 days** (longest 13) | a skip on the 9th was passed over; an earlier miss ended the 13-day run |

## Perfect days (`perfectDayStreak`)

A day is **perfect** when nothing due on it was missed and something was done. Skips don't spoil a day, and a weekly habit, judged by its week, never does either (doing one still makes a day count). Days with nothing asked or done are passed over, and today counts once perfect, without breaking the run before then.

*Demo:* **9 perfect days**, up to yesterday. Today has nothing done yet, so it's neither perfect nor a break.

## Completion rate (`completionRate`)

**Done ÷ asked**, over a range, with the streak's rules: days not due and skipped days are left out, and **today counts only once done** (a rate that dropped every morning would mean nothing). A weekly habit asks for its slots each week, less its skips, and this week only for what's done so far.

*Demo:* the last 30 days, all habits: **111 of 123, 90 %**. Since its start, **No-spend day** has the best rate (24 of 25, 96 %): Analytics' "most successful habit".

## The consistency score (`consistencyScore`)

The completion rate over the **last 30 days**, with the **last 7 counted twice**, so it follows how you're doing now. 0–100; `null` until 7 habit-days have been asked for.

*Demo:* the last 7 days 27 of 28, the 23 before 85 of 100:

```
(2 × 27 + 85) / (2 × 28 + 100) = 139 / 156 = 89 %  →  89
```

## Goals (`goalWindow`, `goalProgress`)

A goal counts **done habit-days in its current window**: today, the ISO week, or the month, for all habits or one. Nothing is stored or reset: on Monday the window moves and the count starts from zero. The whole window counts, including days before the goal was set; archived habits' days still count, since they happened.

*Demo:*

| Goal | Window | Progress |
|---|---|---|
| Complete 25 habits this week | Mon 19 – Sun 25 Oct | **10 of 25** (Monday 6, Tuesday 4) |
| Read on 20 days this month | October | **19 of 20** |
| Complete 4 habits today | today | **0 of 4** |

## Routines (`routinesToday`)

Each routine with **today's** check-offs only, in the order of the day (morning, afternoon, evening, any time). Yesterday's ticks don't count today.

*Demo:* Morning **2 of 4**, Evening **0 of 3**.

## Badges (`achievementProgress`)

Ten rules, each a plain function of the history with a progress (`current` of `target`), so each is tested at its edge (6 days vs 7). When a rule is first met, the badge is **recorded once with its date** and stays unlocked, even if the progress later drops: "7-day streak, unlocked 12 Oct" must stay true after the streak breaks. Only unlocks are stored; Reset progress clears them.

| Badge | Rule | Demo |
|---|---|---|
| First step | 1 completion | ✅ |
| 7-day streak | a habit's day streak reaches 7 (current or longest) | ✅ |
| 30-day streak | … reaches 30 | 19 / 30 |
| Perfect week | 7 perfect days in a row | ✅ |
| Century | 100 completions | ✅ (200) |
| Early bird | a morning routine fully checked off on 5 days | ✅ |
| Habit builder | 5 active habits | ✅ (6) |
| Consistency master | a score of 80, with 30 days of history | ✅ (89) |
| Comeback | a habit done again after 8+ days away, with a due day missed between (a week of skips or days off isn't "away") | 0 / 1 |
| All rounder | completions in 5 categories | ✅ (6) |

Weekly habits count in weeks, so they never earn a *day* streak badge. Loading the demo earns **8 badges**, celebrated together once the writes settle.

## Analytics (`buildAnalytics`)

| Figure | Demo |
|---|---|
| Completion rate, 30 days | 90 % (111 of 123) |
| Consistency score | 89 |
| Best current streak | Read 20 pages, 19 days |
| Total completions | 200 |
| Perfect days this month | 15 |
| Weekly completions, last 8 weeks | 20 · 20 · 26 · 26 · 25 · 25 · 31 · 10 (this week so far) |
| Monthly, last 6 months | May–Jul 0 · Aug 20 · Sep 100 · Oct 80 |
| Longest runs | No-spend day 5 weeks · Learn Spanish 3 weeks · Read 20 pages 19 days · Plan tomorrow 13 · Drink water 9 · Morning run 9 |
| Categories | Reading 49 · Health 48 · Learning 31 · Finance 26 · Productivity 24 · Fitness 22 |

Every chart has a written summary for screen readers.

## The notification plan

The same history drives the reminders: see [NOTIFICATIONS.md](NOTIFICATIONS.md). *Demo,* at 15:00 with the default settings: 41 notifications over the next 7 days, the first ones today:

```
19:00  Learn Spanish        One lesson in the app.          (reminder; Drink water's 10:00 has passed)
20:00  6 habits left today  Drink water, Morning run, Read 20 pages and 3 more
21:00  Read 20 pages        Due today
21:30  Plan tomorrow        Write down the top three tasks.
21:30  Your day             0 of 6 done today, 9 perfect days
```

## Why it's built this way

- **Derived, never stored:** a streak column would be a second copy of the truth, and copies drift. A backfilled day or an edited schedule changes every figure at once, correctly.
- **Skipped and not-due days are neutral:** being ill, or a Tuesday for a Mon / Wed / Fri habit, isn't failure.
- **Weekly habits are judged per week:** "3 times a week" says nothing about Thursday.
- **Today pending never breaks anything:** at 9:00 you haven't failed today.
- **Badges are stored once:** an achievement is a moment, not a state.

## Where to look

| File | What |
|---|---|
| `habit_history.dart` | `HabitHistory`, `DayState`, `isDue`, week slots and outcomes |
| `streaks.dart` | `habitStreak` |
| `perfect_days.dart` | `isPerfectDay`, `perfectDayStreak`, the week strip |
| `completion_rate.dart` | `completionRate` |
| `analytics.dart` | `consistencyScore`, `buildAnalytics` |
| `goals.dart`, `routines.dart` | goal windows and progress; today's routines |
| `achievements.dart` | the ten rules, `newlyEarned`, `achievementStatuses` |
| `overviews.dart` | Today, Habits and Habit detail, built from the above |
| `notification_plan.dart` | the plan |
