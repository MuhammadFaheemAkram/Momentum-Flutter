import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/achievements_dao.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/repository/achievement_repository.dart';

@LazySingleton(as: AchievementRepository)
class AchievementRepositoryImpl implements AchievementRepository {
  const AchievementRepositoryImpl(this._achievements, this._clock);

  final AchievementsDao _achievements;
  final Clock _clock;

  @override
  Stream<List<AchievementUnlock>> watchUnlocks() =>
      _achievements.watchUnlocks().map(
        (rows) => [
          for (final row in rows)
            AchievementUnlock(
              achievementId: row.achievementId,
              unlockedOn: row.unlockedOn,
              unlockedAt: row.unlockedAt,
            ),
        ],
      );

  @override
  Future<Result<List<AchievementId>>> recordUnlocks(List<AchievementId> ids) =>
      guardWrite('Recording badges', () async {
        final now = _clock.now();
        final recorded = await _achievements.recordUnlocks(
          [for (final id in ids) id.name],
          day: CalendarDate.fromDateTime(now),
          at: now.toUtc(),
        );
        return [for (final name in recorded) AchievementId.byName(name)!];
      });
}
