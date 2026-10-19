import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';
import 'package:momentum/features/habit_form/open_habit_form.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';
import 'package:momentum/features/today/cubit/today_cubit.dart';
import 'package:momentum/features/today/cubit/today_state.dart';

/// Today: the ring for today's due habits, the perfect-day streak, this
/// week, then today's habits, due ones first, and the rest folded away.
class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayCubit>();
    final state = context.watch<TodayCubit>().state;
    return BlocListener<TodayCubit, TodayState>(
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
          title: const Text('Today'),
          actions: [
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () => const SearchRoute().push<void>(context),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          // Both tabs stay alive in the shell's IndexedStack, each with a
          // FAB; with the default hero tag, pushing any screen above them
          // would find two heroes with one tag and assert (conventions
          // §11.59).
          heroTag: 'new-habit-today',
          onPressed: () => openHabitForm(context),
          icon: const Icon(Icons.add),
          label: const Text('New habit'),
        ),
        body: switch (state.status) {
          TodayStatus.loading => const LoadingView(message: 'Loading today…'),
          TodayStatus.failed => ErrorView(
            message: "Today couldn't be loaded.",
            onRetry: cubit.start,
          ),
          TodayStatus.ready when state.overview!.isEmpty => EmptyStateView(
            icon: Icons.today_outlined,
            title: 'No habits yet',
            message: "Add a habit, and it shows up here on each day it's due.",
            action: FilledButton(
              onPressed: () => openHabitForm(context),
              child: const Text('New habit'),
            ),
          ),
          TodayStatus.ready => _Today(overview: state.overview!),
        },
      ),
    );
  }
}

class _Today extends StatelessWidget {
  const _Today({required this.overview});

  final TodayOverview overview;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayCubit>();
    final today = overview.today;

    HabitCard card(HabitToday item) => HabitCard(
      item: item,
      today: today,
      onOpen: () =>
          HabitDetailRoute(habitId: item.habit.id).push<void>(context),
      // Due or not (an extra run on a day off), once it has started.
      onCheckIn: item.habit.startDate > today
          ? null
          : () => cubit.checkIn(item),
      onUndo: () => cubit.undo(item),
      actions: [
        if (item.state != DayState.skipped && item.due)
          HabitAction('Skip today', Icons.redo, () => cubit.skip(item)),
        if (item.log != null)
          HabitAction('Undo today', Icons.undo, () => cubit.undo(item)),
        HabitAction(
          'Open',
          Icons.open_in_new,
          () => HabitDetailRoute(habitId: item.habit.id).push<void>(context),
        ),
      ],
    );

    return ListView(
      // Room under the last card for the FAB.
      padding: const EdgeInsets.only(bottom: 96),
      children: [
        _Header(overview: overview),
        const SectionHeader('Due today'),
        if (overview.due.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Text('Nothing is due today. Enjoy the day off.'),
          ),
        for (final item in overview.due) card(item),
        if (overview.notDue.isNotEmpty)
          ExpansionTile(
            title: Text('Not due today (${overview.notDue.length})'),
            children: [for (final item in overview.notDue) card(item)],
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.overview});

  final TodayOverview overview;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = overview.summary;
    final ring = CompletionRing(done: summary.done, due: summary.due);
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          // Its own node: a heading flag on a merged node would make
          // everything around it a heading too.
          container: true,
          header: true,
          child: Text(
            DateLabels.long(overview.today),
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: AppSpacing.xxSmall),
        Text(
          switch (summary) {
            TodaySummary(due: 0) => 'Nothing due today',
            TodaySummary(:final done, :final due) when done == due =>
              'All $due done. Well done!',
            TodaySummary(:final done, :final due) => '$done of $due done',
          },
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    return Card(
      margin: const EdgeInsets.all(AppSpacing.medium),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (context.prefersStackedLayout) ...[
              Align(alignment: Alignment.centerLeft, child: ring),
              const SizedBox(height: AppSpacing.small),
              text,
            ] else
              Row(
                children: [
                  ring,
                  const SizedBox(width: AppSpacing.medium),
                  Expanded(child: text),
                ],
              ),
            const SizedBox(height: AppSpacing.medium),
            StreakBanner(perfectDays: summary.perfectDays),
            const SizedBox(height: AppSpacing.medium),
            WeekStrip(days: summary.week, todayWeekday: overview.today.weekday),
          ],
        ),
      ),
    );
  }
}
