// drift reads a column getter's *definition* at build time and never calls
// it. A getter naming itself inside `check(...)` is drift's documented way to
// write a CHECK constraint on that column, not a recursion (conventions
// §11.41).
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';
import 'package:momentum/core/database/converters.dart';
import 'package:momentum/domain/model/habit_enums.dart';

// Everything here belongs to the user; there is no synced content.
//
// Days (`day`, `start_date`, …) are `CalendarDate`s taken from the local
// clock: a streak counts the user's days, not UTC's. Instants (`*_at`) are
// UTC text (conventions §11.14), for ordering.
//
// Nothing stores a streak, a rate, a goal's count or a score: they are
// derived from the logs when they are read. The constraints below make
// invalid rows impossible, whichever code writes them.

/// How a habit's schedule is stored: `HabitSchedule`'s three cases.
enum ScheduleType { daily, onWeekdays, timesPerWeek }

/// What a goal counts: any habit, or one (`habit_id`).
enum GoalKind { allHabits, habit }

@DataClassName('HabitRow')
@TableIndex(name: 'habits_by_order', columns: {#sortOrder})
class Habits extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get description => text().withDefault(const Constant(''))();

  TextColumn get category => textEnum<HabitCategory>()();

  TextColumn get color => textEnum<HabitColor>()();

  TextColumn get icon => textEnum<HabitIcon>()();

  TextColumn get scheduleType => textEnum<ScheduleType>()();

  /// For `onWeekdays`: one bit per day, Monday = 1, Tuesday = 2, … Sunday =
  /// 64. A bitmask keeps the schedule in its row, and a weekday test is one
  /// `&`. Zero for the other schedules.
  IntColumn get weekdays => integer()
      .withDefault(const Constant(0))
      .check(weekdays.isBetweenValues(0, 127))();

  /// For `timesPerWeek`: 1–6 (seven a week is `daily`). Null otherwise.
  IntColumn get timesPerWeek =>
      integer().nullable().check(timesPerWeek.isBetweenValues(1, 6))();

  IntColumn get dailyTarget =>
      integer().check(dailyTarget.isBetweenValues(1, 20))();

  IntColumn get startDate => integer().map(const CalendarDateConverter())();

  TextColumn get reminderTime =>
      text().nullable().map(const TimeOfDayConverter())();

  DateTimeColumn get archivedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    // Each schedule has exactly the columns it needs.
    "CHECK ((schedule_type = 'onWeekdays') = (weekdays > 0))",
    "CHECK ((schedule_type = 'timesPerWeek') = (times_per_week IS NOT NULL))",
    "CHECK (reminder_time IS NULL OR (reminder_time GLOB '[0-2][0-9]:[0-5][0-9]'"
        " AND reminder_time < '24:00'))",
  ];
}

/// One row per habit per day: the primary key makes a second log for the
/// same day impossible, so "+1" is an upsert, not a new row.
@DataClassName('HabitLogRow')
@TableIndex(name: 'habit_logs_by_day', columns: {#day})
class HabitLogs extends Table {
  TextColumn get habitId =>
      text().references(Habits, #id, onDelete: KeyAction.cascade)();

  IntColumn get day => integer().map(const CalendarDateConverter())();

  IntColumn get count => integer().check(count.isBiggerOrEqualValue(0))();

  BoolColumn get skipped => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {habitId, day};

  @override
  List<String> get customConstraints => [
    // A row is either a skip (no check-ins) or at least one check-in. "Not
    // done" is the absence of a row, so there is one way to say it.
    'CHECK (skipped = (count = 0))',
  ];
}

@DataClassName('RoutineRow')
class Routines extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get time => textEnum<RoutineTime>()();

  DateTimeColumn get createdAt => dateTime()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// A routine's items. `sort_order` isn't unique: a reorder rewrites every
/// item's position in one transaction, and a unique index would reject the
/// swaps half-way.
@DataClassName('RoutineItemRow')
@TableIndex(name: 'routine_items_by_routine', columns: {#routineId, #sortOrder})
class RoutineItems extends Table {
  TextColumn get id => text()();

  TextColumn get routineId =>
      text().references(Routines, #id, onDelete: KeyAction.cascade)();

  TextColumn get title => text()();

  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// An item checked off on a day. No row: not checked.
@DataClassName('RoutineCheckRow')
@TableIndex(name: 'routine_checks_by_day', columns: {#day})
class RoutineChecks extends Table {
  TextColumn get itemId =>
      text().references(RoutineItems, #id, onDelete: KeyAction.cascade)();

  IntColumn get day => integer().map(const CalendarDateConverter())();

  @override
  Set<Column<Object>> get primaryKey => {itemId, day};
}

/// A goal on one habit goes with it (`CASCADE`): a goal can't count a
/// habit that no longer exists.
@DataClassName('GoalRow')
@TableIndex(name: 'goals_by_habit', columns: {#habitId})
class Goals extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get kind => textEnum<GoalKind>()();

  TextColumn get habitId =>
      text().nullable().references(Habits, #id, onDelete: KeyAction.cascade)();

  TextColumn get period => textEnum<GoalPeriod>()();

  IntColumn get target => integer().check(target.isBetweenValues(1, 200))();

  IntColumn get createdOn => integer().map(const CalendarDateConverter())();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    "CHECK ((kind = 'habit') = (habit_id IS NOT NULL))",
  ];
}

/// A badge earned. The rules live in code; only the moment of earning is a
/// row, written once (the primary key keeps it from being earned twice).
@DataClassName('AchievementUnlockRow')
class AchievementUnlocks extends Table {
  TextColumn get achievementId => text()();

  IntColumn get unlockedOn => integer().map(const CalendarDateConverter())();

  DateTimeColumn get unlockedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {achievementId};
}
