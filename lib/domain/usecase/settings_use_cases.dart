import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

// One use case per setting the user changes. Each is a one-line update;
// as use cases they stay the only way the screens write settings, and the
// notification watcher picks every change up from the repository.

@injectable
class UpdateThemeModeUseCase {
  const UpdateThemeModeUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call(AppThemeMode mode) =>
      _settings.update((s) => s.copyWith(themeMode: mode));
}

@injectable
class UpdateDynamicColorUseCase {
  const UpdateDynamicColorUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call({required bool enabled}) =>
      _settings.update((s) => s.copyWith(dynamicColor: enabled));
}

/// The missed-habit nudge: on or off, and its time.
@injectable
class UpdateNudgeUseCase {
  const UpdateNudgeUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call({bool? enabled, TimeOfDayValue? time}) => _settings.update(
    (s) => s.copyWith(
      nudgeEnabled: enabled ?? s.nudgeEnabled,
      nudgeTime: time ?? s.nudgeTime,
    ),
  );
}

/// The daily summary: on or off, and its time.
@injectable
class UpdateSummaryUseCase {
  const UpdateSummaryUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call({bool? enabled, TimeOfDayValue? time}) => _settings.update(
    (s) => s.copyWith(
      summaryEnabled: enabled ?? s.summaryEnabled,
      summaryTime: time ?? s.summaryTime,
    ),
  );
}

/// The time a new habit's reminder starts at.
@injectable
class UpdateDefaultReminderUseCase {
  const UpdateDefaultReminderUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call(TimeOfDayValue time) =>
      _settings.update((s) => s.copyWith(defaultReminder: time));
}

@injectable
class SetAutoBackupUseCase {
  const SetAutoBackupUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call({required bool enabled}) =>
      _settings.update((s) => s.copyWith(autoBackup: enabled));
}
