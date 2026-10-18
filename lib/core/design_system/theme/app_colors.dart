import 'package:material_ui/material_ui.dart';

/// Habit-tracking colors that Material's [ColorScheme] has no slot for.
///
/// A [ThemeExtension] travels inside [ThemeData], so the light and dark
/// variants switch automatically (and animate via [lerp]) when the theme
/// changes. Widgets ask for an *intent* (`done`, `missed`, `streak`) instead
/// of hard-coding raw colors.
///
/// All are text and icon colors: they sit on the page and on cards, so each
/// must reach WCAG AA (4.5:1) against those surfaces in both themes (checked
/// by a test). Color is never the only signal: a done day also has a check,
/// a skipped one a skip icon and the word.
@immutable
final class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.done,
    required this.skipped,
    required this.missed,
    required this.streak,
  });

  /// A habit done for the day, a goal met, a badge unlocked.
  final Color done;

  /// A day the user chose to skip: neutral, neither done nor missed.
  final Color skipped;

  /// A due day that passed without the habit done.
  final Color missed;

  /// The streak's flame and count.
  final Color streak;

  static const light = AppColors(
    done: Color(0xFF146C2E),
    skipped: Color(0xFF5B5F66),
    missed: Color(0xFFB3261E),
    streak: Color(0xFFA8440B),
  );

  static const dark = AppColors(
    done: Color(0xFF86D993),
    skipped: Color(0xFFC3C6CF),
    missed: Color(0xFFFF9C92),
    streak: Color(0xFFFFB68C),
  );

  @override
  AppColors copyWith({
    Color? done,
    Color? skipped,
    Color? missed,
    Color? streak,
  }) {
    return AppColors(
      done: done ?? this.done,
      skipped: skipped ?? this.skipped,
      missed: missed ?? this.missed,
      streak: streak ?? this.streak,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      done: Color.lerp(done, other.done, t)!,
      skipped: Color.lerp(skipped, other.skipped, t)!,
      missed: Color.lerp(missed, other.missed, t)!,
      streak: Color.lerp(streak, other.streak, t)!,
    );
  }
}

/// Shorthand for `Theme.of(context).extension<AppColors>()!`.
extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
