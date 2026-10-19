import 'package:material_ui/material_ui.dart';

/// A chart's axis label.
///
/// It grows with the text setting only up to 150 %: past that, neighbouring
/// labels collide (eight weeks share a phone's width). The labels only
/// orient: screen readers hear each chart's written summary instead, and
/// the figures themselves are in full-size text (conventions §11.49).
class ChartAxisLabel extends StatelessWidget {
  const ChartAxisLabel(this.text, {super.key});

  final String text;

  static const _maxScale = 1.5;

  static TextScaler _scaler(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: _maxScale);

  /// The height to reserve under a chart for one line of labels.
  static double reservedSize(BuildContext context) =>
      _scaler(context).scale(12) * 1.4 + 8;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodySmall,
    textScaler: _scaler(context),
  );
}
