// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'routines_dao.dart';

// ignore_for_file: type=lint
mixin _$RoutinesDaoMixin on DatabaseAccessor<AppDatabase> {
  $RoutinesTable get routines => attachedDatabase.routines;
  $RoutineItemsTable get routineItems => attachedDatabase.routineItems;
  $RoutineChecksTable get routineChecks => attachedDatabase.routineChecks;
  RoutinesDaoManager get managers => RoutinesDaoManager(this);
}

class RoutinesDaoManager {
  final _$RoutinesDaoMixin _db;
  RoutinesDaoManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$RoutineItemsTableTableManager get routineItems =>
      $$RoutineItemsTableTableManager(_db.attachedDatabase, _db.routineItems);
  $$RoutineChecksTableTableManager get routineChecks =>
      $$RoutineChecksTableTableManager(_db.attachedDatabase, _db.routineChecks);
}
