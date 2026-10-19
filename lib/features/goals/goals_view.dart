import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/features/goals/cubit/goals_cubit.dart';
import 'package:momentum/features/goals/cubit/goals_state.dart';
import 'package:momentum/features/goals/widgets/goal_editor_sheet.dart';

/// Goals by period (daily, weekly, monthly), each with its progress now;
/// added and edited in a bottom sheet.
class GoalsView extends StatelessWidget {
  const GoalsView({super.key});

  static Future<void> _edit(BuildContext context, {Goal? goal}) async {
    final cubit = context.read<GoalsCubit>();
    final state = cubit.state;
    final result = await showAppSheet<GoalEditorResult>(
      context,
      (_) => GoalEditorSheet(
        habits: state.habits,
        existing: goal,
        period: state.period,
      ),
    );
    switch (result) {
      case SaveGoalResult(:final draft):
        await cubit.save(draft, id: goal?.id);
      case DeleteGoalResult():
        await cubit.delete(goal!);
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoalsCubit>();
    final state = context.watch<GoalsCubit>().state;
    return BlocListener<GoalsCubit, GoalsState>(
      listenWhen: (previous, current) =>
          previous.messageSerial != current.messageSerial,
      listener: (context, state) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(state.message ?? ''))),
      child: Scaffold(
        appBar: AppBar(
          leading: fallbackCloseButton(
            context,
            () => const TodayRoute().go(context),
          ),
          title: const Text('Goals'),
        ),
        floatingActionButton: state.status == GoalsStatus.ready
            ? FloatingActionButton.extended(
                onPressed: () => _edit(context),
                icon: const Icon(Icons.add),
                label: const Text('New goal'),
              )
            : null,
        body: switch (state.status) {
          GoalsStatus.loading => const LoadingView(
            message: 'Loading your goals…',
          ),
          GoalsStatus.failed => ErrorView(
            message: "Your goals couldn't be loaded.",
            onRetry: cubit.start,
          ),
          GoalsStatus.ready => ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.medium),
                child: SegmentedChoice<GoalPeriod>(
                  values: GoalPeriod.values,
                  labelOf: (period) => switch (state.countFor(period)) {
                    0 => period.label,
                    final n => '${period.label} ($n)',
                  },
                  selected: state.period,
                  onSelected: cubit.showPeriod,
                ),
              ),
              if (state.visible.isEmpty) _NoGoals(period: state.period),
              for (final progress in state.visible)
                GoalCard(
                  progress: progress,
                  today: state.today!,
                  onTap: () => _edit(context, goal: progress.goal),
                ),
            ],
          ),
        },
      ),
    );
  }
}

/// Inside the list (an `EmptyStateView` scrolls by itself, and can't sit in
/// a `ListView`).
class _NoGoals extends StatelessWidget {
  const _NoGoals({required this.period});

  final GoalPeriod period;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        children: [
          Icon(
            Icons.flag_outlined,
            size: AppIconSize.large,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'No ${period.label.toLowerCase()} goals',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xSmall),
          Text(
            'A goal counts your habits over a day, a week or a month: '
            '"complete 25 habits this week".',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
