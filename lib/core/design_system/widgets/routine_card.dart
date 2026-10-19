import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/domain/model/routine.dart';

/// A routine with today's check-offs: its title, time of day, "3 / 4", and
/// a checkbox per step, in order. Done steps are crossed out as well as
/// checked (never color alone).
class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.progress,
    required this.onToggle,
    required this.onEdit,
  });

  final RoutineProgress progress;
  final void Function(RoutineItem item, {required bool checked}) onToggle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routine = progress.routine;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.xxSmall,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.medium,
              AppSpacing.xSmall,
              AppSpacing.xxSmall,
              0,
            ),
            child: Row(
              children: [
                Icon(routine.time.icon, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: MergeSemantics(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          container: true,
                          header: true,
                          child: Text(
                            routine.title,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          [
                            // "Morning · Morning" says nothing twice.
                            if (routine.title != routine.time.label)
                              routine.time.label,
                            '${progress.done} / ${progress.total}',
                            if (progress.isComplete) 'Done',
                          ].join(' · '),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: progress.isComplete
                                ? context.appColors.done
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Edit ${routine.title}',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          for (final item in routine.items)
            () {
              final checked = progress.checkedItemIds.contains(item.id);
              return CheckboxListTile(
                value: checked,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) => onToggle(item, checked: value ?? false),
                title: Text(
                  item.title,
                  style: checked
                      ? TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: theme.colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
              );
            }(),
          const SizedBox(height: AppSpacing.xSmall),
        ],
      ),
    );
  }
}

/// A routine in one line, for Today: its title, "3 / 4" and a bar. Tapping
/// it opens Routines, where the steps are checked off.
class RoutineSummaryTile extends StatelessWidget {
  const RoutineSummaryTile({
    super.key,
    required this.progress,
    required this.onTap,
  });

  final RoutineProgress progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routine = progress.routine;
    final ratio = progress.total == 0 ? 0.0 : progress.done / progress.total;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.xxSmall,
      ),
      clipBehavior: Clip.antiAlias,
      child: MergeSemantics(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: Row(
                children: [
                  Icon(routine.time.icon, color: theme.colorScheme.primary),
                  const SizedBox(width: AppSpacing.small),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(routine.title, style: theme.textTheme.titleMedium),
                        const SizedBox(height: AppSpacing.xxSmall),
                        ExcludeSemantics(
                          child: LinearProgressIndicator(
                            value: ratio,
                            color: progress.isComplete
                                ? context.appColors.done
                                : null,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.xxSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.small),
                  Text(
                    progress.isComplete
                        ? 'Done'
                        : '${progress.done} / ${progress.total}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: progress.isComplete
                          ? context.appColors.done
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
