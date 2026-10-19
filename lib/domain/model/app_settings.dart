import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// The device's preferences. Phase 6 adds the appearance, dynamic color,
/// notifications and backups.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    /// Whether the user has left Welcome (with the demo, or empty).
    @Default(false) bool onboarded,
  }) = _AppSettings;
}
