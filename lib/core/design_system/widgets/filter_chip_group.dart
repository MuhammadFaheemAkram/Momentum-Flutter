import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';

/// A row of single-choice chips with "All" first: picking a chip filters by
/// it, picking "All" (or the selected chip again) clears the filter.
///
/// It wraps onto more lines rather than scrolling sideways, so every choice
/// stays visible at large text sizes.
class FilterChipGroup<T> extends StatelessWidget {
  const FilterChipGroup({
    super.key,
    required this.values,
    required this.labelOf,
    required this.selected,
    required this.onSelected,
    this.allLabel = 'All',
  });

  final List<T> values;
  final String Function(T value) labelOf;

  /// `null` for "All".
  final T? selected;
  final ValueChanged<T?> onSelected;
  final String allLabel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xSmall,
      runSpacing: AppSpacing.xSmall,
      children: [
        ChoiceChip(
          label: Text(allLabel),
          selected: selected == null,
          onSelected: (_) => onSelected(null),
        ),
        for (final value in values)
          ChoiceChip(
            label: Text(labelOf(value)),
            selected: selected == value,
            onSelected: (isSelected) => onSelected(isSelected ? value : null),
          ),
      ],
    );
  }
}
