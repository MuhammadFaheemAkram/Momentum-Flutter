import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';

part 'achievement.freezed.dart';

/// The badges. The rules live in code (`achievementProgress`); only the
/// moment each is earned is stored, by its `name` (renaming one is a schema
/// change). Like the other enums here, each carries its words.
enum AchievementId {
  firstStep('First step', 'Complete a habit for the first time.'),
  streak7('7-day streak', 'Keep a habit going 7 days in a row.'),
  streak30('30-day streak', 'Keep a habit going 30 days in a row.'),
  perfectWeek('Perfect week', 'Have 7 perfect days in a row.'),
  century('Century', 'Complete habits 100 times.'),
  earlyBird('Early bird', 'Finish a morning routine on 5 days.'),
  habitBuilder('Habit builder', 'Keep 5 habits going at once.'),
  consistencyMaster(
    'Consistency master',
    'Reach a consistency score of 80, with 30 days of history.',
  ),
  comeback('Comeback', 'Pick a habit up again after a week away.'),
  allRounder('All rounder', 'Complete habits in 5 different categories.');

  const AchievementId(this.title, this.description);

  final String title;
  final String description;

  static AchievementId? byName(String name) {
    for (final id in values) {
      if (id.name == name) return id;
    }
    return null;
  }
}

/// What a badge's progress counts.
enum AchievementMeasure {
  completions,
  streakDays,
  perfectDays,
  routineDays,
  habits,
  historyDays,
  score,
  comebacks,
  categories,
}

/// How far a badge's rule is from being met: [current] of [target].
@freezed
abstract class AchievementProgress with _$AchievementProgress {
  const factory AchievementProgress({
    required int current,
    required int target,
    required AchievementMeasure measure,
  }) = _AchievementProgress;

  const AchievementProgress._();

  bool get isMet => current >= target;

  double get ratio => (current / target).clamp(0, 1).toDouble();
}

/// A badge as it stands: its progress now, and its unlock if it was earned.
///
/// Once unlocked it stays unlocked, whatever the progress does later: "7-day
/// streak, unlocked 12 Oct" is still true after the streak breaks.
@freezed
abstract class AchievementStatus with _$AchievementStatus {
  const factory AchievementStatus({
    required AchievementId id,
    required AchievementProgress progress,
    AchievementUnlock? unlock,
  }) = _AchievementStatus;

  const AchievementStatus._();

  bool get isUnlocked => unlock != null;
}
