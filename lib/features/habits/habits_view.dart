import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';
import 'package:momentum/features/habit_form/open_habit_form.dart';
import 'package:momentum/features/habits/cubit/habits_cubit.dart';
import 'package:momentum/features/habits/cubit/habits_state.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Every habit: a search field, category chips, archived ones on request,
/// and each habit's card with its actions.
class HabitsView extends StatefulWidget {
  const HabitsView({super.key});

  @override
  State<HabitsView> createState() => _HabitsViewState();
}

class _HabitsViewState extends State<HabitsView> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitsCubit>();
    final state = context.watch<HabitsCubit>().state;
    return BlocListener<HabitsCubit, HabitsState>(
      listenWhen: (previous, current) =>
          previous.noticeSerial != current.noticeSerial,
      listener: (context, state) => showHabitNotice(
        context,
        state.notice!,
        onUndo: () => cubit.undoNotice(state.notice!),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const DrawerMenuButton(),
          title: const Text('Habits'),
          actions: [
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () => const SearchRoute().push<void>(context),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          // Its own hero tag: Today has a FAB too (conventions §11.59).
          heroTag: 'new-habit-habits',
          onPressed: () => openHabitForm(context),
          icon: const Icon(Icons.add),
          label: const Text('New habit'),
        ),
        body: switch (state.status) {
          HabitsStatus.loading => const LoadingView(
            message: 'Loading your habits…',
          ),
          HabitsStatus.failed => ErrorView(
            message: "Your habits couldn't be loaded.",
            onRetry: cubit.start,
          ),
          HabitsStatus.ready when state.habits.isEmpty => EmptyStateView(
            icon: Icons.checklist_outlined,
            title: 'No habits yet',
            message: 'Start with something small you want to do regularly.',
            action: FilledButton(
              onPressed: () => openHabitForm(context),
              child: const Text('New habit'),
            ),
          ),
          HabitsStatus.ready => _List(state: state, search: _search),
        },
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state, required this.search});

  final HabitsState state;
  final TextEditingController search;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitsCubit>();
    final visible = state.visible;
    final today = state.today!;

    HabitCard card(HabitToday item) {
      final archived = item.habit.archivedAt != null;
      void open() =>
          HabitDetailRoute(habitId: item.habit.id).push<void>(context);
      return HabitCard(
        item: item,
        today: today,
        onOpen: open,
        // Any day it's active, due or not (an extra run on a day off).
        onCheckIn: archived || item.habit.startDate > today
            ? null
            : () => cubit.checkIn(item),
        onUndo: archived ? null : () => cubit.undo(item),
        actions: [
          if (!archived && item.due && item.state != DayState.skipped)
            HabitAction('Skip today', Icons.redo, () => cubit.skip(item)),
          if (!archived && item.log != null)
            HabitAction('Undo today', Icons.undo, () => cubit.undo(item)),
          if (archived)
            HabitAction(
              'Unarchive',
              Icons.unarchive_outlined,
              () => cubit.setArchived(item, archived: false),
            )
          else
            HabitAction(
              'Archive',
              Icons.archive_outlined,
              () => cubit.setArchived(item, archived: true),
            ),
          HabitAction('Open', Icons.open_in_new, open),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.medium,
            AppSpacing.xSmall,
            AppSpacing.medium,
            AppSpacing.xSmall,
          ),
          child: AppSearchField(
            controller: search,
            hintText: 'Search habits',
            onChanged: cubit.search,
            onCleared: () => cubit.search(''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: FilterChipGroup<HabitCategory>(
            values: HabitCategory.values,
            labelOf: (category) => category.label,
            selected: state.category,
            onSelected: cubit.filterBy,
          ),
        ),
        if (state.archivedCount > 0)
          SwitchListTile.adaptive(
            title: Text('Show archived (${state.archivedCount})'),
            value: state.showArchived,
            onChanged: (show) => cubit.showArchived(show: show),
          ),
        if (visible.isEmpty)
          const Padding(
            padding: EdgeInsets.all(AppSpacing.large),
            child: Text('No habits match.', textAlign: TextAlign.center),
          ),
        for (final item in visible) card(item),
      ],
    );
  }
}
