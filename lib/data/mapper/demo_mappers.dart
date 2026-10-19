import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';

/// Turns the demo into the user's data, as of [now] (the device's local
/// time).
extension DemoMapping on DemoDto {
  /// - **Dates move with today:** a `(weeksAgo, weekday)` becomes that
  ///   weekday of the ISO week [weeksAgo] weeks before this one. Days from
  ///   today on are left out (the rest of this week), and `today` fills in
  ///   today.
  /// - **Checked before anything is written:** ids are unique; titles and
  ///   targets fit the app's limits; schedules are complete; no log or check
  ///   falls before its habit or routine began, or twice on one day; a log
  ///   is a skip or a count, never both; goals name habits that exist.
  ///   Broken data throws a [FormatException].
  UserData toUserData({required DateTime now}) {
    final today = CalendarDate.fromDateTime(now);

    void require(bool condition, String problem) {
      if (!condition) throw FormatException('Demo: $problem');
    }

    /// The day [weekday] of the week [weeksAgo] weeks back, or null when
    /// it's today or later.
    CalendarDate? dayOf(int weeksAgo, int weekday, String what) {
      require(weeksAgo >= 0, '$what is in a future week');
      require(weekday >= 1 && weekday <= 7, '$what: weekday $weekday');
      final day = today.weekStart.addDays(weekday - 1 - 7 * weeksAgo);
      return day < today ? day : null;
    }

    /// 08:00 on [day], never later than [now], in UTC.
    DateTime instantOn(CalendarDate day) {
      final instant = DateTime(day.year, day.month, day.day, 8);
      return (instant.isAfter(now) ? now : instant).toUtc();
    }

    void requireTitle(String title, int max, String what) => require(
      title.trim().isNotEmpty && title.length <= max,
      '$what: a title of 1–$max characters',
    );

    void requireUnique(Iterable<String> ids, String what) {
      final seen = <String>{};
      for (final id in ids) {
        require(id.isNotEmpty && seen.add(id), 'duplicate $what id "$id"');
      }
    }

    HabitLog logOf(String habitId, CalendarDate day, int count, bool skip) {
      require(
        skip ? count == 0 : count >= 1 && count <= 99,
        '$habitId on ${day.toIso()}: a skip or 1–99 check-ins',
      );
      return HabitLog(habitId: habitId, day: day, count: count, skipped: skip);
    }

    requireUnique(habits.map((h) => h.id), 'habit');
    final habitModels = <Habit>[];
    final logModels = <HabitLog>[];
    for (final (index, habit) in habits.indexed) {
      final id = habit.id;
      requireTitle(habit.title, 60, id);
      require(habit.description.length <= 280, '$id: a long description');
      require(
        habit.dailyTarget >= 1 && habit.dailyTarget <= 20,
        '$id: a daily target of 1–20',
      );
      require(habit.startWeeksAgo >= 0, '$id starts in a future week');
      final start = today.weekStart.addDays(-7 * habit.startWeeksAgo);
      habitModels.add(
        Habit(
          id: id,
          title: habit.title,
          description: habit.description,
          category: habit.category,
          color: habit.color,
          icon: habit.icon,
          schedule: _schedule(habit.schedule, id, require),
          dailyTarget: habit.dailyTarget,
          startDate: start,
          reminder: switch (habit.reminder) {
            final hhMm? => TimeOfDayValue.parse(hhMm),
            null => null,
          },
          createdAt: instantOn(start),
          sortOrder: index,
        ),
      );

      final days = <CalendarDate>{};
      for (final log in habit.logs) {
        require(log.weeksAgo <= habit.startWeeksAgo, '$id: a log before it');
        final day = dayOf(log.weeksAgo, log.weekday, id);
        if (day == null) continue;
        require(days.add(day), '$id: two logs on ${day.toIso()}');
        logModels.add(logOf(id, day, log.count, log.skipped));
      }
      if (habit.today case final todayLog?) {
        logModels.add(logOf(id, today, todayLog.count, todayLog.skipped));
      }
    }

    requireUnique(routines.map((r) => r.id), 'routine');
    requireUnique([
      for (final routine in routines) ...routine.items.map((i) => i.id),
    ], 'routine item');
    final routineModels = <Routine>[];
    final checkModels = <RoutineCheck>[];
    for (final (index, routine) in routines.indexed) {
      final id = routine.id;
      requireTitle(routine.title, 40, id);
      require(
        routine.items.isNotEmpty && routine.items.length <= 20,
        '$id: 1–20 items',
      );
      require(routine.createdWeeksAgo >= 0, '$id is from a future week');
      routineModels.add(
        Routine(
          id: id,
          title: routine.title,
          time: routine.time,
          items: [
            for (final item in routine.items)
              RoutineItem(id: item.id, title: item.title),
          ],
          createdAt: instantOn(
            today.weekStart.addDays(-7 * routine.createdWeeksAgo),
          ),
          sortOrder: index,
        ),
      );
      for (final item in routine.items) {
        requireTitle(item.title, 60, item.id);
        final days = <CalendarDate>{};
        for (final check in item.checks) {
          require(
            check.weeksAgo <= routine.createdWeeksAgo,
            '${item.id}: a check before its routine',
          );
          final day = dayOf(check.weeksAgo, check.weekday, item.id);
          if (day == null) continue;
          require(days.add(day), '${item.id}: two checks on ${day.toIso()}');
          checkModels.add(RoutineCheck(itemId: item.id, day: day));
        }
        if (item.checkedToday) {
          checkModels.add(RoutineCheck(itemId: item.id, day: today));
        }
      }
    }

    requireUnique(goals.map((g) => g.id), 'goal');
    final habitIds = {for (final habit in habits) habit.id};
    final goalModels = [
      for (final goal in goals)
        () {
          requireTitle(goal.title, 60, goal.id);
          require(
            goal.target >= 1 && goal.target <= 200,
            '${goal.id}: a target of 1–200',
          );
          require(
            goal.habitId == null || habitIds.contains(goal.habitId),
            '${goal.id}: unknown habit ${goal.habitId}',
          );
          require(goal.createdWeeksAgo >= 0, '${goal.id}: a future week');
          final created = today.weekStart.addDays(-7 * goal.createdWeeksAgo);
          return Goal(
            id: goal.id,
            title: goal.title,
            scope: switch (goal.habitId) {
              final habitId? => GoalScope.habit(habitId),
              null => const GoalScope.allHabits(),
            },
            period: goal.period,
            target: goal.target,
            createdOn: created,
            createdAt: instantOn(created),
          );
        }(),
    ];

    return UserData(
      habits: habitModels,
      logs: logModels,
      routines: routineModels,
      routineChecks: checkModels,
      goals: goalModels,
    );
  }

  static HabitSchedule _schedule(
    DemoScheduleDto schedule,
    String id,
    void Function(bool condition, String problem) require,
  ) {
    final DemoScheduleDto(:type, :weekdays, :times) = schedule;
    switch (type) {
      case DemoScheduleType.daily:
        require(weekdays.isEmpty && times == null, '$id: a mixed schedule');
        return const HabitSchedule.daily();
      case DemoScheduleType.onWeekdays:
        final days = weekdays.toSet();
        require(
          days.isNotEmpty &&
              days.length == weekdays.length &&
              days.every((d) => d >= 1 && d <= 7) &&
              times == null,
          '$id: weekdays 1–7, at least one, each once',
        );
        return HabitSchedule.onWeekdays(days);
      case DemoScheduleType.timesPerWeek:
        require(
          weekdays.isEmpty && times != null && times >= 1 && times <= 6,
          '$id: 1–6 times a week',
        );
        return HabitSchedule.timesPerWeek(times!);
    }
  }
}
