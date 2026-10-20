import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'achievements_dao.g.dart';

@DriftAccessor(tables: [AchievementUnlocks])
class AchievementsDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementsDaoMixin {
  AchievementsDao(super.attachedDatabase);

  Stream<List<AchievementUnlockRow>> watchUnlocks() =>
      (select(achievementUnlocks)..orderBy([
            (t) => OrderingTerm(expression: t.unlockedAt),
            (t) => OrderingTerm(expression: t.achievementId),
          ]))
          .watch();

  /// Records [ids] as unlocked on [day], once each: in one transaction, it
  /// reads what's unlocked already and inserts the rest, so two evaluations
  /// racing each other (the app and a background task) can't both claim a
  /// badge. Returns the ids it actually recorded.
  Future<List<String>> recordUnlocks(
    List<String> ids, {
    required CalendarDate day,
    required DateTime at,
  }) {
    return transaction(() async {
      final existing = {
        for (final row in await select(achievementUnlocks).get())
          row.achievementId,
      };
      final fresh = [
        for (final id in ids)
          if (!existing.contains(id)) id,
      ];
      for (final id in fresh) {
        await into(achievementUnlocks).insert(
          AchievementUnlocksCompanion.insert(
            achievementId: id,
            unlockedOn: day,
            unlockedAt: at,
          ),
        );
      }
      return fresh;
    });
  }
}
