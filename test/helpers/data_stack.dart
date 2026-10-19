import 'package:clock/clock.dart';
import 'package:flutter/services.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/fake_momentum_service.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/data/repository/demo_repository_impl.dart';
import 'package:momentum/domain/usecase/load_demo_use_case.dart';
import 'package:momentum/domain/usecase/start_empty_use_case.dart';

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

  Future<void> close() => db.close();
}

/// The demo that ships in `assets/json/demo.json`, as the fake service sends
/// it.
Future<DemoDto> bundledDemo() => FakeMomentumService(
  AssetJsonLoader(rootBundle),
  NetworkSimulator(latency: Duration.zero),
).fetchDemo();
