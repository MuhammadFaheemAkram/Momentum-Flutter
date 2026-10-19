import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';

/// A small number with − and + ("3 times a week"). The value is a live
/// region, so a screen reader hears it change.
class CountStepper extends StatelessWidget {
  const CountStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.labelOf,
    required this.decreaseTooltip,
    required this.increaseTooltip,
    required this.onChanged,
  });

  final int value;
  final int min;
  final int max;
  final String Function(int value) labelOf;
  final String decreaseTooltip;
  final String increaseTooltip;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton.outlined(
          tooltip: decreaseTooltip,
          onPressed: value > min ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: Semantics(
            liveRegion: true,
            child: Text(
              labelOf(value),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.small),
        IconButton.outlined(
          tooltip: increaseTooltip,
          onPressed: value < max ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
