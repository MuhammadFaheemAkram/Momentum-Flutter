import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';

/// A goal with its progress now: the title, a bar, "18 of 25 this week",
/// what it counts, and when it resets. A met goal says so in words and with
/// a check (never color alone).
class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.progress,
    required this.today,
    this.onTap,
  });

  final GoalProgress progress;
  final CalendarDate today;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final goal = progress.goal;
    final met = progress.isMet;
    final period = goal.period.current;
    final counts = switch (goal.scope) {
      AllHabits() => 'All habits',
      OneHabit() => progress.habitTitle ?? 'One habit',
    };
    final resets = DateLabels.resets(progress.window.resets, today: today);
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(goal.title, style: theme.textTheme.titleMedium),
            ),
            if (met) Icon(Icons.check_circle, color: context.appColors.done),
          ],
        ),
        const SizedBox(height: AppSpacing.xSmall),
        Semantics(
          label: met ? 'Goal met' : '${(progress.ratio * 100).round()} percent',
          excludeSemantics: true,
          child: LinearProgressIndicator(
            value: progress.ratio,
            color: met ? context.appColors.done : null,
            borderRadius: BorderRadius.circular(AppSpacing.xxSmall),
          ),
        ),
        const SizedBox(height: AppSpacing.xSmall),
        Text(
          '${progress.current} of ${goal.target} $period',
          style: theme.textTheme.bodyMedium,
        ),
        Text(
          met ? 'Done $period · $resets' : '$counts · $resets',
          style: theme.textTheme.bodySmall?.copyWith(
            color: met
                ? context.appColors.done
                : theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.xxSmall,
      ),
      clipBehavior: Clip.antiAlias,
      // One button for screen readers: the tap target merges the text.
      child: MergeSemantics(
        child: Semantics(
          button: onTap != null,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: details,
            ),
          ),
        ),
      ),
    );
  }
}
