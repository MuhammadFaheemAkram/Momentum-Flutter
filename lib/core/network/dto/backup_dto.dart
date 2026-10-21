import 'package:json_annotation/json_annotation.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'backup_dto.g.dart';

// A backup, as the app sends it: everything the user owns, with absolute
// dates (unlike the demo's relative ones). Days are `yyyy-MM-dd` text,
// times of day `HH:mm`, instants ISO-8601 in UTC.
//
// DTOs going *out* are mapped from domain models (data/mapper/
// backup_mappers.dart); `fromJson` exists so a backup can be read back,
// and so a test can prove every field survives the round trip.

@JsonSerializable(checked: true, explicitToJson: true)
class BackupDto {
  const BackupDto({
    required this.exportedAt,
    required this.habits,
    required this.logs,
    required this.routines,
    required this.routineChecks,
    required this.goals,
    required this.unlocks,
    this.formatVersion = BackupDto.currentFormat,
  });

  factory BackupDto.fromJson(Map<String, dynamic> json) =>
      _$BackupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupDtoToJson(this);

  static const currentFormat = 1;

  final int formatVersion;
  final DateTime exportedAt;
  final List<BackupHabitDto> habits;
  final List<BackupLogDto> logs;
  final List<BackupRoutineDto> routines;
  final List<BackupRoutineCheckDto> routineChecks;
  final List<BackupGoalDto> goals;
  final List<BackupUnlockDto> unlocks;
}

enum BackupScheduleType { daily, onWeekdays, timesPerWeek }

@JsonSerializable(checked: true, explicitToJson: true)
class BackupHabitDto {
  const BackupHabitDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.color,
    required this.icon,
    required this.scheduleType,
    required this.dailyTarget,
    required this.startDate,
    required this.createdAt,
    required this.sortOrder,
    this.weekdays = const [],
    this.timesPerWeek,
    this.reminder,
    this.archivedAt,
  });

  factory BackupHabitDto.fromJson(Map<String, dynamic> json) =>
      _$BackupHabitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupHabitDtoToJson(this);

  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final HabitColor color;
  final HabitIcon icon;
  final BackupScheduleType scheduleType;

  /// For `onWeekdays`: 1 (Monday) to 7 (Sunday).
  final List<int> weekdays;
  final int? timesPerWeek;
  final int dailyTarget;
  final String startDate;
  final String? reminder;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final int sortOrder;
}

@JsonSerializable(checked: true)
class BackupLogDto {
  const BackupLogDto({
    required this.habitId,
    required this.day,
    required this.count,
    required this.skipped,
  });

  factory BackupLogDto.fromJson(Map<String, dynamic> json) =>
      _$BackupLogDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupLogDtoToJson(this);

  final String habitId;
  final String day;
  final int count;
  final bool skipped;
}

@JsonSerializable(checked: true, explicitToJson: true)
class BackupRoutineDto {
  const BackupRoutineDto({
    required this.id,
    required this.title,
    required this.time,
    required this.items,
    required this.createdAt,
    required this.sortOrder,
  });

  factory BackupRoutineDto.fromJson(Map<String, dynamic> json) =>
      _$BackupRoutineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupRoutineDtoToJson(this);

  final String id;
  final String title;
  final RoutineTime time;

  /// In the routine's order.
  final List<BackupRoutineItemDto> items;
  final DateTime createdAt;
  final int sortOrder;
}

@JsonSerializable(checked: true)
class BackupRoutineItemDto {
  const BackupRoutineItemDto({required this.id, required this.title});

  factory BackupRoutineItemDto.fromJson(Map<String, dynamic> json) =>
      _$BackupRoutineItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupRoutineItemDtoToJson(this);

  final String id;
  final String title;
}

@JsonSerializable(checked: true)
class BackupRoutineCheckDto {
  const BackupRoutineCheckDto({required this.itemId, required this.day});

  factory BackupRoutineCheckDto.fromJson(Map<String, dynamic> json) =>
      _$BackupRoutineCheckDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupRoutineCheckDtoToJson(this);

  final String itemId;
  final String day;
}

@JsonSerializable(checked: true)
class BackupGoalDto {
  const BackupGoalDto({
    required this.id,
    required this.title,
    required this.period,
    required this.target,
    required this.createdOn,
    required this.createdAt,
    this.habitId,
  });

  factory BackupGoalDto.fromJson(Map<String, dynamic> json) =>
      _$BackupGoalDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupGoalDtoToJson(this);

  final String id;
  final String title;

  /// `null`: the goal counts every habit.
  final String? habitId;
  final GoalPeriod period;
  final int target;
  final String createdOn;
  final DateTime createdAt;
}

@JsonSerializable(checked: true)
class BackupUnlockDto {
  const BackupUnlockDto({
    required this.achievementId,
    required this.unlockedOn,
    required this.unlockedAt,
  });

  factory BackupUnlockDto.fromJson(Map<String, dynamic> json) =>
      _$BackupUnlockDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupUnlockDtoToJson(this);

  final String achievementId;
  final String unlockedOn;
  final DateTime unlockedAt;
}

/// What the service answers.
@JsonSerializable(checked: true)
class BackupReceiptDto {
  const BackupReceiptDto({
    required this.receivedAt,
    required this.habits,
    required this.logs,
  });

  factory BackupReceiptDto.fromJson(Map<String, dynamic> json) =>
      _$BackupReceiptDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BackupReceiptDtoToJson(this);

  final DateTime receivedAt;
  final int habits;
  final int logs;
}
