import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';

// Domain models ⇄ drift rows. The rows mirror the tables (a schedule is
// three columns, a routine's items are a table of their own); the models
// mirror the ideas (a sealed schedule, a routine that holds its items in
// order). The two directions are tested as a round trip.

extension UserDataToRows on UserData {
  UserRows toRows() => UserRows(
    habits: [for (final habit in habits) habit.toRow()],
    logs: [for (final log in logs) log.toRow()],
    routines: [for (final routine in routines) routine.toRow()],
    routineItems: [
      for (final routine in routines)
        for (final (index, item) in routine.items.indexed)
          RoutineItemRow(
            id: item.id,
            routineId: routine.id,
            title: item.title,
            sortOrder: index,
          ),
    ],
    routineChecks: [
      for (final check in routineChecks)
        RoutineCheckRow(itemId: check.itemId, day: check.day),
    ],
    goals: [for (final goal in goals) goal.toRow()],
    unlocks: [
      for (final unlock in unlocks)
        AchievementUnlockRow(
          achievementId: unlock.achievementId,
          unlockedOn: unlock.unlockedOn,
          unlockedAt: unlock.unlockedAt,
        ),
    ],
  );
}

extension UserRowsToDomain on UserRows {
  UserData toUserData() {
    final itemsByRoutine = <String, List<RoutineItemRow>>{};
    for (final item in routineItems) {
      (itemsByRoutine[item.routineId] ??= []).add(item);
    }
    return UserData(
      habits: [for (final row in habits) row.toDomain()],
      logs: [for (final row in logs) row.toDomain()],
      routines: [
        for (final row in routines)
          row.toDomain(itemsByRoutine[row.id] ?? const []),
      ],
      routineChecks: [
        for (final row in routineChecks)
          RoutineCheck(itemId: row.itemId, day: row.day),
      ],
      goals: [for (final row in goals) row.toDomain()],
      unlocks: [
        for (final row in unlocks)
          AchievementUnlock(
            achievementId: row.achievementId,
            unlockedOn: row.unlockedOn,
            unlockedAt: row.unlockedAt,
          ),
      ],
    );
  }
}

extension HabitToRow on Habit {
  HabitRow toRow() {
    final (type, weekdays, times) = switch (schedule) {
      Daily() => (ScheduleType.daily, 0, null),
      OnWeekdays(:final weekdays) => (
        ScheduleType.onWeekdays,
        weekdayMask(weekdays),
        null,
      ),
      TimesPerWeek(:final times) => (ScheduleType.timesPerWeek, 0, times),
    };
    return HabitRow(
      id: id,
      title: title,
      description: description,
      category: category,
      color: color,
      icon: icon,
      scheduleType: type,
      weekdays: weekdays,
      timesPerWeek: times,
      dailyTarget: dailyTarget,
      startDate: startDate,
      reminderTime: reminder,
      archivedAt: archivedAt,
      createdAt: createdAt,
      sortOrder: sortOrder,
    );
  }
}

extension HabitRowToDomain on HabitRow {
  Habit toDomain() => Habit(
    id: id,
    title: title,
    description: description,
    category: category,
    color: color,
    icon: icon,
    schedule: switch (scheduleType) {
      ScheduleType.daily => const HabitSchedule.daily(),
      ScheduleType.onWeekdays => HabitSchedule.onWeekdays(weekdaysOf(weekdays)),
      // The table's CHECK guarantees the column for this schedule.
      ScheduleType.timesPerWeek => HabitSchedule.timesPerWeek(timesPerWeek!),
    },
    dailyTarget: dailyTarget,
    startDate: startDate,
    reminder: reminderTime,
    archivedAt: archivedAt,
    createdAt: createdAt,
    sortOrder: sortOrder,
  );
}

/// Weekdays (1 = Monday … 7 = Sunday) as a bitmask: Monday is bit 0.
int weekdayMask(Set<int> weekdays) {
  var mask = 0;
  for (final weekday in weekdays) {
    RangeError.checkValueInInterval(weekday, 1, 7, 'weekday');
    mask |= 1 << (weekday - 1);
  }
  return mask;
}

/// The weekdays a [mask] holds, Monday first.
Set<int> weekdaysOf(int mask) => {
  for (var weekday = 1; weekday <= 7; weekday++)
    if (mask & (1 << (weekday - 1)) != 0) weekday,
};

extension HabitLogToRow on HabitLog {
  HabitLogRow toRow() =>
      HabitLogRow(habitId: habitId, day: day, count: count, skipped: skipped);
}

extension HabitLogRowToDomain on HabitLogRow {
  HabitLog toDomain() =>
      HabitLog(habitId: habitId, day: day, count: count, skipped: skipped);
}

extension RoutineToRow on Routine {
  RoutineRow toRow() => RoutineRow(
    id: id,
    title: title,
    time: time,
    createdAt: createdAt,
    sortOrder: sortOrder,
  );
}

extension RoutineRowToDomain on RoutineRow {
  /// The routine with its [items], in their saved order.
  Routine toDomain(List<RoutineItemRow> items) => Routine(
    id: id,
    title: title,
    time: time,
    items: [
      for (final item in [
        ...items,
      ]..sort((a, b) => a.sortOrder.compareTo(b.sortOrder)))
        RoutineItem(id: item.id, title: item.title),
    ],
    createdAt: createdAt,
    sortOrder: sortOrder,
  );
}

extension GoalToRow on Goal {
  GoalRow toRow() {
    final (kind, habitId) = switch (scope) {
      AllHabits() => (GoalKind.allHabits, null),
      OneHabit(:final habitId) => (GoalKind.habit, habitId),
    };
    return GoalRow(
      id: id,
      title: title,
      kind: kind,
      habitId: habitId,
      period: period,
      target: target,
      createdOn: createdOn,
      createdAt: createdAt,
    );
  }
}

extension GoalRowToDomain on GoalRow {
  Goal toDomain() => Goal(
    id: id,
    title: title,
    scope: switch (kind) {
      GoalKind.allHabits => const GoalScope.allHabits(),
      // The table's CHECK guarantees a habit for this kind.
      GoalKind.habit => GoalScope.habit(habitId!),
    },
    period: period,
    target: target,
    createdOn: createdOn,
    createdAt: createdAt,
  );
}
