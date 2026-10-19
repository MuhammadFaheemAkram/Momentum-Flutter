// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'user_data_dao.dart';

// ignore_for_file: type=lint
mixin _$UserDataDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $HabitLogsTable get habitLogs => attachedDatabase.habitLogs;
  $RoutinesTable get routines => attachedDatabase.routines;
  $RoutineItemsTable get routineItems => attachedDatabase.routineItems;
  $RoutineChecksTable get routineChecks => attachedDatabase.routineChecks;
  $GoalsTable get goals => attachedDatabase.goals;
  $AchievementUnlocksTable get achievementUnlocks =>
      attachedDatabase.achievementUnlocks;
  UserDataDaoManager get managers => UserDataDaoManager(this);
}

class UserDataDaoManager {
  final _$UserDataDaoMixin _db;
  UserDataDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db.attachedDatabase, _db.habitLogs);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$RoutineItemsTableTableManager get routineItems =>
      $$RoutineItemsTableTableManager(_db.attachedDatabase, _db.routineItems);
  $$RoutineChecksTableTableManager get routineChecks =>
      $$RoutineChecksTableTableManager(_db.attachedDatabase, _db.routineChecks);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
  $$AchievementUnlocksTableTableManager get achievementUnlocks =>
      $$AchievementUnlocksTableTableManager(
        _db.attachedDatabase,
        _db.achievementUnlocks,
      );
}
