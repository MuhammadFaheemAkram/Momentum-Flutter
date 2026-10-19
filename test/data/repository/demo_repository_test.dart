import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/habit_enums.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/fakes/scripted_momentum_service.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DemoDto demo;

  setUpAll(() async => demo = await bundledDemo());

  DataStack stackWith(List<Object> replies) {
    final stack = DataStack(service: ScriptedMomentumService(replies));
    addTearDown(stack.close);
    return stack;
  }

  test('loads the demo into the database', () async {
    final stack = stackWith([demo]);

    expect(await stack.demo.loadDemo(), isA<Ok<void>>());

    final stored = await stack.db.userDataDao.readAll();
    expect(stored.habits, hasLength(6));
    expect(stored.routines, hasLength(2));
    expect(stored.goals, hasLength(3));
  });

  test('replaces what was there: loading twice gives the same data', () async {
    final stack = stackWith([demo]);
    await stack.db.userDataDao.replaceAll(fullUserData().toRows());

    await stack.demo.loadDemo();
    final first = await stack.db.userDataDao.readAll();
    await stack.demo.loadDemo();
    final second = await stack.db.userDataDao.readAll();

    expect(second.toUserData(), first.toUserData());
    expect(first.habits.map((h) => h.id), isNot(contains('water')));
  });

  group('a failure changes nothing, and says why', () {
    Future<void> expectFailure(Object reply, Type exception) async {
      final stack = stackWith([reply]);
      await stack.db.userDataDao.replaceAll(fullUserData().toRows());

      final result = await stack.demo.loadDemo();

      expect(
        result,
        isA<Err<void>>().having(
          (e) => e.exception.runtimeType,
          'type',
          exception,
        ),
      );
      final stored = await stack.db.userDataDao.readAll();
      expect(stored.toUserData(), fullUserData());
    }

    test(
      'offline',
      () => expectFailure(const NetworkException(), NetworkException),
    );

    test('a field missing or of the wrong type', () {
      return expectFailure(
        CheckedFromJsonException({}, 'habits', 'DemoDto', null),
        DataFormatException,
      );
    });

    test('data that breaks the rules', () {
      final broken = DemoDto(
        habits: demo.habits,
        routines: demo.routines,
        goals: const [
          DemoGoalDto(
            id: 'g',
            title: 'Goal',
            habitId: 'nope',
            period: GoalPeriod.daily,
            target: 1,
            createdWeeksAgo: 0,
          ),
        ],
      );
      return expectFailure(broken, DataFormatException);
    });

    test(
      'anything unexpected',
      () => expectFailure(StateError('?'), UnknownException),
    );
  });
}
