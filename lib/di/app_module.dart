import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/daos/goals_dao.dart';
import 'package:momentum/core/database/daos/habit_logs_dao.dart';
import 'package:momentum/core/database/daos/habits_dao.dart';
import 'package:momentum/core/database/daos/routines_dao.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Registers types the app doesn't own, so they can be injected (and replaced
/// in tests) like everything else.
@module
abstract class AppModule {
  /// The asset bundle the fake service reads the demo from.
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  /// The current time, injected so tests can fix it (`Clock.fixed`): "today"
  /// decides every due habit, streak and demo date.
  @lazySingleton
  Clock get clock => const Clock();

  /// One database for the whole app. Several connections to the same SQLite
  /// file would break drift's change notifications.
  @lazySingleton
  AppDatabase get appDatabase => AppDatabase();

  @lazySingleton
  UserDataDao userDataDao(AppDatabase database) => database.userDataDao;

  @lazySingleton
  HabitsDao habitsDao(AppDatabase database) => database.habitsDao;

  @lazySingleton
  HabitLogsDao habitLogsDao(AppDatabase database) => database.habitLogsDao;

  @lazySingleton
  RoutinesDao routinesDao(AppDatabase database) => database.routinesDao;

  @lazySingleton
  GoalsDao goalsDao(AppDatabase database) => database.goalsDao;

  /// `@preResolve` awaits this before `runApp`, so preferences can be read
  /// synchronously from the first frame: the router knows at once whether
  /// to open Welcome or Today.
  @preResolve
  @lazySingleton
  Future<SharedPreferencesWithCache> get preferences =>
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: SettingsLocalDataSource.allowList,
        ),
      );
}
