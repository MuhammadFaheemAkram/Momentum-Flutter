import 'package:momentum/domain/model/search.dart';

abstract interface class SearchRepository {
  /// Habits, routines and goals matching [text], kept live.
  Stream<SearchResults> watch(String text);
}
