import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/repository/demo_repository.dart';
import 'package:momentum/domain/repository/settings_repository.dart';

/// Welcome → "Explore with demo data": the demo is written first; only if
/// that succeeds does the first launch end (the router's gate then opens
/// Today), so a failure leaves the user on Welcome with nothing half-done.
@injectable
class LoadDemoUseCase {
  const LoadDemoUseCase(this._demo, this._settings);

  final DemoRepository _demo;
  final SettingsRepository _settings;

  Future<Result<void>> call() async {
    final result = await _demo.loadDemo();
    if (result is Ok) await _settings.setOnboarded(onboarded: true);
    return result;
  }
}
