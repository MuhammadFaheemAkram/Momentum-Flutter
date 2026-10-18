import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';

double contrast(Color a, Color b) {
  final (hi, lo) = (a.computeLuminance(), b.computeLuminance());
  return hi > lo ? (hi + 0.05) / (lo + 0.05) : (lo + 0.05) / (hi + 0.05);
}

void main() {
  group('AppTheme', () {
    test('builds Material 3 light and dark themes from the seed', () {
      final light = AppTheme.light();
      final dark = AppTheme.dark();

      expect(light.useMaterial3, isTrue);
      expect(light.colorScheme.brightness, Brightness.light);
      expect(dark.colorScheme.brightness, Brightness.dark);
    });

    test('registers the matching AppColors extension for each brightness', () {
      expect(AppTheme.light().extension<AppColors>(), same(AppColors.light));
      expect(AppTheme.dark().extension<AppColors>(), same(AppColors.dark));
    });

    test('any scheme can drive it (dynamic color will)', () {
      final scheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF6750A4),
        brightness: Brightness.dark,
      );

      final theme = AppTheme.fromScheme(scheme);

      expect(theme.colorScheme, scheme);
      expect(theme.extension<AppColors>(), same(AppColors.dark));
    });
  });

  group('AppColors', () {
    test('lerp interpolates every token', () {
      final mid = AppColors.light.lerp(AppColors.dark, 0.5);

      Color? halfway(Color Function(AppColors) token) =>
          Color.lerp(token(AppColors.light), token(AppColors.dark), 0.5);
      expect(mid.done, halfway((c) => c.done));
      expect(mid.skipped, halfway((c) => c.skipped));
      expect(mid.missed, halfway((c) => c.missed));
      expect(mid.streak, halfway((c) => c.streak));
    });

    test('lerp towards a missing extension keeps the current colors', () {
      expect(AppColors.light.lerp(null, 0.5), same(AppColors.light));
    });

    test('copyWith replaces only the given tokens', () {
      const purple = Color(0xFF7B1FA2);
      final copy = AppColors.light.copyWith(streak: purple);

      expect(copy.streak, purple);
      expect(copy.done, AppColors.light.done);
      expect(copy.missed, AppColors.light.missed);
    });
  });

  // WCAG contrast checks, so a color tweak can't silently make a label
  // unreadable. The habit colors are text and icon colors on the page, on
  // cards and on filled fields, so each must reach AA (4.5:1) on all of
  // them.
  group('Contrast in both themes', () {
    for (final theme in [AppTheme.light(), AppTheme.dark()]) {
      final name = theme.colorScheme.brightness.name;
      final colors = theme.extension<AppColors>()!;
      final scheme = theme.colorScheme;
      final surfaces = {
        'the page': scheme.surface,
        'a card': scheme.surfaceContainerLow,
        'a filled field': scheme.surfaceContainerHighest,
      };

      for (final (token, color) in [
        ('done', colors.done),
        ('skipped', colors.skipped),
        ('missed', colors.missed),
        ('streak', colors.streak),
      ]) {
        for (final MapEntry(key: surface, value: background)
            in surfaces.entries) {
          test('$name: $token text on $surface meets AA (4.5:1)', () {
            expect(contrast(color, background), greaterThanOrEqualTo(4.5));
          });
        }
      }
    }
  });

  group('HabitPalette', () {
    test('eight named colors', () {
      expect(HabitPalette.names, [
        'green',
        'teal',
        'blue',
        'indigo',
        'purple',
        'pink',
        'orange',
        'amber',
      ]);
    });

    for (final brightness in Brightness.values) {
      for (final name in HabitPalette.names) {
        test('${brightness.name}: $name is readable on itself (AA)', () {
          final tone = HabitPalette.tone(name, brightness);
          expect(
            contrast(tone.onContainer, tone.container),
            greaterThanOrEqualTo(4.5),
          );
        });
      }
    }

    test('tones are cached, and an unknown name falls back', () {
      final green = HabitPalette.tone('green', Brightness.light);

      expect(HabitPalette.tone('green', Brightness.light), same(green));
      expect(
        HabitPalette.tone('plaid', Brightness.light).container,
        green.container,
      );
    });

    test('light and dark tones differ', () {
      expect(
        HabitPalette.tone('blue', Brightness.light).container,
        isNot(HabitPalette.tone('blue', Brightness.dark).container),
      );
    });
  });
}
