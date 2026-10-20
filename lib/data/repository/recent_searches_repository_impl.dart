import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:momentum/core/storage/settings_local_data_source.dart';
import 'package:momentum/domain/repository/recent_searches_repository.dart';

/// Recent searches in preferences: five short strings the device owns.
@LazySingleton(as: RecentSearchesRepository)
class RecentSearchesRepositoryImpl implements RecentSearchesRepository {
  RecentSearchesRepositoryImpl(this._local)
    : _current = _local.recentSearches ?? const [];

  static const limit = 5;

  final SettingsLocalDataSource _local;
  final _changes = StreamController<List<String>>.broadcast(sync: true);
  List<String> _current;

  @override
  Stream<List<String>> watch() => Stream.multi((watcher) {
    final subscription = _changes.stream.listen(watcher.add);
    watcher
      ..onCancel = subscription.cancel
      ..add(_current);
  });

  @override
  Future<void> save(String query) => _publish(
    [
      query,
      for (final old in _current)
        if (old.toLowerCase() != query.toLowerCase()) old,
    ].take(limit).toList(),
  );

  @override
  Future<void> clear() => _publish(const []);

  Future<void> _publish(List<String> searches) {
    _current = List.unmodifiable(searches);
    _changes.add(_current);
    return _local.setRecentSearches(_current);
  }

  /// Closes the change stream (for tests).
  Future<void> dispose() => _changes.close();
}
