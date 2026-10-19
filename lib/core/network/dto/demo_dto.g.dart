// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'demo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DemoDto _$DemoDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoDto', json, ($checkedConvert) {
      final val = DemoDto(
        habits: $checkedConvert(
          'habits',
          (v) => (v as List<dynamic>)
              .map((e) => DemoHabitDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        routines: $checkedConvert(
          'routines',
          (v) => (v as List<dynamic>)
              .map((e) => DemoRoutineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        goals: $checkedConvert(
          'goals',
          (v) => (v as List<dynamic>)
              .map((e) => DemoGoalDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

DemoHabitDto _$DemoHabitDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DemoHabitDto', json, ($checkedConvert) {
  final val = DemoHabitDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$HabitCategoryEnumMap, v),
    ),
    color: $checkedConvert('color', (v) => $enumDecode(_$HabitColorEnumMap, v)),
    icon: $checkedConvert('icon', (v) => $enumDecode(_$HabitIconEnumMap, v)),
    schedule: $checkedConvert(
      'schedule',
      (v) => DemoScheduleDto.fromJson(v as Map<String, dynamic>),
    ),
    startWeeksAgo: $checkedConvert('startWeeksAgo', (v) => (v as num).toInt()),
    description: $checkedConvert('description', (v) => v as String? ?? ''),
    dailyTarget: $checkedConvert(
      'dailyTarget',
      (v) => (v as num?)?.toInt() ?? 1,
    ),
    reminder: $checkedConvert('reminder', (v) => v as String?),
    logs: $checkedConvert(
      'logs',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => DemoLogDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    ),
    today: $checkedConvert(
      'today',
      (v) =>
          v == null ? null : DemoTodayDto.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

const _$HabitCategoryEnumMap = {
  HabitCategory.health: 'health',
  HabitCategory.fitness: 'fitness',
  HabitCategory.learning: 'learning',
  HabitCategory.productivity: 'productivity',
  HabitCategory.reading: 'reading',
  HabitCategory.finance: 'finance',
  HabitCategory.personal: 'personal',
};

const _$HabitColorEnumMap = {
  HabitColor.green: 'green',
  HabitColor.teal: 'teal',
  HabitColor.blue: 'blue',
  HabitColor.indigo: 'indigo',
  HabitColor.purple: 'purple',
  HabitColor.pink: 'pink',
  HabitColor.orange: 'orange',
  HabitColor.amber: 'amber',
};

const _$HabitIconEnumMap = {
  HabitIcon.water: 'water',
  HabitIcon.run: 'run',
  HabitIcon.book: 'book',
  HabitIcon.language: 'language',
  HabitIcon.savings: 'savings',
  HabitIcon.checklist: 'checklist',
  HabitIcon.meditation: 'meditation',
  HabitIcon.sleep: 'sleep',
  HabitIcon.fitness: 'fitness',
  HabitIcon.heart: 'heart',
  HabitIcon.music: 'music',
  HabitIcon.code: 'code',
};

DemoScheduleDto _$DemoScheduleDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoScheduleDto', json, ($checkedConvert) {
      final val = DemoScheduleDto(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$DemoScheduleTypeEnumMap, v),
        ),
        weekdays: $checkedConvert(
          'weekdays',
          (v) =>
              (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ??
              const [],
        ),
        times: $checkedConvert('times', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

const _$DemoScheduleTypeEnumMap = {
  DemoScheduleType.daily: 'daily',
  DemoScheduleType.onWeekdays: 'onWeekdays',
  DemoScheduleType.timesPerWeek: 'timesPerWeek',
};

DemoLogDto _$DemoLogDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoLogDto', json, ($checkedConvert) {
      final val = DemoLogDto(
        weeksAgo: $checkedConvert('weeksAgo', (v) => (v as num).toInt()),
        weekday: $checkedConvert('weekday', (v) => (v as num).toInt()),
        count: $checkedConvert('count', (v) => (v as num?)?.toInt() ?? 0),
        skipped: $checkedConvert('skipped', (v) => v as bool? ?? false),
      );
      return val;
    });

DemoTodayDto _$DemoTodayDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoTodayDto', json, ($checkedConvert) {
      final val = DemoTodayDto(
        count: $checkedConvert('count', (v) => (v as num?)?.toInt() ?? 0),
        skipped: $checkedConvert('skipped', (v) => v as bool? ?? false),
      );
      return val;
    });

DemoRoutineDto _$DemoRoutineDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('DemoRoutineDto', json, ($checkedConvert) {
  final val = DemoRoutineDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    time: $checkedConvert('time', (v) => $enumDecode(_$RoutineTimeEnumMap, v)),
    createdWeeksAgo: $checkedConvert(
      'createdWeeksAgo',
      (v) => (v as num).toInt(),
    ),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => DemoRoutineItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

const _$RoutineTimeEnumMap = {
  RoutineTime.morning: 'morning',
  RoutineTime.afternoon: 'afternoon',
  RoutineTime.evening: 'evening',
  RoutineTime.anytime: 'anytime',
};

DemoRoutineItemDto _$DemoRoutineItemDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoRoutineItemDto', json, ($checkedConvert) {
      final val = DemoRoutineItemDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        checks: $checkedConvert(
          'checks',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => DemoDayDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
        checkedToday: $checkedConvert(
          'checkedToday',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

DemoDayDto _$DemoDayDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoDayDto', json, ($checkedConvert) {
      final val = DemoDayDto(
        weeksAgo: $checkedConvert('weeksAgo', (v) => (v as num).toInt()),
        weekday: $checkedConvert('weekday', (v) => (v as num).toInt()),
      );
      return val;
    });

DemoGoalDto _$DemoGoalDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DemoGoalDto', json, ($checkedConvert) {
      final val = DemoGoalDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        period: $checkedConvert(
          'period',
          (v) => $enumDecode(_$GoalPeriodEnumMap, v),
        ),
        target: $checkedConvert('target', (v) => (v as num).toInt()),
        createdWeeksAgo: $checkedConvert(
          'createdWeeksAgo',
          (v) => (v as num).toInt(),
        ),
        habitId: $checkedConvert('habitId', (v) => v as String?),
      );
      return val;
    });

const _$GoalPeriodEnumMap = {
  GoalPeriod.daily: 'daily',
  GoalPeriod.weekly: 'weekly',
  GoalPeriod.monthly: 'monthly',
};
