import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'app_settings.freezed.dart';

/// The appearance the user chose. "System" follows the device.
enum AppThemeMode {
  system('System'),
  light('Light'),
  dark('Dark');

  const AppThemeMode(this.label);

  final String label;
}

/// The device's preferences.
@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    /// Whether the user has left Welcome (with the demo, or empty).
    @Default(false) bool onboarded,
    @Default(AppThemeMode.system) AppThemeMode themeMode,

    /// Colors from the wallpaper (Android 12+). On by default, as Material
    /// You apps are; ignored where the device has none.
    @Default(true) bool dynamicColor,

    /// The master switch. Reads "on" only while the system allows
    /// notifications: turning it on asks for permission, and a permission
    /// revoked later turns it off at the next sync (correctness rule 8).
    @Default(false) bool notificationsEnabled,

    /// "2 habits left today", at [nudgeTime], while any due habit is open.
    @Default(true) bool nudgeEnabled,
    @Default(TimeOfDayValue.eightPm) TimeOfDayValue nudgeTime,

    /// "4 of 5 done today", at [summaryTime].
    @Default(true) bool summaryEnabled,
    @Default(TimeOfDayValue.nineThirtyPm) TimeOfDayValue summaryTime,

    /// The time a new habit's reminder starts at.
    @Default(TimeOfDayValue.nineAm) TimeOfDayValue defaultReminder,

    /// A backup once a day, from the background tasks.
    @Default(false) bool autoBackup,

    /// When the service last confirmed a backup (its receipt's time).
    DateTime? lastBackupAt,
  }) = _AppSettings;
}
