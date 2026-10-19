import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';

/// Sample data for database and mapper tests, as of Wednesday 21 October
/// 2026.
final fixtureDay = CalendarDate(2026, 10, 21);
final fixtureAt = DateTime.utc(2026, 10, 21, 13);

Habit habitFixture({
  String id = 'h',
  HabitSchedule schedule = const HabitSchedule.daily(),
  int dailyTarget = 1,
  TimeOfDayValue? reminder,
  DateTime? archivedAt,
  int sortOrder = 0,
}) => Habit(
  id: id,
  title: 'Habit $id',
  category: HabitCategory.health,
  color: HabitColor.teal,
  icon: HabitIcon.water,
  schedule: schedule,
  dailyTarget: dailyTarget,
  startDate: fixtureDay.addDays(-30),
  reminder: reminder,
  archivedAt: archivedAt,
  createdAt: fixtureAt,
  sortOrder: sortOrder,
);

/// Something in every table, using every optional field and every case of
/// every sealed type at least once.
UserData fullUserData() => UserData(
  habits: [
    habitFixture(
      id: 'water',
      dailyTarget: 8,
      reminder: TimeOfDayValue(10, 0),
    ).copyWith(description: 'A glass at a time.'),
    habitFixture(
      id: 'run',
      schedule: const HabitSchedule.onWeekdays({1, 3, 5}),
      sortOrder: 1,
    ).copyWith(
      category: HabitCategory.fitness,
      color: HabitColor.orange,
      icon: HabitIcon.run,
    ),
    habitFixture(
      id: 'spanish',
      schedule: const HabitSchedule.timesPerWeek(5),
      archivedAt: DateTime.utc(2026, 10, 20, 9, 30, 15, 250),
      sortOrder: 2,
    ),
  ],
  // In key order (habit, day): the order a read returns them in.
  logs: [
    HabitLog(
      habitId: 'run',
      day: fixtureDay.addDays(-2),
      count: 0,
      skipped: true,
    ),
    HabitLog(habitId: 'water', day: fixtureDay.addDays(-1), count: 9),
    HabitLog(habitId: 'water', day: fixtureDay, count: 3),
  ],
  routines: [
    Routine(
      id: 'morning',
      title: 'Morning',
      time: RoutineTime.morning,
      items: const [
        RoutineItem(id: 'bed', title: 'Make the bed'),
        RoutineItem(id: 'stretch', title: 'Stretch'),
        RoutineItem(id: 'plan', title: 'Plan the day'),
      ],
      createdAt: fixtureAt,
      sortOrder: 0,
    ),
  ],
  routineChecks: [
    RoutineCheck(itemId: 'bed', day: fixtureDay),
    RoutineCheck(itemId: 'stretch', day: fixtureDay.addDays(-1)),
  ],
  goals: [
    Goal(
      id: 'week',
      title: 'Complete 25 habits this week',
      scope: const GoalScope.allHabits(),
      period: GoalPeriod.weekly,
      target: 25,
      createdOn: fixtureDay.addDays(-14),
      createdAt: fixtureAt,
    ),
    Goal(
      id: 'read',
      title: 'Water on 20 days',
      scope: const GoalScope.habit('water'),
      period: GoalPeriod.monthly,
      target: 20,
      createdOn: fixtureDay.addDays(-7),
      createdAt: fixtureAt.add(const Duration(minutes: 1, microseconds: 1)),
    ),
  ],
  unlocks: [
    AchievementUnlock(
      achievementId: 'first_step',
      unlockedOn: fixtureDay.addDays(-20),
      unlockedAt: DateTime.utc(2026, 10, 1, 7, 45),
    ),
  ],
);
