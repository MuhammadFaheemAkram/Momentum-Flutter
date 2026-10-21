import 'package:clock/clock.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/service/background_work.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'database.dart';
import 'fakes/fake_notification_scheduler.dart';

/// Builds the app's real composition root for app-level tests, with these
/// swaps:
/// - preferences live in an in-memory store, pre-filled with [preferences]
///   (raw keys, as `SettingsLocalDataSource` names them);
/// - the database lives in memory (and is closed by `getIt.reset()`);
/// - the simulated network has no latency;
/// - the clock is fixed at [demoNow], so every demo date is known;
/// - notifications go to a [FakeNotificationScheduler] ([notifications], or
///   a new one: not permitted until asked, granted when asked), reachable as
///   `getIt<NotificationScheduler>() as FakeNotificationScheduler`;
/// - background work registers nothing, the wallpaper has no colors (as on
///   iOS), and the app's version is 1.0.0 (1).
///
/// Everything else is the real code, so these tests also prove the DI graph
/// resolves. Call `getIt.reset()` in `tearDown`.
Future<void> configureTestDependencies({
  Map<String, Object> preferences = const {},
  FakeNotificationScheduler? notifications,
}) async {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.withData(Map.of(preferences));
  // No wallpaper palette, answered at once: an unanswered platform call
  // before the first pump would wait on fake time forever (§11.44).
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(DynamicColorPlugin.channel, (_) async => null);
  PackageInfo.setMockInitialValues(
    appName: 'Momentum',
    packageName: 'co.bitfuse.flutter.momentum',
    version: '1.0.0',
    buildNumber: '1',
    buildSignature: '',
  );
  await configureDependencies();
  final scheduler = notifications ?? FakeNotificationScheduler();
  getIt
    ..unregister<AppDatabase>()
    ..registerLazySingleton<AppDatabase>(
      newTestDatabase,
      dispose: (database) => database.close(),
    )
    ..unregister<NetworkSimulator>()
    ..registerLazySingleton<NetworkSimulator>(
      () => NetworkSimulator(latency: Duration.zero),
    )
    ..unregister<Clock>()
    ..registerLazySingleton<Clock>(() => Clock.fixed(demoNow))
    ..unregister<NotificationScheduler>()
    ..registerSingleton<NotificationScheduler>(scheduler)
    ..unregister<NotificationInteractions>()
    ..registerSingleton<NotificationInteractions>(scheduler)
    ..unregister<BackgroundWork>()
    ..registerSingleton<BackgroundWork>(const _NoBackgroundWork());
}

/// "Now" in every test: Wednesday 21 October 2026, 15:00 local time. Its
/// ISO week began on Monday the 19th.
final demoNow = DateTime(2026, 10, 21, 15);

/// The saved preferences of an app that is past Welcome.
const onboardedPreferences = {'settings.onboarded': true};

class _NoBackgroundWork implements BackgroundWork {
  const _NoBackgroundWork();

  @override
  Future<void> registerMaintenance() async {}
}
