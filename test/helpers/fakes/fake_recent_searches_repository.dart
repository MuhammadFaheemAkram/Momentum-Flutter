import 'dart:async';

import 'package:momentum/domain/repository/recent_searches_repository.dart';

/// Recent searches in memory, with the real repository's rules (latest
/// first, once each ignoring case, five kept).
class FakeRecentSearchesRepository implements RecentSearchesRepository {
  FakeRecentSearchesRepository([List<String> searches = const []])
    : _current = searches;

  List<String> _current;
  final _changes = StreamController<List<String>>.broadcast(sync: true);

  List<String> get current => _current;

  @override
  Stream<List<String>> watch() => Stream.multi((watcher) {
    final subscription = _changes.stream.listen(watcher.add);
    watcher
      ..onCancel = subscription.cancel
      ..add(_current);
  });

  @override
  Future<void> save(String query) async => _publish(
    [
      query,
      for (final old in _current)
        if (old.toLowerCase() != query.toLowerCase()) old,
    ].take(5).toList(),
  );

  @override
  Future<void> clear() async => _publish(const []);

  void _publish(List<String> searches) {
    _current = searches;
    _changes.add(searches);
  }
}
