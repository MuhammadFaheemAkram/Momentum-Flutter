import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/fakes/scripted_momentum_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the demo: data first, then the first launch ends', () async {
    final stack = DataStack();
    addTearDown(stack.close);

    expect(await stack.loadDemo(), isA<Ok<void>>());

    expect(stack.settings.current.onboarded, isTrue);
    expect(
      await stack.db.userDataDao.readAll().then((r) => r.habits),
      isNotEmpty,
    );
  });

  test('a failed demo leaves the user on Welcome', () async {
    final stack = DataStack(
      service: ScriptedMomentumService([const NetworkException()]),
    );
    addTearDown(stack.close);

    expect(await stack.loadDemo(), isA<Err<void>>());

    expect(stack.settings.writes, isEmpty);
  });

  test('starting empty ends the first launch, with no data', () async {
    final stack = DataStack();
    addTearDown(stack.close);

    await stack.startEmpty();

    expect(stack.settings.current.onboarded, isTrue);
    expect(await stack.db.userDataDao.readAll().then((r) => r.habits), isEmpty);
  });
}
