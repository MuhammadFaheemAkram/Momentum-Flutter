# Interview Notes

Questions this project answers, with the answers it gives. Each phase summary has more, tied to that phase's code.

---

## Architecture

**Q: Why is nothing like "current streak" stored?**
A: A stored streak is a second copy of the truth, and copies drift: backfill a day, skip one, change a schedule, and the column is wrong until some code remembers to fix it. Here the logs are the only history. Streaks, rates, perfect days, goal progress and scores are pure functions of them, re-run whenever drift says a table changed. The one stored "result" is a badge's unlock, because it's a moment ("unlocked 12 Oct"), not a state.

**Q: Where does business logic live?**
A: In the domain: pure calculations (`isDue`, `habitStreak`, `perfectDayStreak`, `consistencyScore`, `goalProgress`, the ten badge rules, `planNotifications`) and one use case per user action, holding the rules that aren't SQL (no future days, backfill up to 30 days, an archived habit can't be logged, denied permission keeps notifications off). Repositories own persistence; Cubits hold screen state; Views render it.

**Q: How do you keep plugins out of your business logic?**
A: Interfaces in `domain/service` (`NotificationScheduler`, `NotificationInteractions`, `BackgroundWork`, `DynamicColorSource`), implemented in `core/platform`. Use cases and Cubits are tested against fakes that keep state and play the user's answers; the plugin code is checked on devices.

**Q: How do badges get evaluated "after every write" without every write calling them?**
A: An app-wide watcher combines the history's streams, waits for a burst of writes to settle (300 ms, so loading the demo celebrates its badges together), then records what's newly earned in one transaction and shows a SnackBar through the app's `ScaffoldMessenger`, on whatever screen is showing. The background tasks run the same evaluation.

## The habit engine

**Q: How do you compute a streak for "Mon / Wed / Fri"?**
A: Walk the due days only: days not due are passed over, so Tuesday can't break it. Skipped days are passed over too (neutral), and today counts once done but never breaks the run while pending.

**Q: And for "3 times a week"?**
A: Judge the week, not the day. Each ISO week has three slots; a done day or a skip uses one. The streak counts consecutive weeks that met their target, in weeks; this week counts once met and doesn't break the run while under way. The habit is due every day until the week's slots are used, and an empty day is never a "miss".

**Q: What makes a day "perfect"?**
A: Nothing due on it was missed, and something was done. Skips don't spoil it, and weekly habits never do, since they're judged per week. Days with nothing asked are passed over.

**Q: How is the consistency score weighted?**
A: It's the completion rate over 30 days with the last 7 counted twice, so it follows how you're doing now: `(2·recent + earlier) / (2·recentAsked + earlierAsked)`. It's `null` until 7 habit-days have been asked for. The demo's 89 is worked through in HABIT_ENGINE.md.

**Q: How does a weekly goal reset?**
A: It doesn't. Its progress is the done habit-days in the current ISO week, computed when read. On Monday the window moves and the count is zero, with no job and no stored counter.

## Data

**Q: How do you make invalid data impossible?**
A: With constraints, not only code: one log per habit per day (a composite primary key); a log is a skip or a count (`CHECK (skipped = (count = 0))`), so "not done" has one representation, no row; each schedule has exactly its columns; targets are ranged; a goal names a habit exactly when it counts one. Tests insert broken rows and expect SQLite to refuse them.

**Q: Why must an upsert never be `INSERT OR REPLACE` here?**
A: SQLite's `REPLACE` deletes the conflicting row, then inserts, and the delete fires `ON DELETE CASCADE`. Replacing a routine step would delete its check-offs. `ON CONFLICT DO UPDATE` changes the row in place.

**Q: How do you save a reordered list safely?**
A: In one transaction: upsert the routine, delete the steps no longer listed, upsert each step at its new index. Steps keep their ids, so their check-offs follow them. A test breaks the last write to prove the rollback.

## Notifications and background work

**Q: Why not one repeating notification per habit?**
A: A repeating notification can't skip a day the habit is already done, can't follow a weekday schedule or a weekly target, and can't say how many habits are left. So a pure planner lists each day's notifications for the next 7 days (reminders, the nudge, the summary), and a sync applies only the difference, after every change, at midnight, on resume and in the background.

**Q: How does the sync know what changed?**
A: Ids are stable hashes of (kind, habit, day). The pending list doesn't return the time, so the payload carries it (`habit:<id>#2026-10-21T21:00`). Pending ids not in the plan are cancelled; planned ones that are new or differ are scheduled; the rest are left alone. A test proves an unchanged plan makes no calls.

**Q: Why 60, and why 7 days?**
A: iOS keeps only the 64 soonest pending notifications per app and drops the rest silently; 60 leaves a margin. A week is far enough ahead that the app or the background task will plan again long before it runs out.

**Q: What runs in the background, and how does it get its dependencies?**
A: A top-level `@pragma('vm:entry-point')` function in a fresh isolate, where `getIt` is empty. It builds a small graph by hand from the same classes and runs the same use cases: badges, a backup when due, the notification sync. "Mark done" runs the same way. drift's `shareAcrossIsolates` puts both isolates on one database server, so the app's screens update when the background writes.

**Q: Is background work guaranteed to run?**
A: No. Android's WorkManager defers it in Doze; iOS's BGTaskScheduler runs it when it sees fit, often not at all for a rarely used app. So nothing time-critical depends on it: the notifications are already with the OS, a week ahead.

**Q: What breaks when two isolates share preferences?**
A: Each has its own cache. If a repository wrote every key from its stale copy, it would erase what the other isolate saved. So it writes only the keys that changed, and the app reloads the cache on resume.

**Q: How do you handle notification permission?**
A: Ask only when the user turns notifications on, so the prompt has a reason. Denied: the switch stays off and a card opens the system settings. Revoked later: the next sync, on resume, turns the switch off, so it never reads "on" while nothing can ring.

## Accessibility

**Q: How do you make the app usable at large text sizes?**
A: Text grows everywhere, and above 130 % side-by-side controls stack: segments become chips or a radio list, the drawer widens, switch tiles drop their icons. A test tour checks every screen at 200 % for overflow, tap targets, labels and contrast; a real device at the largest size found what the test font can't (a mid-word break).

**Q: How can a screen-reader user reorder a routine?**
A: `ReorderableListView` gives every item Move up, Move down, Move to the start and Move to the end actions. The drag handles are hidden from screen readers, and a test runs the actions.

## Testing

**Q: How do you know your tests are any good?**
A: Mutation checks: break a behaviour on purpose and see a test fail. 53 were broken here, from the skip-or-count `CHECK` to "today pending never breaks a streak" to "a revoked permission turns the switch off"; each was caught.

**Q: How do you test time?**
A: An injected `Clock`, fixed in tests (`Clock.fixed(demoNow)`), and `CalendarDate` for days, so every date in a test is known. Debounces are tested in fake time; stream switching in real time, with short durations.

**Q: How do you test background entry points?**
A: They take their dependency graph as a function: `dispatchBackgroundTask(task, openGraph)`. The app passes `BackgroundGraph.open`; tests pass a graph on the in-memory database with a fake scheduler.

## Trade-offs and next steps

**Q: What would you change for production?**
A: A real backend behind `MomentumService` (and restore from a backup), sync across devices, localization, an adaptive tablet layout, and integration tests on devices. See ROADMAP.md.
