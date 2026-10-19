import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  final draft = HabitDraft(
    title: 'Read',
    category: HabitCategory.reading,
    color: HabitColor.green,
    icon: HabitIcon.book,
    schedule: const HabitSchedule.daily(),
    startDate: today,
  );

  test('saving refuses what breaks a rule, with what to fix', () async {
    final result = await stack.saveHabit(
      draft.copyWith(schedule: const HabitSchedule.onWeekdays({})),
    );

    expect(
      result,
      isA<Err<Habit>>().having(
        (e) => e.exception,
        'exception',
        isA<InvalidInputException>().having(
          (e) => e.message,
          'message',
          'Pick at least one day',
        ),
      ),
    );
    expect(await stack.habits.watchHabits().first, isEmpty);
  });

  test('saving creates, then updates the same habit', () async {
    final created = (await stack.saveHabit(draft) as Ok<Habit>).value;

    await stack.saveHabit(draft.copyWith(title: 'Read more'), id: created.id);

    final habits = await stack.habits.watchHabits().first;
    expect(habits.single.title, 'Read more');
  });

  group('the live views', () {
    test('Today follows the logs', () async {
      await stack.seed(UserData(habits: [habit(id: 'a')]));
      // Each screen listens to its own: a view is single-subscription.
      final first = await stack.watchToday().first;
      expect((first.summary.done, first.summary.due), (0, 1));

      await stack.addCheckIn('a');
      final next = await stack.watchToday().first;
      expect((next.summary.done, next.summary.due), (1, 1));
    });

    test('a habit page turns to null once the habit is deleted', () async {
      await stack.seed(UserData(habits: [habit(id: 'a')]));
      final pages = <bool>[];
      final subscription = stack
          .watchDetail('a')
          .listen((detail) => pages.add(detail != null));
      await pumpEventQueue();

      await stack.deleteHabit('a');
      await pumpEventQueue();
      await subscription.cancel();

      // The habit's row and then its logs (the cascade) each re-run it.
      expect(pages.first, isTrue);
      expect(pages.skip(1), everyElement(isFalse));
    });

    // Conventions §11.61: with the clock as `combineLatest`'s `other`, a
    // drift source turned it into a broadcast stream that was never
    // cancelled, and its midnight timer outlived every screen.
    test('cancelling a view stops its midnight timer', () {
      fakeAsync((async) {
        final views = [
          stack.watchToday(),
          stack.watchHabits(),
          stack.watchDetail('a'),
        ];
        for (final view in views) {
          final subscription = view.listen((_) {});
          async.flushMicrotasks();
          expect(async.pendingTimers, isNotEmpty);
          subscription.cancel();
          async.flushMicrotasks();
          expect(
            async.pendingTimers.where(
              (t) => t.duration > const Duration(hours: 1),
            ),
            isEmpty,
          );
        }
      });
    });
  });
}
