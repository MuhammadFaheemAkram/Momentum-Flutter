import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/domain/model/calendar_date.dart';

void main() {
  test('today is the local calendar day', () {
    final clock = CalendarClock(Clock.fixed(DateTime(2026, 10, 21, 23, 59)));

    expect(clock.today, CalendarDate(2026, 10, 21));
  });

  test('emits today, then the new day at each midnight', () {
    fakeAsync((async) {
      final start = DateTime(2026, 10, 21, 23);
      // A clock that moves with fake time.
      final clock = CalendarClock(Clock(() => start.add(async.elapsed)));
      final days = <CalendarDate>[];
      final subscription = clock.watchToday().listen(days.add);

      async.elapse(const Duration(minutes: 59));
      expect(days, [CalendarDate(2026, 10, 21)]);

      async.elapse(const Duration(minutes: 2));
      expect(days.last, CalendarDate(2026, 10, 22));

      async.elapse(const Duration(days: 1));
      expect(days.last, CalendarDate(2026, 10, 23));

      subscription.cancel();
    });
  });

  test('cancelling stops the midnight timer', () {
    fakeAsync((async) {
      final clock = CalendarClock(Clock.fixed(DateTime(2026, 10, 21, 15)));
      final subscription = clock.watchToday().listen((_) {});
      expect(async.pendingTimers, hasLength(1));

      subscription.cancel();
      expect(async.pendingTimers, isEmpty);
    });
  });
}
