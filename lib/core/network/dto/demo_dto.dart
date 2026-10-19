import 'package:json_annotation/json_annotation.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'demo_dto.g.dart';

// The demo, as the fake service sends it.
//
// Dates are relative, so the demo always shows live streaks. But not days
// ago: "3 days ago" falls on a different weekday every day, and a
// Mon / Wed / Fri habit's runs would drift off its schedule. So a day is a
// weekday of an ISO week counted back from this one (`weeksAgo`,
// `weekday`). The file describes whole weeks: days still to come this week,
// and today itself, are left out, and each habit's and item's `today` says
// how today stands.
//
// `checked: true` turns a missing or mistyped field into a
// `CheckedFromJsonException`, which the repository reports as damaged data.

@JsonSerializable(createToJson: false, checked: true)
class DemoDto {
  const DemoDto({
    required this.habits,
    required this.routines,
    required this.goals,
  });

  factory DemoDto.fromJson(Map<String, dynamic> json) =>
      _$DemoDtoFromJson(json);

  final List<DemoHabitDto> habits;
  final List<DemoRoutineDto> routines;
  final List<DemoGoalDto> goals;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoHabitDto {
  const DemoHabitDto({
    required this.id,
    required this.title,
    required this.category,
    required this.color,
    required this.icon,
    required this.schedule,
    required this.startWeeksAgo,
    this.description = '',
    this.dailyTarget = 1,
    this.reminder,
    this.logs = const [],
    this.today,
  });

  factory DemoHabitDto.fromJson(Map<String, dynamic> json) =>
      _$DemoHabitDtoFromJson(json);

  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final HabitColor color;
  final HabitIcon icon;
  final DemoScheduleDto schedule;
  final int dailyTarget;

  /// The habit starts on the Monday of this week.
  final int startWeeksAgo;

  /// `HH:mm`.
  final String? reminder;
  final List<DemoLogDto> logs;

  /// Today's log, if any.
  final DemoTodayDto? today;
}

enum DemoScheduleType { daily, onWeekdays, timesPerWeek }

@JsonSerializable(createToJson: false, checked: true)
class DemoScheduleDto {
  const DemoScheduleDto({
    required this.type,
    this.weekdays = const [],
    this.times,
  });

  factory DemoScheduleDto.fromJson(Map<String, dynamic> json) =>
      _$DemoScheduleDtoFromJson(json);

  final DemoScheduleType type;

  /// For `onWeekdays`: 1 (Monday) to 7 (Sunday).
  final List<int> weekdays;

  /// For `timesPerWeek`.
  final int? times;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoLogDto {
  const DemoLogDto({
    required this.weeksAgo,
    required this.weekday,
    this.count = 0,
    this.skipped = false,
  });

  factory DemoLogDto.fromJson(Map<String, dynamic> json) =>
      _$DemoLogDtoFromJson(json);

  final int weeksAgo;
  final int weekday;
  final int count;
  final bool skipped;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoTodayDto {
  const DemoTodayDto({this.count = 0, this.skipped = false});

  factory DemoTodayDto.fromJson(Map<String, dynamic> json) =>
      _$DemoTodayDtoFromJson(json);

  final int count;
  final bool skipped;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoRoutineDto {
  const DemoRoutineDto({
    required this.id,
    required this.title,
    required this.time,
    required this.createdWeeksAgo,
    required this.items,
  });

  factory DemoRoutineDto.fromJson(Map<String, dynamic> json) =>
      _$DemoRoutineDtoFromJson(json);

  final String id;
  final String title;
  final RoutineTime time;
  final int createdWeeksAgo;
  final List<DemoRoutineItemDto> items;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoRoutineItemDto {
  const DemoRoutineItemDto({
    required this.id,
    required this.title,
    this.checks = const [],
    this.checkedToday = false,
  });

  factory DemoRoutineItemDto.fromJson(Map<String, dynamic> json) =>
      _$DemoRoutineItemDtoFromJson(json);

  final String id;
  final String title;
  final List<DemoDayDto> checks;
  final bool checkedToday;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoDayDto {
  const DemoDayDto({required this.weeksAgo, required this.weekday});

  factory DemoDayDto.fromJson(Map<String, dynamic> json) =>
      _$DemoDayDtoFromJson(json);

  final int weeksAgo;
  final int weekday;
}

@JsonSerializable(createToJson: false, checked: true)
class DemoGoalDto {
  const DemoGoalDto({
    required this.id,
    required this.title,
    required this.period,
    required this.target,
    required this.createdWeeksAgo,
    this.habitId,
  });

  factory DemoGoalDto.fromJson(Map<String, dynamic> json) =>
      _$DemoGoalDtoFromJson(json);

  final String id;
  final String title;

  /// The habit it counts, or null for all habits.
  final String? habitId;
  final GoalPeriod period;
  final int target;
  final int createdWeeksAgo;
}
