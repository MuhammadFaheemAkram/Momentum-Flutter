import 'dart:async';

import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

/// Settings in memory, with the real repository's watch behaviour, and a log
/// of the writes in order.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([this._current = const AppSettings()]);

  AppSettings _current;
  final _changes = StreamController<AppSettings>.broadcast(sync: true);

  /// Every write, in order: `onboarded`, `update`.
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

  @override
  Future<void> update(AppSettings Function(AppSettings settings) change) async {
    writes.add('update');
    publish(change(_current));
  }

  /// What the next [reload] reads, as if the background isolate saved it.
  AppSettings? onDevice;

  @override
  Future<void> reload() async {
    if (onDevice case final settings?) publish(settings);
  }

  void publish(AppSettings settings) {
    _current = settings;
    _changes.add(settings);
  }
}
