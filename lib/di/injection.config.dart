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
import 'package:momentum/core/database/app_database.dart' as _i784;
import 'package:momentum/core/database/daos/habit_logs_dao.dart' as _i245;
import 'package:momentum/core/database/daos/user_data_dao.dart' as _i688;
import 'package:momentum/core/network/asset_json_loader.dart' as _i1038;
import 'package:momentum/core/network/fake_momentum_service.dart' as _i254;
import 'package:momentum/core/network/momentum_service.dart' as _i102;
import 'package:momentum/core/network/network_simulator.dart' as _i879;
import 'package:momentum/core/storage/settings_local_data_source.dart' as _i325;
import 'package:momentum/data/repository/demo_repository_impl.dart' as _i875;
import 'package:momentum/data/repository/settings_repository_impl.dart'
    as _i335;
import 'package:momentum/di/app_module.dart' as _i381;
import 'package:momentum/domain/repository/demo_repository.dart' as _i752;
import 'package:momentum/domain/repository/settings_repository.dart' as _i888;
import 'package:momentum/domain/usecase/load_demo_use_case.dart' as _i989;
import 'package:momentum/domain/usecase/start_empty_use_case.dart' as _i725;
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
    gh.lazySingleton<_i879.NetworkSimulator>(() => _i879.NetworkSimulator());
    gh.lazySingleton<_i281.AssetBundle>(() => appModule.assetBundle);
    gh.lazySingleton<_i454.Clock>(() => appModule.clock);
    gh.lazySingleton<_i784.AppDatabase>(() => appModule.appDatabase);
    await gh.lazySingletonAsync<_i460.SharedPreferencesWithCache>(
      () => appModule.preferences,
      preResolve: true,
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
    gh.lazySingleton<_i245.HabitLogsDao>(
      () => appModule.habitLogsDao(gh<_i784.AppDatabase>()),
    );
    gh.lazySingleton<_i888.SettingsRepository>(
      () => _i335.SettingsRepositoryImpl(gh<_i325.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i752.DemoRepository>(
      () => _i875.DemoRepositoryImpl(
        gh<_i102.MomentumService>(),
        gh<_i688.UserDataDao>(),
        gh<_i454.Clock>(),
      ),
    );
    gh.factory<_i725.StartEmptyUseCase>(
      () => _i725.StartEmptyUseCase(gh<_i888.SettingsRepository>()),
    );
    gh.factory<_i989.LoadDemoUseCase>(
      () => _i989.LoadDemoUseCase(
        gh<_i752.DemoRepository>(),
        gh<_i888.SettingsRepository>(),
      ),
    );
    gh.factory<_i208.WelcomeCubit>(
      () => _i208.WelcomeCubit(
        gh<_i989.LoadDemoUseCase>(),
        gh<_i725.StartEmptyUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i381.AppModule {}
