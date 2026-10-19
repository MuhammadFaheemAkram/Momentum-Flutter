import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/data/repository/settings_repository_impl.dart';
import 'package:momentum/domain/model/app_settings.dart';
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
}
