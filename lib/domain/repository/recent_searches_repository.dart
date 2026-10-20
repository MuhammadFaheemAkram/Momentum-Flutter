/// The last few searches the user acted on.
abstract interface class RecentSearchesRepository {
  /// Latest first, kept live.
  Stream<List<String>> watch();

  /// Puts [query] first (once: case doesn't make a new entry), keeping five.
  Future<void> save(String query);

  Future<void> clear();
}
