import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'achievements_state.freezed.dart';

enum AchievementsStatus { loading, ready, failed }

@freezed
abstract class AchievementsState with _$AchievementsState {
  const factory AchievementsState({
    @Default(AchievementsStatus.loading) AchievementsStatus status,
    CalendarDate? today,
    @Default(<AchievementStatus>[]) List<AchievementStatus> statuses,
  }) = _AchievementsState;

  const AchievementsState._();

  int get unlockedCount => statuses.where((s) => s.isUnlocked).length;

  /// Unlocked first, the most recent first; then the locked ones, closest
  /// to being earned first.
  List<AchievementStatus> get ordered {
    final unlocked = [...statuses.where((s) => s.isUnlocked)]
      ..sort((a, b) => b.unlock!.unlockedAt.compareTo(a.unlock!.unlockedAt));
    final locked = [...statuses.where((s) => !s.isUnlocked)]
      ..sort((a, b) => b.progress.ratio.compareTo(a.progress.ratio));
    return [...unlocked, ...locked];
  }
}
