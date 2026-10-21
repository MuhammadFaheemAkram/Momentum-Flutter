import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/dto/backup_dto.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';

/// Serves the demo from a JSON file bundled with the app, and takes
/// backups, after a simulated network delay (600 ms) that can also fail on
/// request. Everything stays in memory: there is no server.
@LazySingleton(as: MomentumService)
class FakeMomentumService implements MomentumService {
  FakeMomentumService(this._json, this._network, this._clock);

  static const demoPath = 'assets/json/demo.json';

  final AssetJsonLoader _json;
  final NetworkSimulator _network;
  final Clock _clock;

  /// The latest backup received, as the JSON text that went "over the
  /// wire". Kept in memory only: lost when the app (or the background
  /// isolate that sent it) ends. Only the receipt's time is saved, on the
  /// device.
  String? get latestBackup => _latestBackup;
  String? _latestBackup;

  @override
  Future<DemoDto> fetchDemo() async {
    await _network();
    return DemoDto.fromJson(await _json.loadObject(demoPath));
  }

  @override
  Future<BackupReceiptDto> uploadBackup(BackupDto backup) async {
    await _network();
    _latestBackup = jsonEncode(backup.toJson());
    return BackupReceiptDto(
      receivedAt: _clock.now().toUtc(),
      habits: backup.habits.length,
      logs: backup.logs.length,
    );
  }
}
