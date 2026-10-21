// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BackupDto _$BackupDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BackupDto', json, ($checkedConvert) {
      final val = BackupDto(
        exportedAt: $checkedConvert(
          'exportedAt',
          (v) => DateTime.parse(v as String),
        ),
        habits: $checkedConvert(
          'habits',
          (v) => (v as List<dynamic>)
              .map((e) => BackupHabitDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        logs: $checkedConvert(
          'logs',
          (v) => (v as List<dynamic>)
              .map((e) => BackupLogDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        routines: $checkedConvert(
          'routines',
          (v) => (v as List<dynamic>)
              .map((e) => BackupRoutineDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        routineChecks: $checkedConvert(
          'routineChecks',
          (v) => (v as List<dynamic>)
              .map(
                (e) =>
                    BackupRoutineCheckDto.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        goals: $checkedConvert(
          'goals',
          (v) => (v as List<dynamic>)
              .map((e) => BackupGoalDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        unlocks: $checkedConvert(
          'unlocks',
          (v) => (v as List<dynamic>)
              .map((e) => BackupUnlockDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        formatVersion: $checkedConvert(
          'formatVersion',
          (v) => (v as num?)?.toInt() ?? BackupDto.currentFormat,
        ),
      );
      return val;
    });

Map<String, dynamic> _$BackupDtoToJson(BackupDto instance) => <String, dynamic>{
  'formatVersion': instance.formatVersion,
  'exportedAt': instance.exportedAt.toIso8601String(),
  'habits': instance.habits.map((e) => e.toJson()).toList(),
  'logs': instance.logs.map((e) => e.toJson()).toList(),
  'routines': instance.routines.map((e) => e.toJson()).toList(),
  'routineChecks': instance.routineChecks.map((e) => e.toJson()).toList(),
  'goals': instance.goals.map((e) => e.toJson()).toList(),
  'unlocks': instance.unlocks.map((e) => e.toJson()).toList(),
};

BackupHabitDto _$BackupHabitDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BackupHabitDto', json, ($checkedConvert) {
  final val = BackupHabitDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
    category: $checkedConvert(
      'category',
      (v) => $enumDecode(_$HabitCategoryEnumMap, v),
    ),
    color: $checkedConvert('color', (v) => $enumDecode(_$HabitColorEnumMap, v)),
    icon: $checkedConvert('icon', (v) => $enumDecode(_$HabitIconEnumMap, v)),
    scheduleType: $checkedConvert(
      'scheduleType',
      (v) => $enumDecode(_$BackupScheduleTypeEnumMap, v),
    ),
    dailyTarget: $checkedConvert('dailyTarget', (v) => (v as num).toInt()),
    startDate: $checkedConvert('startDate', (v) => v as String),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
    weekdays: $checkedConvert(
      'weekdays',
      (v) =>
          (v as List<dynamic>?)?.map((e) => (e as num).toInt()).toList() ??
          const [],
    ),
    timesPerWeek: $checkedConvert('timesPerWeek', (v) => (v as num?)?.toInt()),
    reminder: $checkedConvert('reminder', (v) => v as String?),
    archivedAt: $checkedConvert(
      'archivedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$BackupHabitDtoToJson(BackupHabitDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$HabitCategoryEnumMap[instance.category]!,
      'color': _$HabitColorEnumMap[instance.color]!,
      'icon': _$HabitIconEnumMap[instance.icon]!,
      'scheduleType': _$BackupScheduleTypeEnumMap[instance.scheduleType]!,
      'weekdays': instance.weekdays,
      'timesPerWeek': instance.timesPerWeek,
      'dailyTarget': instance.dailyTarget,
      'startDate': instance.startDate,
      'reminder': instance.reminder,
      'archivedAt': instance.archivedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'sortOrder': instance.sortOrder,
    };

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

const _$BackupScheduleTypeEnumMap = {
  BackupScheduleType.daily: 'daily',
  BackupScheduleType.onWeekdays: 'onWeekdays',
  BackupScheduleType.timesPerWeek: 'timesPerWeek',
};

BackupLogDto _$BackupLogDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BackupLogDto', json, ($checkedConvert) {
      final val = BackupLogDto(
        habitId: $checkedConvert('habitId', (v) => v as String),
        day: $checkedConvert('day', (v) => v as String),
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        skipped: $checkedConvert('skipped', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$BackupLogDtoToJson(BackupLogDto instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'day': instance.day,
      'count': instance.count,
      'skipped': instance.skipped,
    };

BackupRoutineDto _$BackupRoutineDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BackupRoutineDto', json, ($checkedConvert) {
  final val = BackupRoutineDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    time: $checkedConvert('time', (v) => $enumDecode(_$RoutineTimeEnumMap, v)),
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>)
          .map((e) => BackupRoutineItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$BackupRoutineDtoToJson(BackupRoutineDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time': _$RoutineTimeEnumMap[instance.time]!,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'sortOrder': instance.sortOrder,
    };

const _$RoutineTimeEnumMap = {
  RoutineTime.morning: 'morning',
  RoutineTime.afternoon: 'afternoon',
  RoutineTime.evening: 'evening',
  RoutineTime.anytime: 'anytime',
};

BackupRoutineItemDto _$BackupRoutineItemDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BackupRoutineItemDto', json, ($checkedConvert) {
  final val = BackupRoutineItemDto(
    id: $checkedConvert('id', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BackupRoutineItemDtoToJson(
  BackupRoutineItemDto instance,
) => <String, dynamic>{'id': instance.id, 'title': instance.title};

BackupRoutineCheckDto _$BackupRoutineCheckDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('BackupRoutineCheckDto', json, ($checkedConvert) {
  final val = BackupRoutineCheckDto(
    itemId: $checkedConvert('itemId', (v) => v as String),
    day: $checkedConvert('day', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$BackupRoutineCheckDtoToJson(
  BackupRoutineCheckDto instance,
) => <String, dynamic>{'itemId': instance.itemId, 'day': instance.day};

BackupGoalDto _$BackupGoalDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BackupGoalDto', json, ($checkedConvert) {
      final val = BackupGoalDto(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        period: $checkedConvert(
          'period',
          (v) => $enumDecode(_$GoalPeriodEnumMap, v),
        ),
        target: $checkedConvert('target', (v) => (v as num).toInt()),
        createdOn: $checkedConvert('createdOn', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        habitId: $checkedConvert('habitId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BackupGoalDtoToJson(BackupGoalDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'habitId': instance.habitId,
      'period': _$GoalPeriodEnumMap[instance.period]!,
      'target': instance.target,
      'createdOn': instance.createdOn,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$GoalPeriodEnumMap = {
  GoalPeriod.daily: 'daily',
  GoalPeriod.weekly: 'weekly',
  GoalPeriod.monthly: 'monthly',
};

BackupUnlockDto _$BackupUnlockDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BackupUnlockDto', json, ($checkedConvert) {
      final val = BackupUnlockDto(
        achievementId: $checkedConvert('achievementId', (v) => v as String),
        unlockedOn: $checkedConvert('unlockedOn', (v) => v as String),
        unlockedAt: $checkedConvert(
          'unlockedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$BackupUnlockDtoToJson(BackupUnlockDto instance) =>
    <String, dynamic>{
      'achievementId': instance.achievementId,
      'unlockedOn': instance.unlockedOn,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
    };

BackupReceiptDto _$BackupReceiptDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BackupReceiptDto', json, ($checkedConvert) {
      final val = BackupReceiptDto(
        receivedAt: $checkedConvert(
          'receivedAt',
          (v) => DateTime.parse(v as String),
        ),
        habits: $checkedConvert('habits', (v) => (v as num).toInt()),
        logs: $checkedConvert('logs', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$BackupReceiptDtoToJson(BackupReceiptDto instance) =>
    <String, dynamic>{
      'receivedAt': instance.receivedAt.toIso8601String(),
      'habits': instance.habits,
      'logs': instance.logs,
    };
