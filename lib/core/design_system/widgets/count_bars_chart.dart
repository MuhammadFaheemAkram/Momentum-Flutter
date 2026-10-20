import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/widgets/chart_axis_label.dart';

/// Counts as bars, with each count over its bar and [labels] under them
/// (DevJourney's completions chart).
///
/// Screen readers hear [summary] instead: a chart has no text of its own,
/// so its meaning is written out.
class CountBarsChart extends StatelessWidget {
  const CountBarsChart({
    super.key,
    required this.counts,
    required this.labels,
    required this.summary,
  });

  final List<int> counts;
  final List<String> labels;
  final String summary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final most = counts.fold(0, math.max);
    return Semantics(
      label: summary,
      excludeSemantics: true,
      child: SizedBox(
        height: 170,
        child: BarChart(
          BarChartData(
            maxY: most == 0 ? 1 : most * 1.1,
            alignment: BarChartAlignment.spaceAround,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barTouchData: const BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: ChartAxisLabel.reservedSize(context),
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: ChartAxisLabel('${counts[value.toInt()]}'),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: ChartAxisLabel.reservedSize(context),
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: ChartAxisLabel(labels[value.toInt()]),
                  ),
                ),
              ),
            ),
            barGroups: [
              for (final (index, count) in counts.indexed)
                BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: count.toDouble(),
                      color: scheme.primary,
                      width: 18,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
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
