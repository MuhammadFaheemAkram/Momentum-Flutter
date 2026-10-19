import 'package:injectable/injectable.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

/// Welcome → "Start empty": the first launch ends with no data, and the
/// router's gate opens Today.
@injectable
class StartEmptyUseCase {
  const StartEmptyUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call() => _settings.setOnboarded(onboarded: true);
}
