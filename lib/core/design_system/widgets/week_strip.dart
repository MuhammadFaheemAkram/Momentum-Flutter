import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/domain/calculation/perfect_days.dart';

/// This week at a glance: a dot per day, Monday first, with an icon in each
/// (never color alone). Screen readers hear the week as one sentence.
class WeekStrip extends StatelessWidget {
  const WeekStrip({super.key, required this.days, required this.todayWeekday});

  /// Monday to Sunday.
  final List<DayDot> days;
  final int todayWeekday;

  static String _word(DayDot dot) => switch (dot) {
    DayDot.perfect => 'perfect',
    DayDot.partial => 'partly done',
    DayDot.missed => 'missed',
    DayDot.empty => 'nothing due',
    DayDot.future => 'to come',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.appColors;
    final summary = [
      for (final (i, dot) in days.indexed)
        if (dot != DayDot.future)
          '${weekdayLong(i + 1)} ${i + 1 == todayWeekday ? '(today) ' : ''}'
              '${_word(dot)}',
    ].join(', ');
    return Semantics(
      label: 'This week: $summary',
      excludeSemantics: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final (i, dot) in days.indexed)
            Column(
              children: [
                Text(
                  weekdayShort(i + 1).substring(0, 1),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: i + 1 == todayWeekday
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                    fontWeight: i + 1 == todayWeekday ? FontWeight.bold : null,
                  ),
                ),
                const SizedBox(height: 4),
                _Dot(dot: dot, colors: colors, scheme: scheme),
              ],
            ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.dot, required this.colors, required this.scheme});

  final DayDot dot;
  final AppColors colors;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final (fill, border, icon, iconColor) = switch (dot) {
      DayDot.perfect => (colors.done, null, Icons.check, scheme.surface),
      DayDot.partial => (
        scheme.secondaryContainer,
        null,
        Icons.timelapse,
        scheme.onSecondaryContainer,
      ),
      DayDot.missed => (null, colors.missed, Icons.close, colors.missed),
      DayDot.empty => (null, scheme.outlineVariant, null, null),
      DayDot.future => (null, scheme.outlineVariant, null, null),
    };
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: border == null ? null : Border.all(color: border, width: 2),
      ),
      child: icon == null ? null : Icon(icon, size: 18, color: iconColor),
    );
  }
}
