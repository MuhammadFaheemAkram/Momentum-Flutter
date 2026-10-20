// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:clock/clock.dart' as _i454;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:momentum/core/common/calendar_clock.dart' as _i600;
import 'package:momentum/core/common/id_generator.dart' as _i427;
import 'package:momentum/core/database/app_database.dart' as _i784;
import 'package:momentum/core/database/daos/achievements_dao.dart' as _i173;
import 'package:momentum/core/database/daos/goals_dao.dart' as _i958;
import 'package:momentum/core/database/daos/habit_logs_dao.dart' as _i245;
import 'package:momentum/core/database/daos/habits_dao.dart' as _i900;
import 'package:momentum/core/database/daos/routines_dao.dart' as _i874;
import 'package:momentum/core/database/daos/search_dao.dart' as _i327;
import 'package:momentum/core/database/daos/user_data_dao.dart' as _i688;
import 'package:momentum/core/network/asset_json_loader.dart' as _i1038;
import 'package:momentum/core/network/fake_momentum_service.dart' as _i254;
import 'package:momentum/core/network/momentum_service.dart' as _i102;
import 'package:momentum/core/network/network_simulator.dart' as _i879;
import 'package:momentum/core/storage/settings_local_data_source.dart' as _i325;
import 'package:momentum/data/repository/achievement_repository_impl.dart'
    as _i766;
import 'package:momentum/data/repository/demo_repository_impl.dart' as _i875;
import 'package:momentum/data/repository/goal_repository_impl.dart' as _i638;
import 'package:momentum/data/repository/habit_log_repository_impl.dart'
    as _i113;
import 'package:momentum/data/repository/habit_repository_impl.dart' as _i304;
import 'package:momentum/data/repository/recent_searches_repository_impl.dart'
    as _i125;
import 'package:momentum/data/repository/routine_repository_impl.dart' as _i928;
import 'package:momentum/data/repository/search_repository_impl.dart' as _i543;
import 'package:momentum/data/repository/settings_repository_impl.dart'
    as _i335;
import 'package:momentum/di/app_module.dart' as _i381;
import 'package:momentum/domain/repository/achievement_repository.dart'
    as _i206;
import 'package:momentum/domain/repository/demo_repository.dart' as _i752;
import 'package:momentum/domain/repository/goal_repository.dart' as _i388;
import 'package:momentum/domain/repository/habit_log_repository.dart' as _i1017;
import 'package:momentum/domain/repository/habit_repository.dart' as _i119;
import 'package:momentum/domain/repository/recent_searches_repository.dart'
    as _i639;
import 'package:momentum/domain/repository/routine_repository.dart' as _i715;
import 'package:momentum/domain/repository/search_repository.dart' as _i753;
import 'package:momentum/domain/repository/settings_repository.dart' as _i888;
import 'package:momentum/domain/usecase/achievement_use_cases.dart' as _i97;
import 'package:momentum/domain/usecase/analytics_search_use_cases.dart'
    as _i596;
import 'package:momentum/domain/usecase/goal_use_cases.dart' as _i188;
import 'package:momentum/domain/usecase/habit_day_use_cases.dart' as _i832;
import 'package:momentum/domain/usecase/habit_use_cases.dart' as _i265;
import 'package:momentum/domain/usecase/load_demo_use_case.dart' as _i989;
import 'package:momentum/domain/usecase/routine_use_cases.dart' as _i907;
import 'package:momentum/domain/usecase/start_empty_use_case.dart' as _i725;
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart' as _i642;
import 'package:momentum/features/achievements/cubit/achievements_cubit.dart'
    as _i234;
import 'package:momentum/features/analytics/cubit/analytics_cubit.dart'
    as _i127;
import 'package:momentum/features/goals/cubit/goals_cubit.dart' as _i700;
import 'package:momentum/features/habit_actions/habit_day_actions.dart'
    as _i1032;
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart'
    as _i994;
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart'
    as _i35;
import 'package:momentum/features/habits/cubit/habits_cubit.dart' as _i116;
import 'package:momentum/features/routine_editor/cubit/routine_editor_cubit.dart'
    as _i613;
import 'package:momentum/features/routines/cubit/routines_cubit.dart' as _i375;
import 'package:momentum/features/search/bloc/search_bloc.dart' as _i367;
import 'package:momentum/features/today/cubit/today_cubit.dart' as _i789;
import 'package:momentum/features/welcome/cubit/welcome_cubit.dart' as _i208;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i427.IdGenerator>(() => _i427.IdGenerator());
    gh.lazySingleton<_i879.NetworkSimulator>(() => _i879.NetworkSimulator());
    gh.lazySingleton<_i281.AssetBundle>(() => appModule.assetBundle);
    gh.lazySingleton<_i454.Clock>(() => appModule.clock);
    gh.lazySingleton<_i784.AppDatabase>(() => appModule.appDatabase);
    await gh.lazySingletonAsync<_i460.SharedPreferencesWithCache>(
      () => appModule.preferences,
      preResolve: true,
    );
    gh.lazySingleton<_i600.CalendarClock>(
      () => _i600.CalendarClock(gh<_i454.Clock>()),
    );
    gh.lazySingleton<_i325.SettingsLocalDataSource>(
      () =>
          _i325.SettingsLocalDataSource(gh<_i460.SharedPreferencesWithCache>()),
    );
    gh.lazySingleton<_i1038.AssetJsonLoader>(
      () => _i1038.AssetJsonLoader(gh<_i281.AssetBundle>()),
    );
    gh.lazySingleton<_i102.MomentumService>(
      () => _i254.FakeMomentumService(
        gh<_i1038.AssetJsonLoader>(),
        gh<_i879.NetworkSimulator>(),
      ),
    );
    gh.lazySingleton<_i688.UserDataDao>(
      () => appModule.userDataDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i900.HabitsDao>(
      () => appModule.habitsDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i245.HabitLogsDao>(
      () => appModule.habitLogsDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i874.RoutinesDao>(
      () => appModule.routinesDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i958.GoalsDao>(
      () => appModule.goalsDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i173.AchievementsDao>(
      () => appModule.achievementsDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i327.SearchDao>(
      () => appModule.searchDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i206.AchievementRepository>(
      () => _i766.AchievementRepositoryImpl(
        gh<_i173.AchievementsDao>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.lazySingleton<_i119.HabitRepository>(
      () => _i304.HabitRepositoryImpl(
        gh<_i900.HabitsDao>(),
        gh<_i427.IdGenerator>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.lazySingleton<_i753.SearchRepository>(
      () => _i543.SearchRepositoryImpl(gh<_i327.SearchDao>()),
    );
    gh.lazySingleton<_i388.GoalRepository>(
      () => _i638.GoalRepositoryImpl(
        gh<_i958.GoalsDao>(),
        gh<_i427.IdGenerator>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.lazySingleton<_i888.SettingsRepository>(
      () => _i335.SettingsRepositoryImpl(gh<_i325.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i639.RecentSearchesRepository>(
      () => _i125.RecentSearchesRepositoryImpl(
        gh<_i325.SettingsLocalDataSource>(),
      ),
    );
    gh.factory<_i265.FindHabitUseCase>(
      () => _i265.FindHabitUseCase(gh<_i119.HabitRepository>()),
    );
    gh.factory<_i265.SaveHabitUseCase>(
      () => _i265.SaveHabitUseCase(gh<_i119.HabitRepository>()),
    );
    gh.factory<_i265.SetHabitArchivedUseCase>(
      () => _i265.SetHabitArchivedUseCase(gh<_i119.HabitRepository>()),
    );
    gh.factory<_i265.DeleteHabitUseCase>(
      () => _i265.DeleteHabitUseCase(gh<_i119.HabitRepository>()),
    );
    gh.lazySingleton<_i1017.HabitLogRepository>(
      () => _i113.HabitLogRepositoryImpl(gh<_i245.HabitLogsDao>()),
    );
    gh.factory<_i596.WatchAnalyticsUseCase>(
      () => _i596.WatchAnalyticsUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i832.AddCheckInUseCase>(
      () => _i832.AddCheckInUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i832.SkipHabitUseCase>(
      () => _i832.SkipHabitUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i832.ClearHabitDayUseCase>(
      () => _i832.ClearHabitDayUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i832.SetHabitDayUseCase>(
      () => _i832.SetHabitDayUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i832.RestoreHabitDayUseCase>(
      () => _i832.RestoreHabitDayUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i642.WatchHabitsUseCase>(
      () => _i642.WatchHabitsUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i642.WatchHabitDetailUseCase>(
      () => _i642.WatchHabitDetailUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i188.SaveGoalUseCase>(
      () => _i188.SaveGoalUseCase(gh<_i388.GoalRepository>()),
    );
    gh.factory<_i188.DeleteGoalUseCase>(
      () => _i188.DeleteGoalUseCase(gh<_i388.GoalRepository>()),
    );
    gh.lazySingleton<_i752.DemoRepository>(
      () => _i875.DemoRepositoryImpl(
        gh<_i102.MomentumService>(),
        gh<_i688.UserDataDao>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.factory<_i596.WatchRecentSearchesUseCase>(
      () => _i596.WatchRecentSearchesUseCase(
        gh<_i639.RecentSearchesRepository>(),
      ),
    );
    gh.factory<_i596.SaveRecentSearchUseCase>(
      () => _i596.SaveRecentSearchUseCase(gh<_i639.RecentSearchesRepository>()),
    );
    gh.factory<_i596.ClearRecentSearchesUseCase>(
      () => _i596.ClearRecentSearchesUseCase(
        gh<_i639.RecentSearchesRepository>(),
      ),
    );
    gh.factory<_i188.WatchGoalsUseCase>(
      () => _i188.WatchGoalsUseCase(
        gh<_i388.GoalRepository>(),
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i127.AnalyticsCubit>(
      () => _i127.AnalyticsCubit(gh<_i596.WatchAnalyticsUseCase>()),
    );
    gh.factory<_i725.StartEmptyUseCase>(
      () => _i725.StartEmptyUseCase(gh<_i888.SettingsRepository>()),
    );
    gh.lazySingleton<_i715.RoutineRepository>(
      () => _i928.RoutineRepositoryImpl(
        gh<_i874.RoutinesDao>(),
        gh<_i427.IdGenerator>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.factory<_i1032.HabitDayActions>(
      () => _i1032.HabitDayActions(
        gh<_i832.AddCheckInUseCase>(),
        gh<_i832.SkipHabitUseCase>(),
        gh<_i832.ClearHabitDayUseCase>(),
        gh<_i832.RestoreHabitDayUseCase>(),
        gh<_i265.SetHabitArchivedUseCase>(),
      ),
    );
    gh.factory<_i907.FindRoutineUseCase>(
      () => _i907.FindRoutineUseCase(gh<_i715.RoutineRepository>()),
    );
    gh.factory<_i907.SaveRoutineUseCase>(
      () => _i907.SaveRoutineUseCase(gh<_i715.RoutineRepository>()),
    );
    gh.factory<_i907.DeleteRoutineUseCase>(
      () => _i907.DeleteRoutineUseCase(gh<_i715.RoutineRepository>()),
    );
    gh.factory<_i596.WatchSearchResultsUseCase>(
      () => _i596.WatchSearchResultsUseCase(gh<_i753.SearchRepository>()),
    );
    gh.factory<_i907.WatchRoutinesUseCase>(
      () => _i907.WatchRoutinesUseCase(
        gh<_i715.RoutineRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i907.ToggleRoutineItemUseCase>(
      () => _i907.ToggleRoutineItemUseCase(
        gh<_i715.RoutineRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factoryParam<_i35.HabitFormCubit, String?, dynamic>(
      (habitId, _) => _i35.HabitFormCubit(
        gh<_i265.FindHabitUseCase>(),
        gh<_i265.SaveHabitUseCase>(),
        gh<_i265.DeleteHabitUseCase>(),
        gh<_i600.CalendarClock>(),
        habitId,
      ),
    );
    gh.factory<_i97.AchievementSources>(
      () => _i97.AchievementSources(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i715.RoutineRepository>(),
        gh<_i206.AchievementRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i116.HabitsCubit>(
      () => _i116.HabitsCubit(
        gh<_i642.WatchHabitsUseCase>(),
        gh<_i1032.HabitDayActions>(),
      ),
    );
    gh.factoryParam<_i994.HabitDetailCubit, String, dynamic>(
      (habitId, _) => _i994.HabitDetailCubit(
        gh<_i642.WatchHabitDetailUseCase>(),
        gh<_i832.SetHabitDayUseCase>(),
        gh<_i265.SetHabitArchivedUseCase>(),
        gh<_i265.DeleteHabitUseCase>(),
        habitId,
      ),
    );
    gh.factory<_i989.LoadDemoUseCase>(
      () => _i989.LoadDemoUseCase(
        gh<_i752.DemoRepository>(),
        gh<_i888.SettingsRepository>(),
      ),
    );
    gh.factory<_i642.WatchTodayUseCase>(
      () => _i642.WatchTodayUseCase(
        gh<_i119.HabitRepository>(),
        gh<_i1017.HabitLogRepository>(),
        gh<_i715.RoutineRepository>(),
        gh<_i388.GoalRepository>(),
        gh<_i600.CalendarClock>(),
      ),
    );
    gh.factory<_i700.GoalsCubit>(
      () => _i700.GoalsCubit(
        gh<_i188.WatchGoalsUseCase>(),
        gh<_i188.SaveGoalUseCase>(),
        gh<_i188.DeleteGoalUseCase>(),
      ),
    );
    gh.factoryParam<_i613.RoutineEditorCubit, String?, dynamic>(
      (routineId, _) => _i613.RoutineEditorCubit(
        gh<_i907.FindRoutineUseCase>(),
        gh<_i907.SaveRoutineUseCase>(),
        gh<_i907.DeleteRoutineUseCase>(),
        gh<_i427.IdGenerator>(),
        routineId,
      ),
    );
    gh.factory<_i375.RoutinesCubit>(
      () => _i375.RoutinesCubit(
        gh<_i907.WatchRoutinesUseCase>(),
        gh<_i907.ToggleRoutineItemUseCase>(),
      ),
    );
    gh.factory<_i367.SearchBloc>(
      () => _i367.SearchBloc(
        gh<_i596.WatchSearchResultsUseCase>(),
        gh<_i596.WatchRecentSearchesUseCase>(),
        gh<_i596.SaveRecentSearchUseCase>(),
        gh<_i596.ClearRecentSearchesUseCase>(),
      ),
    );
    gh.factory<_i97.WatchAchievementsUseCase>(
      () => _i97.WatchAchievementsUseCase(gh<_i97.AchievementSources>()),
    );
    gh.factory<_i97.EvaluateAchievementsUseCase>(
      () => _i97.EvaluateAchievementsUseCase(
        gh<_i97.AchievementSources>(),
        gh<_i206.AchievementRepository>(),
      ),
    );
    gh.factory<_i97.WatchNewAchievementsUseCase>(
      () => _i97.WatchNewAchievementsUseCase(
        gh<_i97.AchievementSources>(),
        gh<_i206.AchievementRepository>(),
      ),
    );
    gh.factory<_i789.TodayCubit>(
      () => _i789.TodayCubit(
        gh<_i642.WatchTodayUseCase>(),
        gh<_i1032.HabitDayActions>(),
      ),
    );
    gh.factory<_i208.WelcomeCubit>(
      () => _i208.WelcomeCubit(
        gh<_i989.LoadDemoUseCase>(),
        gh<_i725.StartEmptyUseCase>(),
      ),
    );
    gh.factory<_i234.AchievementsCubit>(
      () => _i234.AchievementsCubit(gh<_i97.WatchAchievementsUseCase>()),
    );
    return this;
  }
}

class _$AppModule extends _i381.AppModule {}
