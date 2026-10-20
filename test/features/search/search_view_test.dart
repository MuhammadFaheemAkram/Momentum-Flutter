import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/features/search/bloc/search_bloc.dart';
import 'package:momentum/features/search/bloc/search_event.dart';
import 'package:momentum/features/search/bloc/search_state.dart';
import 'package:momentum/features/search/search_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late _MockSearchBloc bloc;

  setUpAll(() => registerFallbackValue(const SearchResultOpened()));
  setUp(() => bloc = _MockSearchBloc());

  Future<void> pump(WidgetTester tester, SearchState state) {
    when(() => bloc.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<SearchBloc>.value(value: bloc, child: const SearchView()),
    );
  }

  testWidgets('idle: the recent searches; tapping one searches at once', (
    tester,
  ) async {
    await pump(tester, const SearchState(recentSearches: ['water', 'run']));

    expect(find.text('Recent searches'), findsOneWidget);
    await tester.tap(find.text('run'));

    final event =
        verify(() => bloc.add(captureAny())).captured.last
            as SearchQueryChanged;
    expect((event.query, event.immediate), ('run', true));
  });

  testWidgets('results grouped by kind, with a count', (tester) async {
    await pump(
      tester,
      SearchState(
        status: SearchStatus.results,
        query: 'read',
        results: SearchResults(
          habits: [habit(id: 'read').copyWith(title: 'Read 20 pages')],
          goals: [goal().copyWith(title: 'Read on 20 days')],
          achievements: const [AchievementId.streak7],
        ),
      ),
    );

    expect(find.text('3 results'), findsOneWidget);
    expect(find.text('Habits (1)'), findsOneWidget);
    expect(find.text('Goals (1)'), findsOneWidget);
    expect(find.text('Badges (1)'), findsOneWidget);
    expect(find.text('Routines (1)'), findsNothing);
  });

  testWidgets('nothing found says so', (tester) async {
    await pump(
      tester,
      const SearchState(status: SearchStatus.results, query: 'zzz'),
    );

    expect(find.text('Nothing matches “zzz”'), findsOneWidget);
  });
}
