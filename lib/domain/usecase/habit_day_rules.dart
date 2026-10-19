import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

/// The rules every change to a habit's day follows (complete, skip, undo,
/// backfill): the habit exists and isn't archived, and the day is between
/// its start and today, at most [HabitHistory.backfillDays] back. Returns
/// the habit, or throws the [AppException] that explains the refusal.
Future<Habit> checkHabitDay(
  HabitRepository habits,
  String habitId,
  CalendarDate day, {
  required CalendarDate today,
}) async {
  final habit = await habits.findHabit(habitId);
  if (habit == null) throw const NotFoundException('habit');
  if (habit.archivedAt != null) {
    throw const InvalidInputException('Unarchive the habit to change its days');
  }
  if (day > today) {
    throw const InvalidInputException("That day hasn't happened yet");
  }
  if (day < habit.startDate) {
    throw const InvalidInputException('That day is before the habit started');
  }
  if (day.daysUntil(today) > HabitHistory.backfillDays) {
    throw const InvalidInputException(
      'Only the last ${HabitHistory.backfillDays} days can be changed',
    );
  }
  return habit;
}
