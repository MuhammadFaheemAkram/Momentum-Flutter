import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

typedef _Keys = SettingsLocalDataSource;

/// The default [SettingsRepository].
///
/// It keeps the current [AppSettings] in memory, publishes every change to
/// its watchers at once, and persists through [SettingsLocalDataSource].
/// Missing or unreadable values fall back to the defaults.
///
/// Only the values that changed are written. The background isolate keeps
/// its own copy of the settings; writing every key from a stale copy would
/// undo what the other isolate saved meanwhile (a backup's time).
@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._local) : _current = _read(_local);

  final SettingsLocalDataSource _local;
  final _changes = StreamController<AppSettings>.broadcast(sync: true);
  AppSettings _current;

  @override
  AppSettings get current => _current;

  @override
  Stream<AppSettings> watch() {
    // The current value on listen, then every change. Subscribing to the
    // changes in the same step leaves no gap for an update to slip through.
    return Stream.multi((watcher) {
      final subscription = _changes.stream.listen(watcher.add);
      watcher
        ..onCancel = subscription.cancel
        ..add(_current);
    });
  }

  @override
  Future<void> setOnboarded({required bool onboarded}) =>
      update((settings) => settings.copyWith(onboarded: onboarded));

  @override
  Future<void> update(AppSettings Function(AppSettings settings) change) {
    final before = _current;
    final after = change(before);
    _publish(after);
    return _write(before, after);
  }

  @override
  Future<void> reload() async {
    await _local.reload();
    _publish(_read(_local));
  }

  /// Closes the change stream (for tests: the app keeps one repository for
  /// its whole lifetime).
  Future<void> dispose() => _changes.close();

  void _publish(AppSettings settings) {
    if (settings == _current) return;
    _current = settings;
    _changes.add(settings);
  }

  Future<void> _write(AppSettings before, AppSettings after) async {
    Future<void> flag(String key, bool Function(AppSettings s) value) async {
      if (value(before) != value(after)) {
        await _local.setBool(key, value: value(after));
      }
    }

    Future<void> text(String key, String? Function(AppSettings s) value) async {
      final text = value(after);
      if (value(before) == text) return;
      text == null
          ? await _local.remove(key)
          : await _local.setString(key, text);
    }

    await flag(_Keys.onboardedKey, (s) => s.onboarded);
    await text(_Keys.themeModeKey, (s) => s.themeMode.name);
    await flag(_Keys.dynamicColorKey, (s) => s.dynamicColor);
    await flag(_Keys.notificationsEnabledKey, (s) => s.notificationsEnabled);
    await flag(_Keys.nudgeEnabledKey, (s) => s.nudgeEnabled);
    await text(_Keys.nudgeTimeKey, (s) => s.nudgeTime.toHhMm());
    await flag(_Keys.summaryEnabledKey, (s) => s.summaryEnabled);
    await text(_Keys.summaryTimeKey, (s) => s.summaryTime.toHhMm());
    await text(_Keys.defaultReminderKey, (s) => s.defaultReminder.toHhMm());
    await flag(_Keys.autoBackupKey, (s) => s.autoBackup);
    await text(
      _Keys.lastBackupAtKey,
      (s) => s.lastBackupAt?.toUtc().toIso8601String(),
    );
  }

  static AppSettings _read(SettingsLocalDataSource local) {
    const defaults = AppSettings();
    TimeOfDayValue time(String key, TimeOfDayValue fallback) {
      final text = local.getString(key);
      if (text == null) return fallback;
      try {
        return TimeOfDayValue.parse(text);
      } on FormatException {
        return fallback;
      }
    }

    final themeName = local.getString(_Keys.themeModeKey);
    final lastBackup = local.getString(_Keys.lastBackupAtKey);
    return AppSettings(
      onboarded: local.getBool(_Keys.onboardedKey) ?? defaults.onboarded,
      themeMode: AppThemeMode.values.firstWhere(
        (mode) => mode.name == themeName,
        orElse: () => defaults.themeMode,
      ),
      dynamicColor:
          local.getBool(_Keys.dynamicColorKey) ?? defaults.dynamicColor,
      notificationsEnabled:
          local.getBool(_Keys.notificationsEnabledKey) ??
          defaults.notificationsEnabled,
      nudgeEnabled:
          local.getBool(_Keys.nudgeEnabledKey) ?? defaults.nudgeEnabled,
      nudgeTime: time(_Keys.nudgeTimeKey, defaults.nudgeTime),
      summaryEnabled:
          local.getBool(_Keys.summaryEnabledKey) ?? defaults.summaryEnabled,
      summaryTime: time(_Keys.summaryTimeKey, defaults.summaryTime),
      defaultReminder: time(_Keys.defaultReminderKey, defaults.defaultReminder),
      autoBackup: local.getBool(_Keys.autoBackupKey) ?? defaults.autoBackup,
      lastBackupAt: lastBackup == null
          ? null
          : DateTime.tryParse(lastBackup)?.toLocal(),
    );
  }
}
