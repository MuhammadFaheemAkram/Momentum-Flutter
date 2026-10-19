import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_state.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';
import 'package:momentum/features/habit_form/open_habit_form.dart';

enum _MenuAction { archive, unarchive, delete }

/// A habit's page: what it is, its figures, the last twelve weeks as a
/// calendar you can backfill, and a chart of the last eight weeks.
///
/// Opened by a link (or, later, a notification) it has nothing to go back
/// to, so it offers Close.
class HabitDetailView extends StatelessWidget {
  const HabitDetailView({super.key});

  /// Back to wherever it was opened from, or to Habits after a link.
  static void _leave(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      const HabitsRoute().go(context);
    }
  }

  static Future<void> _edit(BuildContext context, String habitId) async {
    final exit = await openHabitForm(context, habitId: habitId);
    // Deleted from the form: there's nothing left to show here.
    if (exit is HabitDeleted && context.mounted) _leave(context);
  }

  static Future<void> _delete(BuildContext context) async {
    final cubit = context.read<HabitDetailCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete this habit?',
      message:
          'Its whole history and any goals on it go too. To keep the '
          'history, archive it instead.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (confirmed) await cubit.delete();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitDetailCubit>();
    final state = context.watch<HabitDetailCubit>().state;
    final detail = state.detail;
    final archived = detail?.habit.archivedAt != null;
    return MultiBlocListener(
      listeners: [
        BlocListener<HabitDetailCubit, HabitDetailState>(
          listenWhen: (previous, current) =>
              previous.messageSerial != current.messageSerial,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message ?? ''))),
        ),
        BlocListener<HabitDetailCubit, HabitDetailState>(
          listenWhen: (previous, current) =>
              !previous.deleted && current.deleted,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text('Deleted ${detail?.habit.title ?? ''}')),
              );
            _leave(context);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: fallbackCloseButton(
            context,
            () => const HabitsRoute().go(context),
          ),
          title: Text(detail?.habit.title ?? 'Habit'),
          actions: [
            if (detail != null) ...[
              IconButton(
                tooltip: 'Edit habit',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => _edit(context, detail.habit.id),
              ),
              PopupMenuButton<_MenuAction>(
                tooltip: 'More',
                onSelected: (action) => switch (action) {
                  _MenuAction.archive => cubit.setArchived(archived: true),
                  _MenuAction.unarchive => cubit.setArchived(archived: false),
                  _MenuAction.delete => _delete(context),
                },
                itemBuilder: (_) => [
                  if (archived)
                    const PopupMenuItem(
                      value: _MenuAction.unarchive,
                      child: Text('Unarchive'),
                    )
                  else
                    const PopupMenuItem(
                      value: _MenuAction.archive,
                      child: Text('Archive'),
                    ),
                  const PopupMenuItem(
                    value: _MenuAction.delete,
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ],
        ),
        body: switch (state.status) {
          HabitDetailStatus.loading => const LoadingView(
            message: 'Loading the habit…',
          ),
          HabitDetailStatus.failed => ErrorView(
            message: "This habit couldn't be loaded.",
            onRetry: cubit.start,
          ),
          HabitDetailStatus.notFound => EmptyStateView(
            icon: Icons.search_off,
            title: "This habit doesn't exist any more",
            action: FilledButton.tonal(
              onPressed: () => const HabitsRoute().go(context),
              child: const Text('Go to Habits'),
            ),
          ),
          HabitDetailStatus.ready => _Detail(detail: detail!),
        },
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.detail});

  final HabitDetail detail;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitDetailCubit>();
    final theme = Theme.of(context);
    final habit = detail.habit;
    final tone = context.habitTone(habit.color);
    final archived = habit.archivedAt != null;
    final rate = detail.rate.ratio;
    final streakUnit = detail.streak.unit;
    final stats = [
      StatTile(
        label: 'Current streak',
        value: streakLength(detail.streak.current, streakUnit),
        icon: Icons.local_fire_department,
        iconColor: context.appColors.streak,
      ),
      StatTile(
        label: 'Longest streak',
        value: streakLength(detail.streak.longest, streakUnit),
      ),
      StatTile(
        label: 'Completion rate',
        value: rate == null ? '—' : '${(rate * 100).round()}%',
      ),
      StatTile(label: 'Times done', value: '${detail.totalCompletions}'),
    ];
    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        AppSpacing.large,
        AppSpacing.medium,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            // Its own node: a heading flag on a merged node would make
            // everything around it a heading too.
            container: true,
            header: true,
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          const SizedBox(height: AppSpacing.xSmall),
          ...children,
        ],
      ),
    );

    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xLarge),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: [
              HabitAvatar(icon: habit.icon, color: habit.color, size: 56),
              const SizedBox(width: AppSpacing.medium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheduleLabel(
                        habit.schedule,
                        dailyTarget: habit.dailyTarget,
                      ),
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${habit.category.label} · since '
                      '${DateLabels.short(habit.startDate)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (archived)
                      Text(
                        'Archived: its history is kept, and it is never due.',
                        style: theme.textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (habit.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Text(habit.description, style: theme.textTheme.bodyLarge),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.medium,
            AppSpacing.medium,
            AppSpacing.medium,
            0,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = context.prefersStackedLayout ? 1 : 2;
              final width =
                  (constraints.maxWidth - AppSpacing.xSmall * (columns - 1)) /
                  columns;
              return Wrap(
                spacing: AppSpacing.xSmall,
                runSpacing: AppSpacing.xSmall,
                children: [
                  for (final stat in stats) SizedBox(width: width, child: stat),
                ],
              );
            },
          ),
        ),
        section('Last 12 weeks', [
          Text(
            CalendarHeatmap.summary(detail.heatmap),
            style: theme.textTheme.bodyMedium,
          ),
          if (!archived)
            Text(
              'Tap a day in the last ${HabitHistory.backfillDays} to mark it '
              'done or not done.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(height: AppSpacing.small),
          CalendarHeatmap(
            days: detail.heatmap,
            tone: tone,
            onToggle: archived ? null : cubit.toggleDay,
          ),
          const SizedBox(height: AppSpacing.small),
          HeatmapLegend(tone: tone),
        ]),
        section('Each week', [
          WeeklyBarsChart(
            weeks: detail.weeks,
            color: theme.colorScheme.primary,
          ),
        ]),
      ],
    );
  }
}
