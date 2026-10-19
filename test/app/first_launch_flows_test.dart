import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/di/injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/app_harness.dart';

// The first launch on the real app: the demo comes from the fake service
// (zero latency here) into the in-memory database, and Welcome hands over
// to Today.
void main() {
  tearDown(getIt.reset);

  Future<UserRows> stored(WidgetTester tester) async =>
      (await tester.runAsync(() => getIt<UserDataDao>().readAll()))!;

  /// What the next launch would read: a new preferences cache over the
  /// same (in-memory) store.
  Future<bool?> savedOnboarded(WidgetTester tester) async {
    final preferences = await tester.runAsync(
      () => SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: SettingsLocalDataSource.allowList,
        ),
      ),
    );
    return preferences!.getBool(SettingsLocalDataSource.onboardedKey);
  }

  testWidgets('Explore with demo data: the demo is stored, the choice saved, '
      'and Today opens', (tester) async {
    await pumpMomentum(tester, onboarded: false);

    await tester.tap(find.text('Explore with demo data'));
    await tester.pumpUntilFound(appBarTitled('Today'));

    final rows = await stored(tester);
    expect(rows.habits, hasLength(6));
    expect(rows.routines, hasLength(2));
    expect(await savedOnboarded(tester), isTrue);
  });

  testWidgets('offline: the error, Try again, and nothing stored until it '
      'works', (tester) async {
    await pumpMomentum(
      tester,
      onboarded: false,
      beforeLaunch: () async => getIt<NetworkSimulator>().failRequests = true,
    );

    await tester.tap(find.text('Explore with demo data'));
    await tester.pumpUntilFound(find.text('Try again'));
    expect(find.textContaining("Couldn't reach the server"), findsOneWidget);
    expect(find.text('Start empty'), findsOneWidget);
    expect((await stored(tester)).habits, isEmpty);
    expect(await savedOnboarded(tester), isNull);

    getIt<NetworkSimulator>().failRequests = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpUntilFound(appBarTitled('Today'));

    expect((await stored(tester)).habits, hasLength(6));
  });

  testWidgets('Start empty: Today opens, with nothing stored', (tester) async {
    await pumpMomentum(tester, onboarded: false);

    await tester.tap(find.text('Start empty'));
    await tester.pumpUntilFound(appBarTitled('Today'));

    expect((await stored(tester)).habits, isEmpty);
    expect(await savedOnboarded(tester), isTrue);
  });
}
