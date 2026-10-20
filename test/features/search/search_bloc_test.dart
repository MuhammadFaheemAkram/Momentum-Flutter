import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/usecase/analytics_search_use_cases.dart';
import 'package:momentum/features/search/bloc/search_bloc.dart';
import 'package:momentum/features/search/bloc/search_event.dart';
import 'package:momentum/features/search/bloc/search_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/wait_for.dart';

class _MockWatchResults extends Mock implements WatchSearchResultsUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DataStack stack;
  late _MockWatchResults watchResults;

  SearchResults resultsFor(String id) => SearchResults(habits: [habit(id: id)]);

  setUp(() {
    stack = DataStack();
    watchResults = _MockWatchResults();
    when(() => watchResults(any())).thenAnswer(
      (invocation) => Stream.value(
        resultsFor(invocation.positionalArguments.single as String),
      ),
    );
  });
  tearDown(() => stack.close());

  SearchBloc build({
    Duration debounce = const Duration(milliseconds: 10),
    bool closeAfterTest = true,
    WatchSearchResultsUseCase? results,
  }) {
    final bloc = SearchBloc(
      results ?? watchResults,
      stack.watchRecentSearches,
      stack.saveRecentSearch,
      stack.clearRecentSearches,
      debounce: debounce,
    );
    if (closeAfterTest) addTearDown(bloc.close);
    return bloc;
  }

  List<String> searched() => [
    for (final call in verify(() => watchResults(captureAny())).captured)
      call as String,
  ];

  group('timing (fake time)', () {
    test('a query waits out 300 ms, then runs', () {
      fakeAsync((time) {
        // Closed inside the fake zone it was made in: a close awaited after
        // the test would wait on fake timers forever.
        final bloc = build(
          debounce: const Duration(milliseconds: 300),
          closeAfterTest: false,
        );
        final states = <SearchState>[];
        final subscription = bloc.stream.listen(states.add);

        bloc.add(const SearchQueryChanged('run'));
        time.elapse(const Duration(milliseconds: 299));
        verifyNever(() => watchResults(any()));
        expect(states, isEmpty);

        time.elapse(const Duration(milliseconds: 1));
        expect(searched(), ['run']);
        expect(states.map((s) => s.status), [
          SearchStatus.searching,
          SearchStatus.results,
        ]);

        unawaited(subscription.cancel());
        unawaited(bloc.close());
        time.flushMicrotasks();
      });
    });

    test('a tapped recent search runs at once', () {
      fakeAsync((time) {
        final bloc = build(
          debounce: const Duration(milliseconds: 300),
          closeAfterTest: false,
        );

        bloc.add(const SearchQueryChanged('read', immediate: true));
        time.flushMicrotasks();
        expect(searched(), ['read']);

        unawaited(bloc.close());
        time.flushMicrotasks();
      });
    });
  });

  // Switching from one query to the next awaits a real cancel, which never
  // finishes in fake time (conventions §11.29): tested in real time with a
  // short debounce.
  group('typing', () {
    test('only the last query typed within the debounce runs', () async {
      final bloc = build()
        ..add(const SearchQueryChanged('ru'))
        ..add(const SearchQueryChanged('run'))
        ..add(const SearchQueryChanged('runn'));

      await waitFor(bloc, (s) => s.status == SearchStatus.results);

      expect(searched(), ['runn']);
      expect(bloc.state.results, resultsFor('runn'));
    });

    test('fewer than two characters: idle, no search', () async {
      final bloc = build()..add(const SearchQueryChanged(' r '));

      await waitFor(bloc, (s) => s.query == 'r');

      expect(bloc.state.status, SearchStatus.idle);
      verifyNever(() => watchResults(any()));
    });

    test("a newer query stops the older one's live results", () async {
      final older = StreamController<SearchResults>();
      addTearDown(older.close);
      when(() => watchResults('older')).thenAnswer((_) => older.stream);
      final bloc = build()
        ..add(const SearchQueryChanged('older', immediate: true));
      await waitFor(bloc, (s) => s.status == SearchStatus.searching);

      bloc.add(const SearchQueryChanged('newer', immediate: true));
      await waitFor(bloc, (s) => s.status == SearchStatus.results);
      older.add(resultsFor('stale'));
      await pumpEventQueue();

      expect(bloc.state.query, 'newer');
      expect(bloc.state.results, resultsFor('newer'));
    });

    test('results stay live: a habit renamed elsewhere updates them', () async {
      await stack.seed(
        UserData(
          habits: [habit(id: 'read').copyWith(title: 'Read')],
        ),
      );
      final bloc = build(results: stack.watchSearchResults)
        ..add(const SearchQueryChanged('read', immediate: true));
      await waitFor(bloc, (s) => s.results.habits.length == 1);

      final draft = (await stack.findHabit('read'))!;
      await stack.habits.updateHabit(
        'read',
        // The search no longer matches.
        HabitDraft.of(draft).copyWith(title: 'Write'),
      );

      await waitFor(bloc, (s) => s.results.habits.isEmpty);
    });
  });

  test('opening a result remembers the query; Clear empties them', () async {
    final bloc = build()
      ..add(const SearchSubscriptionRequested())
      ..add(const SearchQueryChanged('water', immediate: true));
    await waitFor(bloc, (s) => s.status == SearchStatus.results);

    bloc.add(const SearchResultOpened());
    await waitFor(bloc, (s) => s.recentSearches.isNotEmpty);
    expect(bloc.state.recentSearches, ['water']);

    bloc.add(const SearchRecentSearchesCleared());
    await waitFor(bloc, (s) => s.recentSearches.isEmpty);
  });
}
