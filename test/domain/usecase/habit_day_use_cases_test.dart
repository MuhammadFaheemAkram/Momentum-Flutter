import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/test_dependencies.dart';

void main() {
  late DataStack stack;

  // demoNow is Wednesday 21 October 2026: the builders' `today`.
  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [
          habit(id: 'water', target: 8),
          habit(id: 'old', archivedAt: DateTime.utc(2026, 10)),
          habit(id: 'later', start: oct(25)),
        ],
      ),
    );
  });
  tearDown(() => stack.close());

  Future<HabitLog?> logOn(String id, [int day = 21]) =>
      stack.logs.findLog(id, oct(day));

  Matcher refused<T>(Type exception) => isA<Err<T>>().having(
    (e) => e.exception.runtimeType,
    'exception',
    exception,
  );

  test('the clock agrees with the builders', () {
    expect(stack.calendar.today, today);
    expect(demoNow.weekday, DateTime.wednesday);
  });

  test('+1 adds to today; skip and clear follow', () async {
    await stack.addCheckIn('water');
    await stack.addCheckIn('water');
    expect((await logOn('water'))!.count, 2);

    await stack.skipHabit('water');
    expect((await logOn('water'))!.skipped, isTrue);

    await stack.clearDay('water');
    expect(await logOn('water'), isNull);
  });

  test('refuses an archived habit, one not started yet, and one that is '
      'gone', () async {
    expect(await stack.addCheckIn('old'), refused<void>(InvalidInputException));
    expect(
      await stack.skipHabit('later'),
      refused<void>(InvalidInputException),
    );
    expect(await stack.clearDay('nope'), refused<void>(NotFoundException));
    expect(await logOn('old'), isNull);
  });

  group('backfill', () {
    test('marks a day done with the full daily target, or not done', () async {
      await stack.setDay('water', oct(15), done: true);
      expect((await logOn('water', 15))!.count, 8);

      await stack.setDay('water', oct(15), done: false);
      expect(await logOn('water', 15), isNull);
    });

    test(
      'only the last 30 days, never ahead, never before the start',
      () async {
        expect(
          await stack.setDay('water', today.addDays(-31), done: true),
          refused<void>(InvalidInputException),
        );
        expect(
          await stack.setDay('water', today.addDays(1), done: true),
          refused<void>(InvalidInputException),
        );
        expect(
          await stack.setDay('water', today.addDays(-30), done: true),
          isA<Ok<void>>(),
        );
      },
    );
  });

  test('restore puts the day back as it was, log or none', () async {
    final before = HabitLog(habitId: 'water', day: today, count: 3);

    await stack.skipHabit('water');
    await stack.restoreDay('water', today, before);
    expect(await logOn('water'), before);

    await stack.restoreDay('water', today, null);
    expect(await logOn('water'), isNull);
  });
}
