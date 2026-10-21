import 'package:momentum/core/network/dto/backup_dto.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';

// Domain models ⇄ the backup DTO: mapping in the *outgoing* direction (the
// demo's mappers go the other way). Instants leave in UTC; days and times
// of day leave as text, since they belong to no time zone. Tested as a
// round trip of every field.

extension UserDataToBackup on UserData {
  BackupDto toBackupDto({required DateTime exportedAt}) => BackupDto(
    exportedAt: exportedAt.toUtc(),
    habits: [for (final habit in habits) habit._toDto()],
    logs: [
      for (final log in logs)
        BackupLogDto(
          habitId: log.habitId,
          day: log.day.toIso(),
          count: log.count,
          skipped: log.skipped,
        ),
    ],
    routines: [
      for (final routine in routines)
        BackupRoutineDto(
          id: routine.id,
          title: routine.title,
          time: routine.time,
          items: [
            for (final item in routine.items)
              BackupRoutineItemDto(id: item.id, title: item.title),
          ],
          createdAt: routine.createdAt.toUtc(),
          sortOrder: routine.sortOrder,
        ),
    ],
    routineChecks: [
      for (final check in routineChecks)
        BackupRoutineCheckDto(itemId: check.itemId, day: check.day.toIso()),
    ],
    goals: [
      for (final goal in goals)
        BackupGoalDto(
          id: goal.id,
          title: goal.title,
          habitId: switch (goal.scope) {
            OneHabit(:final habitId) => habitId,
            AllHabits() => null,
          },
          period: goal.period,
          target: goal.target,
          createdOn: goal.createdOn.toIso(),
          createdAt: goal.createdAt.toUtc(),
        ),
    ],
    unlocks: [
      for (final unlock in unlocks)
        BackupUnlockDto(
          achievementId: unlock.achievementId,
          unlockedOn: unlock.unlockedOn.toIso(),
          unlockedAt: unlock.unlockedAt.toUtc(),
        ),
    ],
  );
}

extension on Habit {
  BackupHabitDto _toDto() {
    final (type, weekdays, times) = switch (schedule) {
      Daily() => (BackupScheduleType.daily, <int>[], null),
      OnWeekdays(:final weekdays) => (
        BackupScheduleType.onWeekdays,
        weekdays.toList()..sort(),
        null,
      ),
      TimesPerWeek(:final times) => (
        BackupScheduleType.timesPerWeek,
        <int>[],
        times,
      ),
    };
    return BackupHabitDto(
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
      startDate: startDate.toIso(),
      reminder: reminder?.toHhMm(),
      archivedAt: archivedAt?.toUtc(),
      createdAt: createdAt.toUtc(),
      sortOrder: sortOrder,
    );
  }
}

extension BackupDtoToDomain on BackupDto {
  /// Reads a backup back. Throws a `FormatException` for a malformed day or
  /// time.
  UserData toUserData() => UserData(
    habits: [
      for (final habit in habits)
        Habit(
          id: habit.id,
          title: habit.title,
          description: habit.description,
          category: habit.category,
          color: habit.color,
          icon: habit.icon,
          schedule: switch (habit.scheduleType) {
            BackupScheduleType.daily => const HabitSchedule.daily(),
            BackupScheduleType.onWeekdays => HabitSchedule.onWeekdays(
              habit.weekdays.toSet(),
            ),
            BackupScheduleType.timesPerWeek => HabitSchedule.timesPerWeek(
              habit.timesPerWeek ??
                  (throw const FormatException('timesPerWeek is missing')),
            ),
          },
          dailyTarget: habit.dailyTarget,
          startDate: _day(habit.startDate),
          reminder: switch (habit.reminder) {
            final hhMm? => TimeOfDayValue.parse(hhMm),
            null => null,
          },
          archivedAt: habit.archivedAt,
          createdAt: habit.createdAt,
          sortOrder: habit.sortOrder,
        ),
    ],
    logs: [
      for (final log in logs)
        HabitLog(
          habitId: log.habitId,
          day: _day(log.day),
          count: log.count,
          skipped: log.skipped,
        ),
    ],
    routines: [
      for (final routine in routines)
        Routine(
          id: routine.id,
          title: routine.title,
          time: routine.time,
          items: [
            for (final item in routine.items)
              RoutineItem(id: item.id, title: item.title),
          ],
          createdAt: routine.createdAt,
          sortOrder: routine.sortOrder,
        ),
    ],
    routineChecks: [
      for (final check in routineChecks)
        RoutineCheck(itemId: check.itemId, day: _day(check.day)),
    ],
    goals: [
      for (final goal in goals)
        Goal(
          id: goal.id,
          title: goal.title,
          scope: switch (goal.habitId) {
            final habitId? => GoalScope.habit(habitId),
            null => const GoalScope.allHabits(),
          },
          period: goal.period,
          target: goal.target,
          createdOn: _day(goal.createdOn),
          createdAt: goal.createdAt,
        ),
    ],
    unlocks: [
      for (final unlock in unlocks)
        AchievementUnlock(
          achievementId: unlock.achievementId,
          unlockedOn: _day(unlock.unlockedOn),
          unlockedAt: unlock.unlockedAt,
        ),
    ],
  );
}

extension BackupReceiptToDomain on BackupReceiptDto {
  BackupReceipt toDomain() => BackupReceipt(
    receivedAt: receivedAt.toLocal(),
    habits: habits,
    logs: logs,
  );
}

/// `2026-10-14` → that day.
CalendarDate _day(String iso) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(iso);
  if (match == null) throw FormatException('Not a yyyy-MM-dd day', iso);
  return CalendarDate(
    int.parse(match.group(1)!),
    int.parse(match.group(2)!),
    int.parse(match.group(3)!),
  );
}
