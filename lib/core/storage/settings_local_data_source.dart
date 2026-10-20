import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reads and writes the raw preference values. The keys live here and
/// nowhere else.
///
/// Preferences belong in `shared_preferences`: small, non-secret values the
/// device owns. Habits and their history live in drift.
///
/// It is backed by `SharedPreferencesWithCache`, created once before `runApp`
/// (`@preResolve` in `AppModule`): reads are synchronous afterwards, and
/// writes update the cache at once and the disk asynchronously.
@lazySingleton
class SettingsLocalDataSource {
  const SettingsLocalDataSource(this._preferences);

  static const onboardedKey = 'settings.onboarded';
  static const recentSearchesKey = 'search.recent';

  /// The only keys the cache loads and allows writing.
  static const allowList = {onboardedKey, recentSearchesKey};

  final SharedPreferencesWithCache _preferences;

  bool? get onboarded => _preferences.getBool(onboardedKey);

  List<String>? get recentSearches =>
      _preferences.getStringList(recentSearchesKey);

  Future<void> setRecentSearches(List<String> searches) =>
      _preferences.setStringList(recentSearchesKey, searches);

  Future<void> setOnboarded({required bool onboarded}) =>
      _preferences.setBool(onboardedKey, onboarded);
}
