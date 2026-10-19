import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/domain/model/habit_enums.dart';

/// The days of the week as chips, Monday first; any number can be on.
/// Screen readers hear the full name ("Monday").
class WeekdayPicker extends StatelessWidget {
  const WeekdayPicker({
    super.key,
    required this.selected,
    required this.onToggled,
  });

  final Set<int> selected;
  final ValueChanged<int> onToggled;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xSmall,
      runSpacing: AppSpacing.xSmall,
      children: [
        for (var weekday = 1; weekday <= 7; weekday++)
          FilterChip(
            label: Text(
              weekdayShort(weekday),
              semanticsLabel: weekdayLong(weekday),
            ),
            selected: selected.contains(weekday),
            onSelected: (_) => onToggled(weekday),
          ),
      ],
    );
  }
}

/// The eight habit colors as swatches. The chosen one has a check (never
/// color alone), and each says its name to screen readers.
class HabitColorPicker extends StatelessWidget {
  const HabitColorPicker({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final HabitColor selected;
  final ValueChanged<HabitColor> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xxSmall,
      runSpacing: AppSpacing.xxSmall,
      children: [
        for (final color in HabitColor.values)
          () {
            final tone = context.habitTone(color);
            final isSelected = color == selected;
            // The tap is on the Semantics node: `excludeSemantics` would
            // drop the InkWell's, leaving a button nothing can press.
            return Semantics(
              button: true,
              selected: isSelected,
              label: color.label,
              onTap: () => onSelected(color),
              excludeSemantics: true,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => onSelected(color),
                child: SizedBox.square(
                  dimension: 48,
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: tone.container,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.onSurface,
                                width: 2,
                              )
                            : null,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: tone.onContainer, size: 20)
                          : null,
                    ),
                  ),
                ),
              ),
            );
          }(),
      ],
    );
  }
}

/// The habit icons, each a button that says its name.
class HabitIconPicker extends StatelessWidget {
  const HabitIconPicker({
    super.key,
    required this.selected,
    required this.color,
    required this.onSelected,
  });

  final HabitIcon selected;

  /// The habit's color, to show the chosen icon as it will look.
  final HabitColor color;
  final ValueChanged<HabitIcon> onSelected;

  @override
  Widget build(BuildContext context) {
    final tone = context.habitTone(color);
    return Wrap(
      spacing: AppSpacing.xxSmall,
      runSpacing: AppSpacing.xxSmall,
      children: [
        for (final icon in HabitIcon.values)
          IconButton(
            tooltip: icon.label,
            isSelected: icon == selected,
            style: icon == selected
                ? IconButton.styleFrom(
                    backgroundColor: tone.container,
                    foregroundColor: tone.onContainer,
                  )
                : null,
            onPressed: () => onSelected(icon),
            icon: Icon(icon.data),
          ),
      ],
    );
  }
}
