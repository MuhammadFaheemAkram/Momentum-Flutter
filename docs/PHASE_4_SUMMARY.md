# Phase 4 — Goals and Routines

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 4, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 4 adds the two things that sit around habits:
- **goals**: a target for a day, a week or a month ("complete 25 habits this week"), counted from the same history as everything else;
- **routines**: short ordered checklists for a time of day, checked off afresh each day, with steps you reorder by dragging (or with a screen reader's actions);
- both on **Today**.

---

## 🧱 What Was Implemented

- **Domain:**
  - `goalWindow` (today, the ISO week, the month) and `goalProgress`: the done habit-days in the window up to today, for all habits or one. A done day is its daily target reached, so "8 glasses" counts once; skips and partial days don't count; archived habits' days still do;
  - `routinesToday`: each routine with today's check-offs, in the order of the day (morning, afternoon, evening, any time), then the user's order;
  - models: `GoalDraft`, `GoalWindow`, `GoalProgress`, `RoutineDraft`, `RoutineProgress`;
  - validation: a routine needs a name (≤ 40), 1–20 steps, each named (≤ 60); a goal needs a name (≤ 60) and a target of 1–200.
- **Data:**
  - `RoutinesDao.saveRoutine` writes the routine and *every* step's position in **one transaction**. Steps no longer listed are deleted, and their check-offs cascade. The others keep their ids, so their check-offs follow them wherever they move. Upserts are `ON CONFLICT DO UPDATE`, never a cascading `REPLACE` (§11.53);
  - `setChecked` is idempotent (`INSERT OR IGNORE`, or a delete);
  - `GoalsDao.updateGoal` rewrites every column, so a goal moved from one habit to all habits loses its `habit_id` (§11.57);
  - `RoutineRepository`, `GoalRepository` (a new goal is set today; an edit keeps when it was set).
- **Use cases:** `WatchRoutines`, `WatchGoals` (clock first, §11.61), `SaveRoutine`, `DeleteRoutine`, `ToggleRoutineItem` (today only), `SaveGoal`, `DeleteGoal`. `WatchToday` now combines five sources: habits, logs, routines, check-offs and goals.
- **Screens:**
  - **Routines:** each routine with today's steps as checkboxes (done steps checked and crossed out), its count, and Edit; New routine; an empty state that explains what a routine is.
  - **The routine editor** (a full-screen dialog):
    - a name, the time of day, and the steps as a `ReorderableListView`, dragged by their handles;
    - Add a step (up to 20), Remove, errors after a first Save, the discard guard, Delete (confirmed).
  - **Goals:**
    - Daily / Weekly / Monthly, each with its count, and the goals of the chosen period;
    - a goal card with a bar, "18 of 25 this week", what it counts and when it resets. A met goal says "Done this week" and shows a check.
  - **The goal sheet:** name, what counts (all habits, or one, chosen from the active habits), period, a target of 1–200, and Delete for an existing goal.
  - **Today:** "Routines today" (a tile per routine, "3 / 4", opens Routines) and "Goals" (the cards, open Goals), after the habits.
- **Large text:**
  - the drawer widens to 90 % of the screen, after "Achievements" broke mid-word at AX3;
  - steps wrap to three lines;
  - the period segments become chips.
- **Tests:** 482 (84 new), and eight mutation checks (below).

### Differences from the plan

- **Reordering is part of the editor's Save, not a use case of its own.** The spec listed `ReorderRoutineItems`. Moving steps is an edit like renaming one, so the draft holds the order, and Save writes every position in one transaction. So a reorder can't be half-saved, and Cancel undoes it.
- **No hand-written Move up / Move down.** `ReorderableListView` already gives each item Move up, Move down, Move to the start and Move to the end for screen readers. A view test pins them, and an app flow saves a reorder made with "Move to the start". The drag handles are hidden from screen readers.
- **Goals count the whole window**, also the days before the goal was set: a weekly goal set on Wednesday counts Monday's habits. The window is "this week", not "since I set it".
- **Opening Goals from Today shows its weekly goals**, whichever card was tapped.

### Mutation checks

Each was broken on purpose, tested, then restored:

| Broken on purpose | Caught by |
|---|---|
| Partial days count toward a goal | "one habit: only that habit counts" (and the window tests) |
| Weeks start on Sunday | "weekly is the ISO week, Monday to Sunday, across a month end" |
| A routine saved without its transaction | "all in one transaction: a broken step leaves everything as it was" |
| A save deletes every step and re-adds them | "a saved reorder keeps every check-off on its step" |
| A goal update as an upsert from its row | "an update to all habits writes the null habit (conventions §11.57)" |
| Any day's check-offs count today | "counts only today's check-offs, of its own items" |
| A move one place off (the old `onReorder` adjustment kept) | "moves steps the way the list reports them" |
| The drawer's large-text width removed | "at large text it widens, so long labels keep whole words" |

---

## 💙 Flutter / Dart Concepts Demonstrated

- **`ReorderableListView`** with `header` and `footer` (the form fields around the list), explicit drag handles (`ReorderableDragStartListener`, `buildDefaultDragHandles: false`), and `onReorderItem`. It reports the step's final index, unlike the deprecated `onReorder`, which made every caller subtract one.
- **Built-in reorder semantics:** each item gets Move up / down / to the start / to the end as custom semantics actions. Tests find the nodes with `find.semantics.byPredicate` and run the action through the node's owner.
- **Stable keys and controllers:** each step has an id from the start (`IdGenerator`), used as its `ValueKey` and to keep its `TextEditingController`. A moved step keeps its text and cursor.
- **Writing a tree in one transaction:** parent upsert, delete what's gone, upsert the rest, all inside `transaction`, and a test that breaks the last write to prove the rollback.
- **Derived, windowed progress:** a goal's count is a pure function of the history and today, so a new week needs no job and no reset.
- **A bottom sheet that returns a sealed result** (`SaveGoalResult` / `DeleteGoalResult`): the sheet stays a plain widget, and the Cubit does the saving.
- **Combining many streams:** nested `combineLatest` pairs destructured with a record pattern: `(((habits, logs), (routines, checks)), goals)`.

---

## 🔁 Data Flow (this phase)

```
Routine editor ── drag / Move up ──▶ RoutineEditorCubit.moveItem   (the draft only)
               ── Save ──▶ SaveRoutineUseCase (rules) ──▶ RoutineRepository
                           RoutinesDao.saveRoutine: one transaction
                             upsert routine · delete steps not listed (their checks cascade) · upsert each step at its index

Routines ── checkbox ──▶ ToggleRoutineItemUseCase(today) ──▶ setChecked (insert or ignore / delete)

Goals ── sheet ──▶ SaveGoalResult(draft) ──▶ GoalsCubit.save ──▶ SaveGoalUseCase ──▶ GoalsDao (insert / update every column)

clock ─┐
habits ┼─ combineLatest ─▶ goalProgress (done days in the window) ─▶ Goals, Today
logs ──┘
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `lib/domain/calculation/{goals,routines}.dart` | Goal windows and progress; today's routines in order. |
| `lib/core/database/daos/{routines_dao,goals_dao}.dart` | Routines saved whole; goals updated column by column. |
| `lib/data/repository/{routine_repository_impl,goal_repository_impl}.dart` | The repositories. |
| `lib/domain/usecase/{routine_use_cases,goal_use_cases}.dart` | One use case per action, and the live views. |
| `lib/features/{routines,routine_editor,goals}/**` | The three screens and the goal sheet. |
| `lib/core/design_system/widgets/{goal_card,routine_card}.dart` | `GoalCard`, `RoutineCard`, `RoutineSummaryTile`. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `GoalWindow`, `GoalProgress`, `GoalDraft` | freezed | A goal's window, its count now, what the sheet saves | `domain/model` |
| `RoutineProgress`, `RoutineDraft` | freezed | Today's check-offs; what the editor saves | `domain/model` |
| `RoutinesDao`, `GoalsDao` | drift | Storage and its rules | `core/database` |
| `RoutinesCubit`, `RoutineEditorCubit`, `GoalsCubit` | Cubits | The three screens | `features/*/cubit` |
| `GoalEditorSheet`, `GoalEditorResult` | widget / sealed class | The goal sheet and what it decided | `features/goals/widgets` |

---

## 🌱 Folder Structure Changes

- **New:** `lib/features/routines/cubit`, `lib/features/routine_editor/cubit`, `lib/features/goals/{cubit,widgets}`; tests mirroring them.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Scope | goals, routines, progress tracking, tests | goals (progress), routines (ordered items, reorder), CRUD, derived progress | the same, plus both on Today |
| Goal progress | progress calculations, derived state | derived progress | done habit-days in the window (today, ISO week, month); nothing stored or reset |
| Goal model | stores `currentCount` | the same | none stored; all habits or one habit (a sealed scope) |
| Reorder | "drag/reorder if practical" | reorder | `ReorderableListView` with handles, plus its built-in screen-reader actions; saved with every position in one transaction |
| Routine check-off | — | — | per day: steps checked off today, kept with their step when it moves |
| Editing | create, edit, delete | CRUD | a full-screen editor (routines) and a bottom sheet (goals), errors after Save, discard guard, confirmed delete |
| Tests | tests | tests | goal windows and progress, the one-transaction save and its rollback, reorder semantics, Cubits, views, flows, the tour, mutation checks |

The Android spec makes reordering optional ("if practical"). Here it's a first-class edit, and it works without sight too, because the list's own semantics actions are tested.

---

## 🎤 Interview Notes

**Q: How does a weekly goal reset?**
A: It doesn't. Its progress is the number of done habit-days in the current ISO week, computed from the logs when read. On Monday the window moves and the count is zero, with no job, no stored counter and no reset to forget.

**Q: How do you save a reordered list safely?**
A: As one transaction: upsert the routine, delete the steps no longer listed, then upsert each step at its new index. Either every position changes or none does. Steps keep their ids, so their check-offs (a foreign key) follow them. A test makes the last write fail and checks that the old order, title and check-offs are all still there.

**Q: How do screen-reader users reorder a list?**
A: Flutter's `ReorderableListView` gives every item custom semantics actions: Move up, Move down, Move to the start, Move to the end. I hid the drag handles from screen readers (they'd be noise), pinned the actions in a test, and an app flow saves a reorder made with "Move to the start".

**Q: Why does editing a goal use a full-column update?**
A: drift's `insertOnConflictUpdate(row)` treats a `null` field as "leave it", so a goal moved from one habit to all habits would keep its old `habit_id`. And then the table's CHECK would reject the row. `update(...).replace(row)` writes every column, nulls included. A mutation check proves the test catches the difference.

---

## 📝 Learning Checklist

- ✅ Count goals per window (day, ISO week, month) from the history, with nothing stored
- ✅ Save an ordered list in one transaction, and prove the rollback
- ✅ Reorder with `ReorderableListView` and its screen-reader actions
- ✅ Keep list items' state (keys, controllers) stable across moves
- ✅ Return a sealed result from a bottom sheet
- ⬜ Achievements, analytics and search (Phase 5)

---

## 🚀 Future Improvements

- **Phase 5:** badges from the same history (Early bird reads routine check-offs), analytics, and search over habits, routines, goals and achievements.
- **Later:** a goal's history (how many weeks it was met), and reordering the routines themselves.
