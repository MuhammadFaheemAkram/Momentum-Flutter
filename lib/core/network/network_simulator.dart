import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';

/// Plays the network for the fake service: a delay, and an optional
/// failure.
///
/// [failRequests] is the developer switch "Simulate network failure"
/// (Settings → Developer, Phase 6). It lives in memory: off at every launch.
@lazySingleton
class NetworkSimulator {
  NetworkSimulator({
    @ignoreParam this.latency = const Duration(milliseconds: 600),
  });

  /// How long a request takes. Tests use zero.
  final Duration latency;

  bool failRequests = false;

  /// Waits [latency], then throws a [NetworkException] if [failRequests].
  Future<void> call() async {
    await Future<void>.delayed(latency);
    if (failRequests) throw const NetworkException();
  }
}
