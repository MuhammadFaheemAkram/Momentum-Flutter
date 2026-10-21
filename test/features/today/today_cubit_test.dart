import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/features/today/cubit/today_cubit.dart';
import 'package:momentum/features/today/cubit/today_state.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/test_dependencies.dart';
import '../../helpers/wait_for.dart';

void main() {
  late DataStack stack;
  late TodayCubit cubit;

  setUp(() async {
    stack = DataStack();
    await stack.seed(
      UserData(
        habits: [
          habit(id: 'read'),
          habit(id: 'water', target: 8),
        ],
        logs: doneEvery(oct(15), oct(20), id: 'read'),
      ),
    );
    cubit = TodayCubit(stack.watchToday, stack.dayActions, stack.clock)
      ..start();
  });
  tearDown(() async {
    await cubit.close();
    await stack.close();
  });

  Future<TodayOverview> overviewWhere(
    bool Function(TodayOverview o) test,
  ) async => (await waitFor(
    cubit,
    (s) => s.status == TodayStatus.ready && test(s.overview!),
  )).overview!;

  HabitToday item(TodayOverview overview, String id) =>
      overview.due.singleWhere((h) => h.habit.id == id);

  test('loads today, live', () async {
    final overview = await overviewWhere((_) => true);

    expect(overview.today, today);
    expect((overview.summary.done, overview.summary.due), (0, 2));
    expect(item(overview, 'read').streak.current, 6);
  });

  test('a check-in updates the ring and the streak', () async {
    final before = await overviewWhere((_) => true);

    await cubit.checkIn(item(before, 'read'));

    final after = await overviewWhere((o) => o.summary.done == 1);
    expect(item(after, 'read').state, DayState.done);
    expect(item(after, 'read').streak.current, 7);
  });

  test('skip keeps the streak, says so, and Undo puts the day back', () async {
    final before = await overviewWhere((_) => true);

    await cubit.skip(item(before, 'read'));
    final skipped = await overviewWhere(
      (o) => item(o, 'read').state == DayState.skipped,
    );
    expect(item(skipped, 'read').streak.current, 6);
    expect(skipped.summary.due, 1, reason: 'skips leave the ring');
    expect(cubit.state.notice!.message, 'Skipped Habit read today');

    await cubit.undoNotice(cubit.state.notice!);
    final restored = await overviewWhere(
      (o) => item(o, 'read').state == DayState.open,
    );
    expect(restored.summary.due, 2);
  });

  test(
    'undoing a counted habit clears it, and Undo brings the count back',
    () async {
      final before = await overviewWhere((_) => true);
      await cubit.checkIn(item(before, 'water'));
      await cubit.checkIn(item(before, 'water'));
      final counted = await overviewWhere((o) => item(o, 'water').count == 2);

      await cubit.undo(item(counted, 'water'));
      await overviewWhere((o) => item(o, 'water').count == 0);
      await cubit.undoNotice(cubit.state.notice!);

      expect(
        item(
          await overviewWhere((o) => item(o, 'water').count == 2),
          'water',
        ).count,
        2,
      );
    },
  );

  test('a refused action says why', () async {
    final before = await overviewWhere((_) => true);
    await stack.setArchived('read', archived: true);
    final serial = cubit.state.noticeSerial;

    await cubit.checkIn(item(before, 'read'));

    expect(cubit.state.noticeSerial, serial + 1);
    expect(
      cubit.state.notice!.message,
      'Unarchive the habit to change its days',
    );
  });

  group('coming up', () {
    late DateTime now;

    TodayCubit start() {
      final cubit = TodayCubit(
        stack.watchToday,
        stack.dayActions,
        Clock(() => now),
      )..start();
      addTearDown(cubit.close);
      return cubit;
    }

    // Replaces the data of the outer setUp.
    setUp(() async {
      await stack.seed(
        UserData(
          habits: [
            for (final (id, hour) in [
              ('early', 7),
              ('four', 16),
              ('six', 18),
              ('eight', 20),
              ('nine', 21),
              ('done', 19),
            ])
              habit(id: id, title: id, reminder: TimeOfDayValue(hour, 0)),
          ],
          logs: [done(today, id: 'done')],
        ),
      );
    });

    test('the next three still to ring today, for habits not done', () async {
      now = demoNow;

      final state = await waitFor(
        start(),
        (s) => s.status == TodayStatus.ready,
      );

      expect(
        [for (final r in state.upcoming) r.title],
        ['four', 'six', 'eight'],
      );
    });

    test('moves on by itself when one rings', () async {
      // 100 ms before 16:00.
      now = DateTime(2026, 10, 21, 15, 59, 59, 900);
      final cubit = start();
      await waitFor(cubit, (s) => s.upcoming.isNotEmpty);

      now = DateTime(2026, 10, 21, 16, 0, 0, 1);
      final state = await waitFor(
        cubit,
        (s) => s.upcoming.first.title != 'four',
      );

      expect(
        [for (final r in state.upcoming) r.title],
        ['six', 'eight', 'nine'],
      );
    });
  });
}
