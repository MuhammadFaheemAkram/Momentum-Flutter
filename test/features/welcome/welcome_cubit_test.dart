import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/features/welcome/cubit/welcome_cubit.dart';
import 'package:momentum/features/welcome/cubit/welcome_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/fakes/scripted_momentum_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DataStack stack;

  WelcomeCubit cubitOn(DataStack dataStack) {
    stack = dataStack;
    addTearDown(stack.close);
    return WelcomeCubit(stack.loadDemo, stack.startEmpty);
  }

  blocTest<WelcomeCubit, WelcomeState>(
    'the demo: a spinner, then done (the router takes it from there)',
    build: () => cubitOn(DataStack()),
    act: (cubit) => cubit.exploreDemo(),
    expect: () => const [
      WelcomeState(starting: StartChoice.demo),
      WelcomeState(),
    ],
    verify: (_) => expect(stack.settings.current.onboarded, isTrue),
  );

  blocTest<WelcomeCubit, WelcomeState>(
    'a failed demo says why, and Try again recovers',
    build: () => cubitOn(
      DataStack(service: ScriptedMomentumService([const NetworkException()])),
    ),
    act: (cubit) async {
      await cubit.exploreDemo();
      (stack.service as ScriptedMomentumService).succeedWith(
        await bundledDemo(),
      );
      await cubit.exploreDemo();
    },
    expect: () => [
      const WelcomeState(starting: StartChoice.demo),
      WelcomeState(errorMessage: const NetworkException().message),
      const WelcomeState(starting: StartChoice.demo),
      const WelcomeState(),
    ],
    verify: (_) => expect(stack.settings.writes, ['onboarded']),
  );

  blocTest<WelcomeCubit, WelcomeState>(
    'start empty',
    build: () => cubitOn(DataStack()),
    act: (cubit) => cubit.startEmpty(),
    expect: () => const [
      WelcomeState(starting: StartChoice.empty),
      WelcomeState(),
    ],
    verify: (_) => expect(stack.settings.current.onboarded, isTrue),
  );

  test('a second tap while starting does nothing', () async {
    final gate = Completer<void>();
    final service = _GatedService(gate.future);
    final cubit = cubitOn(DataStack(service: service));
    addTearDown(cubit.close);

    final first = cubit.exploreDemo();
    await cubit.exploreDemo();
    await cubit.startEmpty();
    expect(service.calls, 1);
    expect(stack.settings.writes, isEmpty);

    gate.complete();
    await first;
    expect(stack.settings.writes, ['onboarded']);
  });
}

/// Holds every fetch until [gate] completes, then serves the real demo.
class _GatedService implements MomentumService {
  _GatedService(this.gate);

  final Future<void> gate;
  var calls = 0;

  @override
  Future<DemoDto> fetchDemo() async {
    calls++;
    await gate;
    return bundledDemo();
  }
}
