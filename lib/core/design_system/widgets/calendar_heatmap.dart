import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/theme/habit_palette.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

/// A habit's last weeks as a calendar: a row per week, Monday first, a cell
/// per day with its date and an icon for its state (never color alone).
///
/// Built from widgets rather than painted: each day is its own semantics
/// node ("Mon, 12 Oct: done"), and the days that can still be changed are
/// buttons at least 48 points square that toggle done (backfill). A
/// written [summary] of the whole period comes first.
class CalendarHeatmap extends StatelessWidget {
  const CalendarHeatmap({
    super.key,
    required this.days,
    required this.tone,
    required this.onToggle,
  });

  /// Whole weeks, Monday to Sunday, oldest first.
  final List<HeatmapDay> days;

  /// The habit's colors, for done days.
  final HabitTone tone;
  final ValueChanged<HeatmapDay>? onToggle;

  /// "Done on 41 days, partly on 2, skipped 3, missed 5." Days before the
  /// habit started, or not due, aren't counted either way.
  static String summary(List<HeatmapDay> days) {
    int count(DayState state) => days.where((d) => d.state == state).length;
    return [
      'Done on ${countLabel(count(DayState.done), 'day')}',
      if (count(DayState.partial) > 0) 'partly on ${count(DayState.partial)}',
      if (count(DayState.skipped) > 0) 'skipped ${count(DayState.skipped)}',
      if (count(DayState.missed) > 0) 'missed ${count(DayState.missed)}',
    ].join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weeks = [
      for (var i = 0; i < days.length; i += 7) days.sublist(i, i + 7),
    ];
    // The dates must fit their cells: they grow with the text setting up to
    // 130 %, and each day's full label is read by screen readers anyway.
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: Row(
              children: [
                for (var weekday = 1; weekday <= 7; weekday++)
                  Expanded(
                    child: Text(
                      weekdayShort(weekday).substring(0, 1),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxSmall),
          for (final week in weeks)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  for (final (i, day) in week.indexed) ...[
                    if (i > 0) const SizedBox(width: 2),
                    Expanded(
                      child: _Cell(
                        day: day,
                        tone: tone,
                        showMonth:
                            day.day.day == 1 || identical(day, days.first),
                        onToggle: onToggle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.day,
    required this.tone,
    required this.showMonth,
    required this.onToggle,
  });

  final HeatmapDay day;
  final HabitTone tone;
  final bool showMonth;
  final ValueChanged<HeatmapDay>? onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final state = day.state;
    if (state == DayState.future) return const SizedBox(height: 48);
    final (fill, ink, border) = switch (state) {
      DayState.done => (tone.container, tone.onContainer, null),
      DayState.partial => (
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
        null,
      ),
      DayState.skipped => (
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
        null,
      ),
      DayState.missed => (scheme.errorContainer, scheme.onErrorContainer, null),
      DayState.open => (scheme.surface, scheme.onSurface, scheme.primary),
      DayState.none || DayState.future => (
        scheme.surfaceContainerLow,
        scheme.onSurfaceVariant,
        null,
      ),
    };
    final date = day.day;
    final canToggle = day.canSet && onToggle != null;
    final label =
        '${weekdayShort(date.weekday)}, ${DateLabels.dayMonth(date)}: '
        '${state.label}';
    final cell = Container(
      height: 48,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(6),
        border: border == null ? null : Border.all(color: border, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            showMonth ? DateLabels.dayMonth(date) : '${date.day}',
            style: theme.textTheme.labelSmall?.copyWith(color: ink),
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
          if (state != DayState.none) Icon(state.icon, size: 14, color: ink),
        ],
      ),
    );
    // The tap is on the Semantics node itself: `excludeSemantics` would
    // drop the InkWell's, leaving a "button" a screen reader can't press.
    return Semantics(
      label: label,
      button: canToggle,
      onTap: canToggle ? () => onToggle!(day) : null,
      onTapHint: canToggle
          ? (state == DayState.done ? 'mark not done' : 'mark done')
          : null,
      excludeSemantics: true,
      child: canToggle
          ? InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => onToggle!(day),
              child: cell,
            )
          : cell,
    );
  }
}

/// What the heatmap's colors and icons mean.
class HeatmapLegend extends StatelessWidget {
  const HeatmapLegend({super.key, required this.tone});

  final HabitTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final entries = [
      (DayState.done, tone.container, tone.onContainer),
      (
        DayState.partial,
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
      (
        DayState.skipped,
        scheme.surfaceContainerHighest,
        scheme.onSurfaceVariant,
      ),
      (DayState.missed, scheme.errorContainer, scheme.onErrorContainer),
    ];
    return ExcludeSemantics(
      child: Wrap(
        spacing: AppSpacing.medium,
        runSpacing: AppSpacing.xSmall,
        children: [
          for (final (state, fill, ink) in entries)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(state.icon, size: 14, color: ink),
                ),
                const SizedBox(width: AppSpacing.xxSmall),
                Text(state.label, style: theme.textTheme.bodySmall),
              ],
            ),
        ],
      ),
    );
  }
}
