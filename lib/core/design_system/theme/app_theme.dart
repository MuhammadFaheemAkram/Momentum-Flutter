import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/app_radius.dart';

/// Builds the app's Material 3 light and dark themes.
///
/// Screens style themselves through `Theme.of(context)`, never with hard-coded
/// colors. The default scheme comes from one seed (a green, for growth);
/// [fromWallpaper] builds one from the wallpaper's color instead ("dynamic
/// color", Android 12+), without touching a screen.
abstract final class AppTheme {
  static const Color seedColor = Color(0xFF0F9D7A);

  static ThemeData light() => fromScheme(_seeded(Brightness.light));

  static ThemeData dark() => fromScheme(_seeded(Brightness.dark));

  /// A theme from the wallpaper's main [color] (Material You).
  static ThemeData fromWallpaper(Color color, Brightness brightness) =>
      fromScheme(
        ColorScheme.fromSeed(seedColor: color, brightness: brightness),
      );

  static ColorScheme _seeded(Brightness brightness) => ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
    // `fidelity` keeps the primary color close to the seed; the default
    // variant (`tonalSpot`) would noticeably mute it.
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  );

  static ThemeData fromScheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      extensions: [
        if (colorScheme.brightness == Brightness.light)
          AppColors.light
        else
          AppColors.dark,
      ],
      cardTheme: const CardThemeData(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.medium)),
        ),
      ),
      chipTheme: const ChipThemeData(shape: StadiumBorder()),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.small)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
