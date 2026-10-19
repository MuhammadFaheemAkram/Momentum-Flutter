// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'goals_dao.dart';

// ignore_for_file: type=lint
mixin _$GoalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $GoalsTable get goals => attachedDatabase.goals;
  GoalsDaoManager get managers => GoalsDaoManager(this);
}

class GoalsDaoManager {
  final _$GoalsDaoMixin _db;
  GoalsDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db.attachedDatabase, _db.goals);
}
