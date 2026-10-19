import 'package:momentum/domain/calculation/completion_rate.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

/// [history]'s habit as it stands on [today].
HabitToday habitToday(HabitHistory history, {required CalendarDate today}) =>
    HabitToday(
      habit: history.habit,
      log: history.logOn(today),
      state: history.stateOn(today, today: today),
      due: history.isDue(today),
      streak: habitStreak(history, today: today),
    );

/// Today, for every habit that isn't archived, in the user's order. A habit
/// that starts later is listed as not due today.
TodayOverview buildTodayOverview(
  List<Habit> habits,
  List<HabitLog> logs, {
  required CalendarDate today,
}) {
  final histories = _histories(habits.where((h) => h.archivedAt == null), logs);
  final active = [
    for (final history in histories) habitToday(history, today: today),
  ];
  int rank(HabitToday habit) => switch (habit.state) {
    DayState.done => 1,
    DayState.skipped => 2,
    _ => 0,
  };
  final due = [
    for (final habit in active)
      if (habit.due ||
          habit.state == DayState.done ||
          habit.state == DayState.skipped)
        habit,
  ];
  // A stable sort: the user's order within each group.
  final ordered = [
    for (final group in [0, 1, 2]) ...due.where((h) => rank(h) == group),
  ];
  final dueToday = due.where((h) => h.state != DayState.skipped);
  return TodayOverview(
    today: today,
    summary: TodaySummary(
      due: dueToday.length,
      done: dueToday.where((h) => h.state == DayState.done).length,
      perfectDays: perfectDayStreak(histories, today: today),
      week: weekDots(histories, today: today),
    ),
    due: ordered,
    notDue: [
      for (final habit in active)
        if (!due.contains(habit)) habit,
    ],
  );
}

/// Every habit in [habits] as it stands on [today], archived ones included.
List<HabitToday> buildHabitList(
  List<Habit> habits,
  List<HabitLog> logs, {
  required CalendarDate today,
}) => [
  for (final history in _histories(habits, logs))
    habitToday(history, today: today),
];

/// Weeks in the heatmap, and bars in the chart.
const heatmapWeeks = 12;
const chartWeeks = 8;

/// One habit's page.
HabitDetail buildHabitDetail(
  Habit habit,
  List<HabitLog> logs, {
  required CalendarDate today,
}) {
  final history = HabitHistory(habit, logs);
  final firstWeek = today.weekStart.addDays(-7 * (heatmapWeeks - 1));
  return HabitDetail(
    habit: habit,
    today: today,
    streak: habitStreak(history, today: today),
    rate: completionRate(
      [history],
      from: habit.startDate,
      to: today,
      today: today,
    ),
    totalCompletions: history.totalCompletions,
    heatmap: [
      for (var i = 0; i < heatmapWeeks * 7; i++)
        () {
          final day = firstWeek.addDays(i);
          return HeatmapDay(
            day: day,
            state: history.stateOn(day, today: today),
            canSet: history.canSetDay(day, today: today),
          );
        }(),
    ],
    weeks: [
      for (var w = chartWeeks - 1; w >= 0; w--)
        _weekBar(history, today.weekStart.addDays(-7 * w), today: today),
    ],
  );
}

WeekBar _weekBar(
  HabitHistory history,
  CalendarDate weekStart, {
  required CalendarDate today,
}) {
  var done = 0;
  var due = 0;
  for (var i = 0; i < 7; i++) {
    final day = weekStart.addDays(i);
    if (!history.isActiveOn(day)) continue;
    if (history.isDoneOn(day) && day <= today) done++;
    if (_asksFor(history, day)) due++;
  }
  final target = switch (history.habit.schedule) {
    TimesPerWeek() => history.weekSlots(weekStart),
    Daily() || OnWeekdays() => due,
  };
  return WeekBar(weekStart: weekStart, done: done, target: target);
}

/// Whether [day] is one of a fixed-day habit's scheduled days. A skipped
/// day still counts toward the bar's target: the chart shows what the
/// schedule asked, and the skip shows as a shorter bar.
bool _asksFor(HabitHistory history, CalendarDate day) =>
    switch (history.habit.schedule) {
      Daily() => true,
      OnWeekdays(:final weekdays) => weekdays.contains(day.weekday),
      TimesPerWeek() => false,
    };

List<HabitHistory> _histories(Iterable<Habit> habits, List<HabitLog> logs) {
  final byHabit = <String, List<HabitLog>>{};
  for (final log in logs) {
    (byHabit[log.habitId] ??= []).add(log);
  }
  return [
    for (final habit in habits)
      HabitHistory(habit, byHabit[habit.id] ?? const []),
  ];
}
