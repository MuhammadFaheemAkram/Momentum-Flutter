import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';

abstract interface class AchievementRepository {
  Stream<List<AchievementUnlock>> watchUnlocks();

  /// Records [ids] as unlocked today, once each; returns the ones that
  /// weren't unlocked already.
  Future<Result<List<AchievementId>>> recordUnlocks(List<AchievementId> ids);
}
