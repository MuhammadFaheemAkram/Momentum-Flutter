import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:momentum/background/background_entry.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/fake_momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/core/platform/local_notifications.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/data/repository/achievement_repository_impl.dart';
import 'package:momentum/data/repository/backup_repository_impl.dart';
import 'package:momentum/data/repository/habit_log_repository_impl.dart';
import 'package:momentum/data/repository/habit_repository_impl.dart';
import 'package:momentum/data/repository/routine_repository_impl.dart';
import 'package:momentum/data/repository/settings_repository_impl.dart';
import 'package:momentum/data/repository/user_data_repository_impl.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';
import 'package:momentum/domain/usecase/background_use_cases.dart';
import 'package:momentum/domain/usecase/backup_use_cases.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// What the background isolate needs: the same use cases the app runs, on
/// the same database file and preferences.
///
/// **Its own small graph, built by hand.** A background isolate shares no
/// memory with the app: `getIt` there is empty, and the app may not even be
/// running. The whole app graph (screens' Cubits, the router's settings
/// stream) would be wasted work in a job that has seconds to run, so this
/// builds only what the tasks use, from the same classes.
///
/// **The same database:** `AppDatabase` opens with `shareAcrossIsolates`,
/// so if the app is open too, both isolates talk to one drift server
/// isolate: writes never collide, and the app's screens see the
/// background's changes at once.
///
/// **Preferences** have a cache per isolate: what this one saves (a
/// backup's time) reaches the app when it reloads them, on resume.
final class BackgroundGraph {
  BackgroundGraph({
    required this.runTasks,
    required this.markDone,
    required this.syncNotifications,
    required this._close,
  });

  final RunBackgroundTasksUseCase runTasks;
  final MarkHabitDoneUseCase markDone;
  final SyncNotificationsUseCase syncNotifications;
  final Future<void> Function() _close;

  /// Closes the database connection and the settings.
  Future<void> close() => _close();

  static Future<BackgroundGraph> open() async {
    final database = AppDatabase();
    final preferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: SettingsLocalDataSource.allowList,
      ),
    );
    const clock = Clock();
    const calendar = CalendarClock(clock);
    final ids = IdGenerator();
    final settings = SettingsRepositoryImpl(
      SettingsLocalDataSource(preferences),
    );
    final habits = HabitRepositoryImpl(database.habitsDao, ids, clock);
    final logs = HabitLogRepositoryImpl(database.habitLogsDao);
    final routines = RoutineRepositoryImpl(database.routinesDao, ids, clock);
    final achievements = AchievementRepositoryImpl(
      database.achievementsDao,
      clock,
    );
    final service = FakeMomentumService(
      AssetJsonLoader(rootBundle),
      NetworkSimulator(),
      clock,
    );
    final sync = SyncNotificationsUseCase(
      settings,
      habits,
      logs,
      LocalNotifications(onBackgroundAction: onNotificationActionInBackground),
      clock,
    );
    final backUpNow = BackUpNowUseCase(
      UserDataRepositoryImpl(database.userDataDao),
      BackupRepositoryImpl(service, clock),
      settings,
    );
    return BackgroundGraph(
      runTasks: RunBackgroundTasksUseCase(
        EvaluateAchievementsUseCase(
          AchievementSources(habits, logs, routines, achievements, calendar),
          achievements,
        ),
        AutoBackupUseCase(backUpNow, settings, clock),
        sync,
      ),
      markDone: MarkHabitDoneUseCase(habits, logs, calendar),
      syncNotifications: sync,
      close: () async {
        await settings.dispose();
        await database.close();
      },
    );
  }
}
