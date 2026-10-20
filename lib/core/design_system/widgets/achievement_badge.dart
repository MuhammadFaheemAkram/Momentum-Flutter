import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/calendar_date.dart';

/// A badge: unlocked (its icon filled, "Unlocked 12 Oct") or locked (an
/// outline, the rule, and the progress toward it). The state is in words,
/// never color alone; a screen reader hears the tile as one.
class AchievementBadge extends StatelessWidget {
  const AchievementBadge({
    super.key,
    required this.status,
    required this.today,
  });

  final AchievementStatus status;
  final CalendarDate today;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final id = status.id;
    final unlock = status.unlock;
    final progress = status.progress;
    return Card(
      margin: EdgeInsets.zero,
      color: unlock != null ? scheme.secondaryContainer : null,
      child: MergeSemantics(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unlock != null ? scheme.primary : null,
                  border: unlock != null
                      ? null
                      : Border.all(color: scheme.outline, width: 2),
                ),
                child: Icon(
                  id.icon,
                  color: unlock != null
                      ? scheme.onPrimary
                      : scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xSmall),
              Text(
                id.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: unlock != null ? scheme.onSecondaryContainer : null,
                ),
              ),
              const SizedBox(height: AppSpacing.xxSmall),
              if (unlock != null)
                Text(
                  'Unlocked ${DateLabels.inSentence(unlock.unlockedOn, today: today)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSecondaryContainer,
                  ),
                )
              else ...[
                Text(
                  id.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xSmall),
                ExcludeSemantics(
                  child: LinearProgressIndicator(
                    value: progress.ratio,
                    color: progress.isMet ? context.appColors.done : null,
                    borderRadius: BorderRadius.circular(AppSpacing.xxSmall),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxSmall),
                Text(
                  'Locked · ${progress.label}',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
