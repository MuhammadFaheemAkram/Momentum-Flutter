import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

/// The default [SettingsRepository].
///
/// It keeps the current [AppSettings] in memory, publishes every change to
/// its watchers at once, and persists through [SettingsLocalDataSource].
/// Missing values fall back to the defaults.
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
  Future<void> setOnboarded({required bool onboarded}) {
    _publish(_current.copyWith(onboarded: onboarded));
    return _local.setOnboarded(onboarded: onboarded);
  }

  /// Closes the change stream (for tests: the app keeps one repository for
  /// its whole lifetime).
  Future<void> dispose() => _changes.close();

  void _publish(AppSettings settings) {
    if (settings == _current) return;
    _current = settings;
    _changes.add(settings);
  }

  static AppSettings _read(SettingsLocalDataSource local) {
    const defaults = AppSettings();
    return AppSettings(onboarded: local.onboarded ?? defaults.onboarded);
  }
}
