import 'package:fake_async/fake_async.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/network/asset_json_loader.dart';
import 'package:momentum/core/network/fake_momentum_service.dart';
import 'package:momentum/core/network/network_simulator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  FakeMomentumService service(NetworkSimulator network) =>
      FakeMomentumService(AssetJsonLoader(rootBundle), network);

  test('serves the bundled demo', () async {
    final demo = await service(NetworkSimulator(latency: Duration.zero))
        .fetchDemo();

    expect(demo.habits, hasLength(6));
  });

  test('takes 600 ms, like a real request', () {
    fakeAsync((async) {
      final network = NetworkSimulator();
      var done = false;
      network().then((_) => done = true);

      async.elapse(const Duration(milliseconds: 599));
      expect(done, isFalse);
      async.elapse(const Duration(milliseconds: 1));
      expect(done, isTrue);
    });
  });

  test('fails on request, with the app’s network error', () async {
    final network = NetworkSimulator(latency: Duration.zero)
      ..failRequests = true;

    await expectLater(
      service(network).fetchDemo(),
      throwsA(isA<NetworkException>()),
    );
  });
}
