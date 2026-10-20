import 'package:injectable/injectable.dart';
import 'package:momentum/core/database/daos/search_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/domain/repository/search_repository.dart';
import 'package:stream_transform/stream_transform.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._search);

  final SearchDao _search;

  @override
  Stream<SearchResults> watch(String text) => _search
      .watchHabits(text)
      .combineLatest(
        _search.watchRoutines(text),
        (habits, routines) => (habits, routines),
      )
      .combineLatest(_search.watchGoals(text), (data, goals) {
        final (habits, routines) = data;
        return SearchResults(
          habits: [for (final row in habits) row.toDomain()],
          // Found by name: the steps aren't shown, so none are loaded.
          routines: [for (final row in routines) row.toDomain(const [])],
          goals: [for (final row in goals) row.toDomain()],
        );
      });
}
