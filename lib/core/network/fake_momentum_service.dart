import 'package:injectable/injectable.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';

/// Serves the demo from a JSON file bundled with the app, after a simulated
/// network delay (600 ms) that can also fail on request. Everything stays in
/// memory: there is no server.
@LazySingleton(as: MomentumService)
class FakeMomentumService implements MomentumService {
  const FakeMomentumService(this._json, this._network);

  static const demoPath = 'assets/json/demo.json';

  final AssetJsonLoader _json;
  final NetworkSimulator _network;

  @override
  Future<DemoDto> fetchDemo() async {
    await _network();
    return DemoDto.fromJson(await _json.loadObject(demoPath));
  }
}
