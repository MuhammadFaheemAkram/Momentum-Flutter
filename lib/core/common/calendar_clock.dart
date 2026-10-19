import 'dart:async';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/model/calendar_date.dart';

/// "Today" in the user's calendar, now and as it changes.
///
/// Today's habits, streaks and the week strip all depend on the day. A
/// screen left open past midnight must move to the new day by itself, so
/// [watchToday] emits again at each local midnight.
@lazySingleton
class CalendarClock {
  const CalendarClock(this._clock);

  final Clock _clock;

  CalendarDate get today => CalendarDate.fromDateTime(_clock.now());

  /// Today on listen, then the new day at each midnight. The timer is
  /// cancelled with the subscription.
  Stream<CalendarDate> watchToday() => Stream.multi((watcher) {
    Timer? timer;
    void emitAndWait() {
      final now = _clock.now();
      final today = CalendarDate.fromDateTime(now);
      watcher.add(today);
      final tomorrow = today.addDays(1);
      // A second past midnight, so a clock that fires a hair early still
      // lands on the new day.
      final next = DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        0,
        0,
        1,
      );
      timer = Timer(next.difference(now), emitAndWait);
    }

    emitAndWait();
    watcher.onCancel = () => timer?.cancel();
  });
}
