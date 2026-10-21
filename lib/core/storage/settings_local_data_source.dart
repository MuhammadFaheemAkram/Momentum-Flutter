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
  static const themeModeKey = 'settings.themeMode';
  static const dynamicColorKey = 'settings.dynamicColor';
  static const notificationsEnabledKey = 'settings.notificationsEnabled';
  static const nudgeEnabledKey = 'settings.nudgeEnabled';
  static const nudgeTimeKey = 'settings.nudgeTime';
  static const summaryEnabledKey = 'settings.summaryEnabled';
  static const summaryTimeKey = 'settings.summaryTime';
  static const defaultReminderKey = 'settings.defaultReminder';
  static const autoBackupKey = 'settings.autoBackup';
  static const lastBackupAtKey = 'settings.lastBackupAt';

  /// The only keys the cache loads and allows writing.
  static const allowList = {
    onboardedKey,
    recentSearchesKey,
    themeModeKey,
    dynamicColorKey,
    notificationsEnabledKey,
    nudgeEnabledKey,
    nudgeTimeKey,
    summaryEnabledKey,
    summaryTimeKey,
    defaultReminderKey,
    autoBackupKey,
    lastBackupAtKey,
  };

  final SharedPreferencesWithCache _preferences;

  bool? getBool(String key) => _preferences.getBool(key);

  /// Texts: a theme mode's name, an `HH:mm` time, an ISO-8601 instant.
  String? getString(String key) => _preferences.getString(key);

  Future<void> setBool(String key, {required bool value}) =>
      _preferences.setBool(key, value);

  Future<void> setString(String key, String value) =>
      _preferences.setString(key, value);

  Future<void> remove(String key) => _preferences.remove(key);

  List<String>? get recentSearches =>
      _preferences.getStringList(recentSearchesKey);

  Future<void> setRecentSearches(List<String> searches) =>
      _preferences.setStringList(recentSearchesKey, searches);

  /// Reads the values from the device again.
  ///
  /// The background isolate has its own cache over the same file: a backup
  /// it ran, or notifications it turned off, only show here after a reload
  /// (on resume).
  Future<void> reload() => _preferences.reloadCache();
}
