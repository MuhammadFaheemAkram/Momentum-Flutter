import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:momentum/core/database/converters.dart';
import 'package:momentum/core/database/daos/habit_logs_dao.dart';
import 'package:momentum/core/database/daos/habits_dao.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'app_database.g.dart';

/// The app's SQLite database: the source of truth for everything the user
/// owns (habits and their logs, routines, goals, earned badges).
///
/// Every figure on screen (streaks, rates, goal progress, scores) is
/// calculated from these rows when it is read.
///
/// This file and the rest of `core/database/` never import `material_ui` or
/// the JSON packages: drift exports `Table`, `Column` and `JsonKey`, and
/// those names would clash (conventions §11.1).
@DriftDatabase(
  tables: [
    Habits,
    HabitLogs,
    Routines,
    RoutineItems,
    RoutineChecks,
    Goals,
    AchievementUnlocks,
  ],
  daos: [UserDataDao, HabitsDao, HabitLogsDao],
)
class AppDatabase extends _$AppDatabase {
  /// Opens `momentum.sqlite` in the app's documents directory. Tests pass an
  /// in-memory [executor] instead.
  ///
  /// `shareAcrossIsolates`: from Phase 6, background work runs in a second
  /// isolate (`workmanager`) while the app may be open. With this option
  /// both isolates talk to one drift server that owns the only connection,
  /// so they never write the file at once, and each sees the other's
  /// changes in its streams.
  AppDatabase([QueryExecutor? executor])
    : super(
        executor ??
            driftDatabase(
              name: 'momentum',
              native: const DriftNativeOptions(shareAcrossIsolates: true),
            ),
      );

  /// Each phase is treated as a release: a phase that changes the schema
  /// bumps this, exports the new version (`drift_dev make-migrations`) and
  /// ships a tested migration.
  ///
  /// 1. Phase 2: every table.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // SQLite ships with foreign keys *off*, per connection. Without this
    // pragma, every REFERENCES and CASCADE would be ignored.
    beforeOpen: (details) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
