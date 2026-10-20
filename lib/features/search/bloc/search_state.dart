import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/search.dart';

part 'search_state.freezed.dart';

enum SearchStatus {
  /// Fewer than two characters: the recent searches show.
  idle,

  /// A search is under way; the previous results stay on screen.
  searching,
  results,
  failure,
}

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState({
    @Default(SearchStatus.idle) SearchStatus status,
    @Default('') String query,
    @Default(SearchResults()) SearchResults results,
    @Default(<String>[]) List<String> recentSearches,
  }) = _SearchState;
}
