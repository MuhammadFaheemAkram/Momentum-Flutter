import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/streaks.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

// How the domain reads on screen. Text lives in the UI layer, never in the
// domain.

/// "1 habit", "12 habits".
String countLabel(int count, String singular, [String? plural]) =>
    '$count ${count == 1 ? singular : (plural ?? '${singular}s')}';

const _weekdayShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _weekdayLong = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

/// "Mon" for 1 … "Sun" for 7.
String weekdayShort(int weekday) => _weekdayShort[weekday - 1];

/// "Monday" for 1 … "Sunday" for 7.
String weekdayLong(int weekday) => _weekdayLong[weekday - 1];

/// "Daily", "Mon · Wed · Fri", "Weekdays", "3× a week", then "· 8 a day"
/// for a counted habit.
String scheduleLabel(HabitSchedule schedule, {int dailyTarget = 1}) {
  final days = switch (schedule) {
    Daily() => 'Daily',
    OnWeekdays(:final weekdays) when weekdays.length == 7 => 'Every day',
    OnWeekdays(:final weekdays)
        when weekdays.length == 5 &&
            !weekdays.contains(6) &&
            !weekdays.contains(7) =>
      'Weekdays',
    OnWeekdays(:final weekdays)
        when weekdays.length == 2 && weekdays.containsAll({6, 7}) =>
      'Weekends',
    OnWeekdays(:final weekdays) => ([
      ...weekdays,
    ]..sort()).map(weekdayShort).join(' · '),
    TimesPerWeek(:final times) => '$times× a week',
  };
  return dailyTarget > 1 ? '$days · $dailyTarget a day' : days;
}

/// "4-day streak", "2-week streak", or null with none.
String? streakLabel(HabitStreak streak) => switch (streak.current) {
  0 => null,
  final n => '$n-${streak.unit == StreakUnit.days ? 'day' : 'week'} streak',
};

/// "4 days", "1 week".
String streakLength(int length, StreakUnit unit) =>
    countLabel(length, unit == StreakUnit.days ? 'day' : 'week');

extension DayStateLabel on DayState {
  /// The word a day's state is shown with, beside its color and icon.
  String get label => switch (this) {
    DayState.done => 'Done',
    DayState.partial => 'Partly done',
    DayState.skipped => 'Skipped',
    DayState.missed => 'Missed',
    DayState.open => 'To do',
    DayState.none => 'Nothing due',
    DayState.future => 'Still to come',
  };
}

extension HabitColorLabel on HabitColor {
  String get label => switch (this) {
    HabitColor.green => 'Green',
    HabitColor.teal => 'Teal',
    HabitColor.blue => 'Blue',
    HabitColor.indigo => 'Indigo',
    HabitColor.purple => 'Purple',
    HabitColor.pink => 'Pink',
    HabitColor.orange => 'Orange',
    HabitColor.amber => 'Amber',
  };
}

extension HabitIconLabel on HabitIcon {
  String get label => switch (this) {
    HabitIcon.water => 'Water',
    HabitIcon.run => 'Running',
    HabitIcon.book => 'Book',
    HabitIcon.language => 'Language',
    HabitIcon.savings => 'Savings',
    HabitIcon.checklist => 'Checklist',
    HabitIcon.meditation => 'Meditation',
    HabitIcon.sleep => 'Sleep',
    HabitIcon.fitness => 'Workout',
    HabitIcon.heart => 'Heart',
    HabitIcon.music => 'Music',
    HabitIcon.code => 'Code',
  };
}

extension GoalPeriodLabel on GoalPeriod {
  /// "today", "this week", "this month".
  String get current => switch (this) {
    GoalPeriod.daily => 'today',
    GoalPeriod.weekly => 'this week',
    GoalPeriod.monthly => 'this month',
  };
}
