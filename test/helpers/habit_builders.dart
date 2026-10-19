import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_log.dart';

// Short builders for the habit engine's tests. "Today" is Wednesday 21
// October 2026: its ISO week began on Monday the 19th.

final today = CalendarDate(2026, 10, 21);

/// A day of October 2026.
CalendarDate oct(int day) => CalendarDate(2026, 10, day);

const daily = HabitSchedule.daily();
const monWedFri = HabitSchedule.onWeekdays({1, 3, 5});

Habit habit({
  String id = 'h',
  HabitSchedule schedule = daily,
  CalendarDate? start,
  int target = 1,
  DateTime? archivedAt,
}) => Habit(
  id: id,
  title: 'Habit $id',
  category: HabitCategory.health,
  color: HabitColor.green,
  icon: HabitIcon.heart,
  schedule: schedule,
  dailyTarget: target,
  startDate: start ?? CalendarDate(2026, 9, 1),
  archivedAt: archivedAt,
  createdAt: DateTime.utc(2026, 9),
  sortOrder: 0,
);

HabitLog done(CalendarDate day, {String id = 'h', int count = 1}) =>
    HabitLog(habitId: id, day: day, count: count);

HabitLog skip(CalendarDate day, {String id = 'h'}) =>
    HabitLog(habitId: id, day: day, count: 0, skipped: true);

/// [done] on every day from [from] to [to].
List<HabitLog> doneEvery(
  CalendarDate from,
  CalendarDate to, {
  String id = 'h',
  int count = 1,
}) => [
  for (var day = from; day <= to; day = day.addDays(1))
    done(day, id: id, count: count),
];

HabitHistory history(Habit habit, [List<HabitLog> logs = const []]) =>
    HabitHistory(habit, logs);
