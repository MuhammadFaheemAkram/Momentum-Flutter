import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/domain/model/habit_enums.dart';

/// A habit's icon on its own color: how the habit is recognised at a
/// glance. Decorative: the habit's name is always beside it.
class HabitAvatar extends StatelessWidget {
  const HabitAvatar({
    super.key,
    required this.icon,
    required this.color,
    this.size = 44,
  });

  final HabitIcon icon;
  final HabitColor color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final tone = context.habitTone(color);
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: tone.container,
          shape: BoxShape.circle,
        ),
        child: Icon(icon.data, color: tone.onContainer, size: size * 0.55),
      ),
    );
  }
}
