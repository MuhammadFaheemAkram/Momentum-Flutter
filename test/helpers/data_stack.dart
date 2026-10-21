import 'dart:math';

import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/fake_momentum_service.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/data/repository/achievement_repository_impl.dart';
import 'package:momentum/data/repository/backup_repository_impl.dart';
import 'package:momentum/data/repository/demo_repository_impl.dart';
import 'package:momentum/data/repository/goal_repository_impl.dart';
import 'package:momentum/data/repository/habit_log_repository_impl.dart';
import 'package:momentum/data/repository/habit_repository_impl.dart';
import 'package:momentum/data/repository/routine_repository_impl.dart';
import 'package:momentum/data/repository/search_repository_impl.dart';
import 'package:momentum/data/repository/user_data_repository_impl.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';
import 'package:momentum/domain/usecase/analytics_search_use_cases.dart';
import 'package:momentum/domain/usecase/background_use_cases.dart';
import 'package:momentum/domain/usecase/backup_use_cases.dart';
import 'package:momentum/domain/usecase/goal_use_cases.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/habit_use_cases.dart';
import 'package:momentum/domain/usecase/load_demo_use_case.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';
import 'package:momentum/domain/usecase/routine_use_cases.dart';
import 'package:momentum/domain/usecase/start_empty_use_case.dart';
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart';
import 'package:momentum/features/habit_actions/habit_day_actions.dart';

import 'database.dart';
import 'fakes/fake_notification_scheduler.dart';
import 'fakes/fake_recent_searches_repository.dart';
import 'fakes/fake_settings_repository.dart';
import 'test_dependencies.dart';

/// The real repositories and use cases on an in-memory database, with a
/// fixed clock and the real fake service (zero latency, reading the bundled
/// JSON): what Cubit and repository tests run against instead of mocks.
///
/// Tests that read the bundled assets need
/// `TestWidgetsFlutterBinding.ensureInitialized()`.
class DataStack {
  DataStack({DateTime? now, MomentumService? service})
    : clock = Clock.fixed(now ?? demoNow),
      network = NetworkSimulator(latency: Duration.zero) {
    this.service =
        service ??
        FakeMomentumService(AssetJsonLoader(rootBundle), network, clock);
  }

  final Clock clock;
  final NetworkSimulator network;
  late final MomentumService service;
  final AppDatabase db = newTestDatabase();
  final settings = FakeSettingsRepository();

  late final demo = DemoRepositoryImpl(service, db.userDataDao, clock);

  late final loadDemo = LoadDemoUseCase(demo, settings);
  late final startEmpty = StartEmptyUseCase(settings);

  late final calendar = CalendarClock(clock);

  /// Seeded, so ids repeat from run to run.
  late final ids = IdGenerator(random: Random(1));
  late final habits = HabitRepositoryImpl(db.habitsDao, ids, clock);
  late final logs = HabitLogRepositoryImpl(db.habitLogsDao);
  late final routines = RoutineRepositoryImpl(db.routinesDao, ids, clock);
  late final goals = GoalRepositoryImpl(db.goalsDao, ids, clock);
  late final achievements = AchievementRepositoryImpl(
    db.achievementsDao,
    clock,
  );
  late final search = SearchRepositoryImpl(db.searchDao);
  final recentSearches = FakeRecentSearchesRepository();

  late final findHabit = FindHabitUseCase(habits);
  late final saveHabit = SaveHabitUseCase(habits);
  late final setArchived = SetHabitArchivedUseCase(habits);
  late final deleteHabit = DeleteHabitUseCase(habits);
  late final addCheckIn = AddCheckInUseCase(habits, logs, calendar);
  late final skipHabit = SkipHabitUseCase(habits, logs, calendar);
  late final clearDay = ClearHabitDayUseCase(habits, logs, calendar);
  late final setDay = SetHabitDayUseCase(habits, logs, calendar);
  late final restoreDay = RestoreHabitDayUseCase(habits, logs, calendar);
  late final watchToday = WatchTodayUseCase(
    habits,
    logs,
    routines,
    goals,
    calendar,
  );
  late final watchHabits = WatchHabitsUseCase(habits, logs, calendar);
  late final watchDetail = WatchHabitDetailUseCase(habits, logs, calendar);
  late final watchRoutines = WatchRoutinesUseCase(routines, calendar);
  late final findRoutine = FindRoutineUseCase(routines);
  late final saveRoutine = SaveRoutineUseCase(routines);
  late final deleteRoutine = DeleteRoutineUseCase(routines);
  late final toggleRoutineItem = ToggleRoutineItemUseCase(routines, calendar);
  late final watchGoals = WatchGoalsUseCase(goals, habits, logs, calendar);
  late final saveGoal = SaveGoalUseCase(goals);
  late final deleteGoal = DeleteGoalUseCase(goals);
  late final achievementSources = AchievementSources(
    habits,
    logs,
    routines,
    achievements,
    calendar,
  );
  late final watchAchievements = WatchAchievementsUseCase(achievementSources);
  late final evaluateAchievements = EvaluateAchievementsUseCase(
    achievementSources,
    achievements,
  );

  /// Settles in 10 ms, not the app's 300: real-time tests stay quick.
  late final watchNewAchievements = WatchNewAchievementsUseCase(
    achievementSources,
    achievements,
    settle: const Duration(milliseconds: 10),
  );
  late final watchAnalytics = WatchAnalyticsUseCase(habits, logs, calendar);
  late final watchSearchResults = WatchSearchResultsUseCase(search);
  late final watchRecentSearches = WatchRecentSearchesUseCase(recentSearches);
  late final saveRecentSearch = SaveRecentSearchUseCase(recentSearches);
  late final clearRecentSearches = ClearRecentSearchesUseCase(recentSearches);
  late final markDone = MarkHabitDoneUseCase(habits, logs, calendar);

  /// The device's notifications: none allowed until asked.
  final notifications = FakeNotificationScheduler();
  late final syncNotifications = SyncNotificationsUseCase(
    settings,
    habits,
    logs,
    notifications,
    clock,
  );

  /// Settles in 10 ms, like [watchNewAchievements].
  late final keepNotificationsInSync = KeepNotificationsInSyncUseCase(
    syncNotifications,
    habits,
    logs,
    settings,
    calendar,
    settle: const Duration(milliseconds: 10),
  );
  late final setNotificationsEnabled = SetNotificationsEnabledUseCase(
    settings,
    notifications,
  );
  late final previewPlan = PreviewNotificationPlanUseCase(
    settings,
    habits,
    logs,
    notifications,
    clock,
  );
  late final userData = UserDataRepositoryImpl(db.userDataDao);
  late final backups = BackupRepositoryImpl(service, clock);
  late final backUpNow = BackUpNowUseCase(userData, backups, settings);
  late final autoBackup = AutoBackupUseCase(backUpNow, settings, clock);
  late final resetProgress = ResetProgressUseCase(userData);
  late final runBackgroundTasks = RunBackgroundTasksUseCase(
    evaluateAchievements,
    autoBackup,
    syncNotifications,
  );

  late final dayActions = HabitDayActions(
    addCheckIn,
    skipHabit,
    clearDay,
    restoreDay,
    setArchived,
  );

  /// Writes [data] as the user's data.
  Future<void> seed(UserData data) => db.userDataDao.replaceAll(data.toRows());

  Future<void> close() => db.close();
}

/// The demo that ships in `assets/json/demo.json`, as the fake service sends
/// it.
Future<DemoDto> bundledDemo() => FakeMomentumService(
  AssetJsonLoader(rootBundle),
  NetworkSimulator(latency: Duration.zero),
  const Clock(),
).fetchDemo();
