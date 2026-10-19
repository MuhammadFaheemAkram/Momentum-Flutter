import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';

/// The window [period] covers on [today]:
/// - daily: today;
/// - weekly: the ISO week, Monday to Sunday (so "this week" is the same
///   seven days whatever the device's locale, as for weekly habits);
/// - monthly: the calendar month.
GoalWindow goalWindow(GoalPeriod period, CalendarDate today) =>
    switch (period) {
      GoalPeriod.daily => GoalWindow(start: today, end: today),
      GoalPeriod.weekly => GoalWindow(
        start: today.weekStart,
        end: today.weekStart.addDays(6),
      ),
      GoalPeriod.monthly => GoalWindow(
        start: today.monthStart,
        end: CalendarDate(
          today.year,
          today.month,
          CalendarDate.daysInMonth(today.year, today.month),
        ),
      ),
    };

/// [goal]'s progress now: the completions in its window up to today.
///
/// A completion is a habit's done day (its daily target reached): "8
/// glasses" counts once, however many check-ins it took. An all-habits goal
/// counts every habit's, a one-habit goal only that habit's. Nothing is
/// stored or reset: the next window simply counts from zero.
///
/// [histories] are every habit's, archived ones too: what they did in the
/// window still happened.
GoalProgress goalProgress(
  Goal goal,
  List<HabitHistory> histories, {
  required CalendarDate today,
}) {
  final window = goalWindow(goal.period, today);
  final counted = switch (goal.scope) {
    AllHabits() => histories,
    OneHabit(:final habitId) => [
      for (final history in histories)
        if (history.habit.id == habitId) history,
    ],
  };
  var current = 0;
  for (final history in counted) {
    for (
      var day = window.start;
      day <= today && day <= window.end;
      day = day.addDays(1)
    ) {
      if (history.isDoneOn(day)) current++;
    }
  }
  return GoalProgress(
    goal: goal,
    window: window,
    current: current,
    habitTitle: switch (goal.scope) {
      OneHabit() => counted.firstOrNull?.habit.title,
      AllHabits() => null,
    },
  );
}
