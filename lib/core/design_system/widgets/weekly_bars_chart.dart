import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/core/design_system/widgets/chart_axis_label.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

/// Done days per week, each bar against the days its week asked for (the
/// pale bar behind it), with "5/7" over each.
///
/// Screen readers hear [summary] instead: a chart has no text of its own,
/// so its meaning is written out.
class WeeklyBarsChart extends StatelessWidget {
  const WeeklyBarsChart({super.key, required this.weeks, required this.color});

  final List<WeekBar> weeks;

  /// The habit's color, for the bars.
  final Color color;

  /// "Last 8 weeks: 34 of 48 days done. Best: 7 of 7, week of 12 Oct."
  static String summary(List<WeekBar> weeks) {
    final done = weeks.fold(0, (sum, w) => sum + w.done);
    final target = weeks.fold(0, (sum, w) => sum + w.target);
    final asked = weeks.where((w) => w.target > 0).toList();
    final text = StringBuffer(
      'Last ${weeks.length} weeks: $done of $target days done.',
    );
    if (asked.isNotEmpty) {
      final best = asked.reduce(
        (a, b) => b.done / b.target > a.done / a.target ? b : a,
      );
      text.write(
        ' Best: ${best.done} of ${best.target}, week of '
        '${DateLabels.dayMonth(best.weekStart)}.',
      );
    }
    return text.toString();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final most = weeks.fold(
      1,
      (most, w) => math.max(most, math.max(w.done, w.target)),
    );
    return Semantics(
      label: summary(weeks),
      excludeSemantics: true,
      child: SizedBox(
        height: 180,
        child: BarChart(
          BarChartData(
            maxY: most.toDouble(),
            alignment: BarChartAlignment.spaceAround,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barTouchData: const BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
              // The figures over each bar: the numbers, not just heights.
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: ChartAxisLabel.reservedSize(context),
                  getTitlesWidget: (value, meta) {
                    final week = weeks[value.toInt()];
                    return SideTitleWidget(
                      meta: meta,
                      child: ChartAxisLabel('${week.done}/${week.target}'),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: ChartAxisLabel.reservedSize(context),
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: ChartAxisLabel(
                      DateLabels.dayMonth(weeks[value.toInt()].weekStart),
                    ),
                  ),
                ),
              ),
            ),
            barGroups: [
              for (final (index, week) in weeks.indexed)
                BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: math.min(week.done, most).toDouble(),
                      color: color,
                      width: 18,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: week.target > 0,
                        toY: week.target.toDouble(),
                        color: scheme.surfaceContainerHighest,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
