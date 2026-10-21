import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/data/repository/settings_repository_impl.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  Future<SettingsRepositoryImpl> launch([Map<String, Object>? saved]) async {
    if (saved != null) {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.withData(saved);
    }
    final repository = SettingsRepositoryImpl(
      SettingsLocalDataSource(
        await SharedPreferencesWithCache.create(
          cacheOptions: const SharedPreferencesWithCacheOptions(
            allowList: SettingsLocalDataSource.allowList,
          ),
        ),
      ),
    );
    addTearDown(repository.dispose);
    return repository;
  }

  test('a first launch: not onboarded', () async {
    final repository = await launch({});

    expect(repository.current, const AppSettings());
  });

  test(
    'onboarding is saved, published and read back on the next launch',
    () async {
      final repository = await launch({});
      final seen = <AppSettings>[];
      final subscription = repository.watch().listen(seen.add);

      await repository.setOnboarded(onboarded: true);
      await pumpEventQueue();
      await subscription.cancel();

      expect(seen, const [AppSettings(), AppSettings(onboarded: true)]);
      expect((await launch()).current.onboarded, isTrue);
    },
  );

  test('an unchanged value publishes nothing', () async {
    final repository = await launch({'settings.onboarded': true});
    final seen = <bool>[];
    final subscription = repository.watch().listen(
      (settings) => seen.add(settings.onboarded),
    );

    await repository.setOnboarded(onboarded: true);
    await pumpEventQueue();
    await subscription.cancel();

    expect(seen, [true]);
  });

  test('every setting is saved and read back on the next launch', () async {
    final repository = await launch({});
    final changed = AppSettings(
      onboarded: true,
      themeMode: AppThemeMode.dark,
      dynamicColor: false,
      notificationsEnabled: true,
      nudgeEnabled: false,
      nudgeTime: TimeOfDayValue(19, 15),
      summaryEnabled: false,
      summaryTime: TimeOfDayValue(22, 0),
      defaultReminder: TimeOfDayValue(7, 30),
      autoBackup: true,
      lastBackupAt: DateTime(2026, 10, 20, 23, 4),
    );

    await repository.update((_) => changed);

    expect((await launch()).current, changed);
  });

  test('only what changed is written: a value saved meanwhile by the '
      'background isolate stays', () async {
    final app = await launch({});
    // The background isolate's own copy saves a backup's time.
    final background = await launch();
    await background.update(
      (s) => s.copyWith(lastBackupAt: DateTime(2026, 10, 21, 3)),
    );

    await app.update((s) => s.copyWith(themeMode: AppThemeMode.dark));

    final next = (await launch()).current;
    expect(next.themeMode, AppThemeMode.dark);
    expect(next.lastBackupAt, DateTime(2026, 10, 21, 3));
  });

  test('reload: what another isolate saved is read and published', () async {
    final app = await launch({});
    final background = await launch();
    final seen = <bool>[];
    final subscription = app.watch().listen(
      (settings) => seen.add(settings.notificationsEnabled),
    );
    addTearDown(subscription.cancel);

    await background.update((s) => s.copyWith(notificationsEnabled: true));
    expect(app.current.notificationsEnabled, isFalse);
    await app.reload();
    await pumpEventQueue();

    expect(app.current.notificationsEnabled, isTrue);
    expect(seen, [false, true]);
  });

  test('unreadable values fall back to the defaults', () async {
    final repository = await launch({
      'settings.themeMode': 'sepia',
      'settings.nudgeTime': '8pm',
      'settings.lastBackupAt': 'yesterday',
    });

    expect(repository.current, const AppSettings());
  });
}
