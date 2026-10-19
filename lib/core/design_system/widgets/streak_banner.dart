import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';

/// The perfect-day streak: a flame and the count, or how to start one.
class StreakBanner extends StatelessWidget {
  const StreakBanner({super.key, required this.perfectDays});

  final int perfectDays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = context.appColors.streak;
    final (title, subtitle) = switch (perfectDays) {
      0 => ('No perfect days yet', 'Do everything due today to start a run.'),
      1 => ('1 perfect day', 'Everything due, done.'),
      final n => ('$n perfect days', 'Everything due, done, $n days running.'),
    };
    return MergeSemantics(
      child: Row(
        children: [
          Icon(
            Icons.local_fire_department,
            size: 32,
            color: perfectDays == 0
                ? theme.colorScheme.onSurfaceVariant
                : color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: perfectDays == 0 ? null : color,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
