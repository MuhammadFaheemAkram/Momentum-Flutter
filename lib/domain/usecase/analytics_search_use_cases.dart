import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/domain/calculation/analytics.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/analytics.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/repository/recent_searches_repository.dart';
import 'package:momentum/domain/repository/search_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// The Analytics tab, live and again at midnight (clock first: §11.61).
@injectable
class WatchAnalyticsUseCase {
  const WatchAnalyticsUseCase(this._habits, this._logs, this._clock);

  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final CalendarClock _clock;

  Stream<AnalyticsOverview> call() => _clock.watchToday().combineLatest(
    _habits.watchHabits().combineLatest(
      _logs.watchLogs(),
      (habits, logs) => (habits, logs),
    ),
    (today, data) {
      final (habits, logs) = data;
      final byHabit = <String, List<HabitLog>>{};
      for (final log in logs) {
        (byHabit[log.habitId] ??= []).add(log);
      }
      return buildAnalytics([
        for (final habit in habits)
          HabitHistory(habit, byHabit[habit.id] ?? const []),
      ], today: today);
    },
  );
}

/// Habits, routines and goals matching [query] (from the database), and the
/// badges whose title or description does (they live in code), kept live.
@injectable
class WatchSearchResultsUseCase {
  const WatchSearchResultsUseCase(this._search);

  final SearchRepository _search;

  Stream<SearchResults> call(String query) {
    final text = query.trim();
    final lower = text.toLowerCase();
    final badges = [
      for (final id in AchievementId.values)
        if (id.title.toLowerCase().contains(lower) ||
            id.description.toLowerCase().contains(lower))
          id,
    ];
    return _search
        .watch(text)
        .map((results) => results.copyWith(achievements: badges));
  }
}

@injectable
class WatchRecentSearchesUseCase {
  const WatchRecentSearchesUseCase(this._recent);

  final RecentSearchesRepository _recent;

  Stream<List<String>> call() => _recent.watch();
}

@injectable
class SaveRecentSearchUseCase {
  const SaveRecentSearchUseCase(this._recent);

  final RecentSearchesRepository _recent;

  Future<void> call(String query) async {
    final text = query.trim();
    if (text.isNotEmpty) await _recent.save(text);
  }
}

@injectable
class ClearRecentSearchesUseCase {
  const ClearRecentSearchesUseCase(this._recent);

  final RecentSearchesRepository _recent;

  Future<void> call() => _recent.clear();
}
