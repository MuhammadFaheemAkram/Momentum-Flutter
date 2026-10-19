import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/habit_palette.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_enums.dart';

extension HabitIconData on HabitIcon {
  IconData get data => switch (this) {
    HabitIcon.water => Icons.water_drop_outlined,
    HabitIcon.run => Icons.directions_run,
    HabitIcon.book => Icons.menu_book_outlined,
    HabitIcon.language => Icons.translate,
    HabitIcon.savings => Icons.savings_outlined,
    HabitIcon.checklist => Icons.checklist,
    HabitIcon.meditation => Icons.self_improvement,
    HabitIcon.sleep => Icons.bedtime_outlined,
    HabitIcon.fitness => Icons.fitness_center,
    HabitIcon.heart => Icons.favorite_outline,
    HabitIcon.music => Icons.music_note_outlined,
    HabitIcon.code => Icons.code,
  };
}

extension RoutineTimeIcon on RoutineTime {
  IconData get icon => switch (this) {
    RoutineTime.morning => Icons.wb_twilight_outlined,
    RoutineTime.afternoon => Icons.wb_sunny_outlined,
    RoutineTime.evening => Icons.nights_stay_outlined,
    RoutineTime.anytime => Icons.schedule,
  };
}

extension HabitToneOf on BuildContext {
  /// [color]'s tone for the current theme.
  HabitTone habitTone(HabitColor color) =>
      HabitPalette.tone(color.name, Theme.of(this).brightness);
}

extension DayStateVisuals on DayState {
  /// The icon a state is shown with: never color alone.
  IconData get icon => switch (this) {
    DayState.done => Icons.check,
    DayState.partial => Icons.timelapse,
    DayState.skipped => Icons.redo,
    DayState.missed => Icons.close,
    DayState.open => Icons.radio_button_unchecked,
    DayState.none || DayState.future => Icons.remove,
  };

  /// The state's text color, readable on the page and on cards (AA,
  /// tested with `AppColors`).
  Color color(BuildContext context) => switch (this) {
    DayState.done => context.appColors.done,
    DayState.skipped => context.appColors.skipped,
    DayState.missed => context.appColors.missed,
    DayState.partial || DayState.open => Theme.of(context).colorScheme.primary,
    DayState.none ||
    DayState.future => Theme.of(context).colorScheme.onSurfaceVariant,
  };
}
