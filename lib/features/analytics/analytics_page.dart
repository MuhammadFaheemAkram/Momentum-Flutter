import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/analytics.dart';
import 'package:momentum/features/analytics/cubit/analytics_cubit.dart';
import 'package:momentum/features/analytics/cubit/analytics_state.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Analytics (the third tab).
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AnalyticsCubit>()..start(),
      child: const AnalyticsView(),
    );
  }
}

/// The figures, then the weekly and monthly bars, the longest streaks, the
/// most successful habit and the categories. Every chart has a written
/// summary for screen readers.
class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalyticsCubit>();
    final state = context.watch<AnalyticsCubit>().state;
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Analytics'),
      ),
      body: switch (state.status) {
        AnalyticsStatus.loading => const LoadingView(
          message: 'Adding things up…',
        ),
        AnalyticsStatus.failed => ErrorView(
          message: "Analytics couldn't be loaded.",
          onRetry: cubit.start,
        ),
        AnalyticsStatus.ready when state.overview!.isEmpty =>
          const EmptyStateView(
            icon: Icons.insights_outlined,
            title: 'Nothing to add up yet',
            message:
                'Complete a habit, and your rates, streaks and best weeks '
                'appear here.',
          ),
        AnalyticsStatus.ready => _Analytics(overview: state.overview!),
      },
    );
  }
}

class _Analytics extends StatelessWidget {
  const _Analytics({required this.overview});

  final AnalyticsOverview overview;

  static String _busiest(
    List<PeriodCount> periods,
    String Function(PeriodCount) name,
  ) {
    final best = periods.reduce((a, b) => b.count > a.count ? b : a);
    return best.count == 0 ? '' : ' Most: ${name(best)}, ${best.count}.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rate = overview.rate30.ratio;
    final score = overview.consistencyScore;
    final best = overview.bestStreak;
    final weeklyTotal = overview.weekly.fold(0, (sum, p) => sum + p.count);
    final monthlyTotal = overview.monthly.fold(0, (sum, p) => sum + p.count);
    final stats = [
      StatTile(
        label: 'Completion rate, 30 days',
        value: rate == null ? '—' : '${(rate * 100).round()}%',
      ),
      StatTile(
        label: 'Consistency score',
        value: score == null ? 'Not yet' : '$score',
      ),
      StatTile(
        label: 'Best current streak',
        value: best == null
            ? 'None yet'
            : '${streakLength(best.streak.current, best.streak.unit)} · '
                  '${best.habit.title}',
        icon: Icons.local_fire_department,
        iconColor: context.appColors.streak,
      ),
      StatTile(label: 'Times done', value: '${overview.totalCompletions}'),
      StatTile(
        label: 'Perfect days this month',
        value: '${overview.perfectDaysThisMonth}',
      ),
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
      padding: const EdgeInsets.only(
        top: AppSpacing.medium,
        bottom: AppSpacing.xLarge,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
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
        if (score == null)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.medium,
              AppSpacing.xSmall,
              AppSpacing.medium,
              0,
            ),
            child: Text(
              'The consistency score appears after a week or so of habits.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        section('Each week', [
          CountBarsChart(
            counts: [for (final p in overview.weekly) p.count],
            labels: [
              for (final p in overview.weekly) DateLabels.dayMonth(p.start),
            ],
            summary:
                'Last 8 weeks: $weeklyTotal completions.'
                '${_busiest(overview.weekly, (p) => 'the week of ${DateLabels.dayMonth(p.start)}')}',
          ),
        ]),
        section('Each month', [
          CountBarsChart(
            counts: [for (final p in overview.monthly) p.count],
            labels: [
              for (final p in overview.monthly) DateLabels.month(p.start),
            ],
            summary:
                'Last 6 months: $monthlyTotal completions.'
                '${_busiest(overview.monthly, (p) => DateLabels.monthYear(p.start))}',
          ),
        ]),
        if (overview.mostSuccessful case final top?)
          section('Most successful', [
            Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: HabitAvatar(
                  icon: top.habit.icon,
                  color: top.habit.color,
                ),
                title: Text(top.habit.title),
                subtitle: Text(
                  '${(top.rate.ratio! * 100).round()}% done since '
                  '${DateLabels.short(top.habit.startDate)}',
                ),
              ),
            ),
          ]),
        if (overview.longestStreaks.isNotEmpty)
          section('Longest streaks', [
            for (final entry in overview.longestStreaks)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: HabitAvatar(
                  icon: entry.habit.icon,
                  color: entry.habit.color,
                  size: 36,
                ),
                title: Text(entry.habit.title),
                trailing: Text(
                  streakLength(entry.streak.longest, entry.streak.unit),
                  style: theme.textTheme.titleSmall,
                ),
              ),
          ]),
        if (overview.categories.isNotEmpty)
          section('By category', [
            for (final share in overview.categories)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.small),
                child: MergeSemantics(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              share.category.label,
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                          Text(
                            '${share.count} · ${(share.ratio * 100).round()}%',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxSmall),
                      ExcludeSemantics(
                        child: LinearProgressIndicator(
                          value: share.ratio,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.xxSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ]),
      ],
    );
  }
}
