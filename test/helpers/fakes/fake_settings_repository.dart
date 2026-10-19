import 'dart:async';

import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

/// Settings in memory, with the real repository's watch behaviour, and a log
/// of the writes in order.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([this._current = const AppSettings()]);

  AppSettings _current;
  final _changes = StreamController<AppSettings>.broadcast(sync: true);

  /// Every write, in order: `onboarded`, …
  final writes = <String>[];

  @override
  AppSettings get current => _current;

  @override
  Stream<AppSettings> watch() => Stream.multi((watcher) {
    final subscription = _changes.stream.listen(watcher.add);
    watcher
      ..onCancel = subscription.cancel
      ..add(_current);
  });

  @override
  Future<void> setOnboarded({required bool onboarded}) async {
    writes.add('onboarded');
    publish(_current.copyWith(onboarded: onboarded));
  }

  void publish(AppSettings settings) {
    _current = settings;
    _changes.add(settings);
  }
}
