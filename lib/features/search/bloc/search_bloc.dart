import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/domain/usecase/analytics_search_use_cases.dart';
import 'package:momentum/features/search/bloc/search_event.dart';
import 'package:momentum/features/search/bloc/search_state.dart';
import 'package:momentum/features/search/bloc/search_transformers.dart';

/// Drives Search: habits, routines, goals and badges.
///
/// The one Bloc in the app (every screen else is a Cubit), because typing is
/// a *stream* of events that needs shaping: debounced, with stale searches
/// cancelled. Event transformers say that declaratively
/// ([debounceRestartable]), where a Cubit would need hand-written timers.
///
/// The results are live (`emit.forEach`): a habit renamed or a goal deleted
/// elsewhere updates them, because drift re-runs the queries.
@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(
    this._watchResults,
    this._watchRecentSearches,
    this._saveRecentSearch,
    this._clearRecentSearches, {
    @ignoreParam Duration debounce = const Duration(milliseconds: 300),
  }) : super(const SearchState()) {
    on<SearchSubscriptionRequested>(_onSubscriptionRequested);
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounceRestartable(debounce),
    );
    on<SearchResultOpened>((_, _) => _saveRecentSearch(state.query));
    on<SearchRecentSearchesCleared>((_, _) => _clearRecentSearches());
  }

  final WatchSearchResultsUseCase _watchResults;
  final WatchRecentSearchesUseCase _watchRecentSearches;
  final SaveRecentSearchUseCase _saveRecentSearch;
  final ClearRecentSearchesUseCase _clearRecentSearches;

  /// Shorter queries show the recent searches: one letter matches nearly
  /// everything and helps no one.
  static const minQueryLength = 2;

  Future<void> _onSubscriptionRequested(
    SearchSubscriptionRequested event,
    Emitter<SearchState> emit,
  ) => emit.forEach(
    _watchRecentSearches(),
    onData: (recent) => state.copyWith(recentSearches: recent),
  );

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.length < minQueryLength) {
      emit(
        state.copyWith(
          status: SearchStatus.idle,
          query: query,
          results: const SearchResults(),
        ),
      );
      return;
    }
    // The previous results stay on screen until the new ones arrive, so
    // typing doesn't flash a spinner over them.
    emit(state.copyWith(status: SearchStatus.searching, query: query));
    await emit.forEach<SearchResults>(
      _watchResults(query),
      onData: (results) =>
          state.copyWith(status: SearchStatus.results, results: results),
      onError: (_, _) => state.copyWith(
        status: SearchStatus.failure,
        results: const SearchResults(),
      ),
    );
  }
}
