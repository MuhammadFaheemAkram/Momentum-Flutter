import 'package:material_ui/material_ui.dart';

/// The two tones a habit is drawn with: a [container] fill (its avatar, its
/// heatmap cells) and an [onContainer] color for the icon or text on it.
@immutable
final class HabitTone {
  const HabitTone({required this.container, required this.onContainer});

  final Color container;
  final Color onContainer;
}

/// The eight colors a habit can have, by name (the domain stores the name,
/// so a palette tweak never needs a migration).
///
/// Each tone comes from Material's own tonal system: a [ColorScheme] seeded
/// with the habit's color gives its `primaryContainer` and
/// `onPrimaryContainer`, a pair designed to be readable together in light
/// and dark (a test checks AA). The schemes are built once and cached.
abstract final class HabitPalette {
  static const seeds = <String, Color>{
    'green': Color(0xFF2E7D32),
    'teal': Color(0xFF00897B),
    'blue': Color(0xFF1E88E5),
    'indigo': Color(0xFF3949AB),
    'purple': Color(0xFF8E24AA),
    'pink': Color(0xFFD81B60),
    'orange': Color(0xFFF4511E),
    'amber': Color(0xFFFFB300),
  };

  /// The names, in the order the color picker shows them.
  static List<String> get names => seeds.keys.toList();

  static final _cache = <(String, Brightness), HabitTone>{};

  /// The tone for [name] in [brightness]; an unknown name falls back to the
  /// first color.
  static HabitTone tone(String name, Brightness brightness) =>
      _cache.putIfAbsent((name, brightness), () {
        final scheme = ColorScheme.fromSeed(
          seedColor: seeds[name] ?? seeds.values.first,
          brightness: brightness,
        );
        return HabitTone(
          container: scheme.primaryContainer,
          onContainer: scheme.onPrimaryContainer,
        );
      });
}
