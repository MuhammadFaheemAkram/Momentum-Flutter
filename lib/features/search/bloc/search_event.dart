sealed class SearchEvent {
  const SearchEvent();
}

/// The screen opened: follow the recent searches while it lives.
final class SearchSubscriptionRequested extends SearchEvent {
  const SearchSubscriptionRequested();
}

/// The field changed. Debounced, unless [immediate] (a recent search tapped,
/// the keyboard's Search key) or blank.
final class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged(this.query, {this.immediate = false});

  final String query;
  final bool immediate;
}

/// A result was opened: remember the query (the view navigates).
final class SearchResultOpened extends SearchEvent {
  const SearchResultOpened();
}

final class SearchRecentSearchesCleared extends SearchEvent {
  const SearchRecentSearchesCleared();
}
