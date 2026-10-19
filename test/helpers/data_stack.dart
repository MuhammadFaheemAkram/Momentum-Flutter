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
import 'package:momentum/data/repository/demo_repository_impl.dart';
import 'package:momentum/data/repository/habit_log_repository_impl.dart';
import 'package:momentum/data/repository/habit_repository_impl.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/habit_use_cases.dart';
import 'package:momentum/domain/usecase/load_demo_use_case.dart';
import 'package:momentum/domain/usecase/start_empty_use_case.dart';
import 'package:momentum/domain/usecase/watch_habit_use_cases.dart';
import 'package:momentum/features/habit_actions/habit_day_actions.dart';

import 'database.dart';
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
        service ?? FakeMomentumService(AssetJsonLoader(rootBundle), network);
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

  late final findHabit = FindHabitUseCase(habits);
  late final saveHabit = SaveHabitUseCase(habits);
  late final setArchived = SetHabitArchivedUseCase(habits);
  late final deleteHabit = DeleteHabitUseCase(habits);
  late final addCheckIn = AddCheckInUseCase(habits, logs, calendar);
  late final skipHabit = SkipHabitUseCase(habits, logs, calendar);
  late final clearDay = ClearHabitDayUseCase(habits, logs, calendar);
  late final setDay = SetHabitDayUseCase(habits, logs, calendar);
  late final restoreDay = RestoreHabitDayUseCase(habits, logs, calendar);
  late final watchToday = WatchTodayUseCase(habits, logs, calendar);
  late final watchHabits = WatchHabitsUseCase(habits, logs, calendar);
  late final watchDetail = WatchHabitDetailUseCase(habits, logs, calendar);
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
).fetchDemo();
