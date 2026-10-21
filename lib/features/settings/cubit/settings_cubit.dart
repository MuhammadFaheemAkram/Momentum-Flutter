import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/device_info.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/domain/usecase/settings_use_cases.dart';
import 'package:momentum/features/settings/cubit/settings_state.dart';

/// The settings, app-wide: provided above `MaterialApp.router`, so the
/// theme mode and dynamic color apply to every screen at once, and the
/// Settings tab reads and changes them (as in DevJourney).
///
/// It starts from the settings loaded before the first frame, so the theme
/// never flashes the wrong mode.
@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._settings,
    this._updateThemeMode,
    this._updateDynamicColor,
    DeviceColors deviceColors,
  ) : super(
        SettingsState(settings: _settings.current, deviceColors: deviceColors),
      );

  final SettingsRepository _settings;
  final UpdateThemeModeUseCase _updateThemeMode;
  final UpdateDynamicColorUseCase _updateDynamicColor;

  StreamSubscription<AppSettings>? _changes;

  void load() {
    _changes ??= _settings.watch().listen(
      (settings) => emit(state.copyWith(settings: settings)),
    );
  }

  Future<void> setThemeMode(AppThemeMode mode) => _updateThemeMode(mode);

  Future<void> setDynamicColor({required bool enabled}) =>
      _updateDynamicColor(enabled: enabled);

  @override
  Future<void> close() async {
    await _changes?.cancel();
    return super.close();
  }
}
