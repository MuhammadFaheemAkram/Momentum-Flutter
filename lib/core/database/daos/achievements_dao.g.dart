// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'achievements_dao.dart';

// ignore_for_file: type=lint
mixin _$AchievementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AchievementUnlocksTable get achievementUnlocks =>
      attachedDatabase.achievementUnlocks;
  AchievementsDaoManager get managers => AchievementsDaoManager(this);
}

class AchievementsDaoManager {
  final _$AchievementsDaoMixin _db;
  AchievementsDaoManager(this._db);
  $$AchievementUnlocksTableTableManager get achievementUnlocks =>
      $$AchievementUnlocksTableTableManager(
        _db.attachedDatabase,
        _db.achievementUnlocks,
      );
}
