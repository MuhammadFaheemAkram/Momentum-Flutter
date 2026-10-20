import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';
import 'package:momentum/domain/model/search.dart';
import 'package:momentum/features/search/bloc/search_bloc.dart';
import 'package:momentum/features/search/bloc/search_event.dart';
import 'package:momentum/features/search/bloc/search_state.dart';

/// One field for everything: results grouped by kind, and the recent
/// searches while the field is (nearly) empty.
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _field = TextEditingController();

  @override
  void dispose() {
    _field.dispose();
    super.dispose();
  }

  void _searchNow(String query) {
    _field.text = query;
    context.read<SearchBloc>().add(SearchQueryChanged(query, immediate: true));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    final state = context.watch<SearchBloc>().state;
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const TodayRoute().go(context),
        ),
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.medium,
              AppSpacing.xSmall,
              AppSpacing.medium,
              AppSpacing.xSmall,
            ),
            child: AppSearchField(
              controller: _field,
              autofocus: true,
              hintText: 'Search habits, routines, goals, badges',
              onChanged: (query) => bloc.add(SearchQueryChanged(query)),
              onSubmitted: _searchNow,
              onCleared: () => bloc.add(const SearchQueryChanged('')),
            ),
          ),
          if (state.status == SearchStatus.searching)
            const LinearProgressIndicator(minHeight: 2)
          else
            const SizedBox(height: 2),
          Expanded(
            child: switch (state.status) {
              SearchStatus.idle => _Recent(
                searches: state.recentSearches,
                onSelected: _searchNow,
              ),
              SearchStatus.failure => const ErrorView(
                message: "Couldn't search. Please try again.",
              ),
              SearchStatus.searching when state.results.isEmpty =>
                const SizedBox.shrink(),
              SearchStatus.results when state.results.isEmpty => EmptyStateView(
                icon: Icons.search_off,
                title: 'Nothing matches “${state.query}”',
                message: 'Try fewer or other words.',
              ),
              SearchStatus.searching ||
              SearchStatus.results => _Results(results: state.results),
            },
          ),
        ],
      ),
    );
  }
}

/// The last searches, newest first, or what Search covers.
class _Recent extends StatelessWidget {
  const _Recent({required this.searches, required this.onSelected});

  final List<String> searches;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (searches.isEmpty) {
      return const EmptyStateView(
        icon: Icons.manage_search,
        title: 'Search everything',
        message: 'Your habits, routines and their steps, goals and badges.',
      );
    }
    return ListView(
      children: [
        SectionHeader(
          'Recent searches',
          action: TextButton(
            onPressed: () => context.read<SearchBloc>().add(
              const SearchRecentSearchesCleared(),
            ),
            child: const Text('Clear'),
          ),
        ),
        for (final search in searches)
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(search),
            onTap: () => onSelected(search),
          ),
      ],
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.results});

  final SearchResults results;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void opened() => context.read<SearchBloc>().add(const SearchResultOpened());
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.large),
      children: [
        Semantics(
          liveRegion: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Text(
              countLabel(results.count, 'result'),
              style: theme.textTheme.labelLarge,
            ),
          ),
        ),
        if (results.habits.isNotEmpty) ...[
          SectionHeader('Habits (${results.habits.length})'),
          for (final habit in results.habits)
            ListTile(
              leading: HabitAvatar(
                icon: habit.icon,
                color: habit.color,
                size: 40,
              ),
              title: Text(habit.title),
              subtitle: Text(
                habit.archivedAt != null
                    ? 'Archived'
                    : scheduleLabel(
                        habit.schedule,
                        dailyTarget: habit.dailyTarget,
                      ),
              ),
              onTap: () {
                opened();
                HabitDetailRoute(habitId: habit.id).push<void>(context);
              },
            ),
        ],
        if (results.routines.isNotEmpty) ...[
          SectionHeader('Routines (${results.routines.length})'),
          for (final routine in results.routines)
            ListTile(
              leading: Icon(routine.time.icon),
              title: Text(routine.title),
              subtitle: Text(routine.time.label),
              onTap: () {
                opened();
                const RoutinesRoute().push<void>(context);
              },
            ),
        ],
        if (results.goals.isNotEmpty) ...[
          SectionHeader('Goals (${results.goals.length})'),
          for (final goal in results.goals)
            ListTile(
              leading: const Icon(Icons.flag_outlined),
              title: Text(goal.title),
              subtitle: Text('${goal.period.label} · target ${goal.target}'),
              onTap: () {
                opened();
                const GoalsRoute().push<void>(context);
              },
            ),
        ],
        if (results.achievements.isNotEmpty) ...[
          SectionHeader('Badges (${results.achievements.length})'),
          for (final id in results.achievements)
            ListTile(
              leading: Icon(id.icon),
              title: Text(id.title),
              subtitle: Text(id.description),
              onTap: () {
                opened();
                const AchievementsRoute().go(context);
              },
            ),
        ],
      ],
    );
  }
}
