import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/notification_plan.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

import '../../helpers/habit_builders.dart';

void main() {
  // Wednesday 21 October 2026, 15:00.
  final now = DateTime(2026, 10, 21, 15);
  const remindersOnly = AppSettings(nudgeEnabled: false, summaryEnabled: false);
  final sixPm = TimeOfDayValue(18, 0);

  List<PlannedNotification> plan(
    List<HabitHistory> histories, {
    AppSettings settings = remindersOnly,
    DateTime? at,
  }) => planNotifications(
    now: at ?? now,
    histories: histories,
    settings: settings,
  );

  List<CalendarDate> days(Iterable<PlannedNotification> plan) => [
    for (final n in plan) n.day,
  ];

  Iterable<PlannedNotification> ofKind(
    List<PlannedNotification> plan,
    NotificationKind kind,
  ) => plan.where((n) => n.kind == kind);

  group('reminders', () {
    test('at the habit\'s time on each due day of the next 7', () {
      final water = habit(id: 'water', title: 'Drink water', reminder: sixPm);

      final reminders = plan([history(water)]);

      expect(days(reminders), [for (var d = 21; d <= 27; d++) oct(d)]);
      expect(reminders.first.at, DateTime(2026, 10, 21, 18));
      expect(reminders.first.title, 'Drink water');
      expect(reminders.first.target, const NotificationTarget.habit('water'));
      expect(reminders.first.habitId, 'water');
    });

    test('none for a habit without a reminder time', () {
      expect(plan([history(habit())]), isEmpty);
    });

    test('done today: no reminder left today, the next ones stay', () {
      final water = habit(id: 'water', reminder: sixPm);

      final reminders = plan([
        history(water, [done(today, id: 'water')]),
      ]);

      expect(days(reminders).first, oct(22));
      expect(reminders, hasLength(6));
    });

    test('skipped today: no reminder today either', () {
      final water = habit(id: 'water', reminder: sixPm);

      expect(
        days(
          plan([
            history(water, [skip(today, id: 'water')]),
          ]),
        ).first,
        oct(22),
      );
    });

    test('a partly done counted habit is still reminded, with its count', () {
      final water = habit(id: 'water', target: 8, reminder: sixPm);

      final reminders = plan([
        history(water, [done(today, id: 'water', count: 3)]),
      ]);

      expect(reminders.first.day, today);
      expect(reminders.first.body, '3 of 8 so far today');
      expect(reminders[1].body, '0 of 8 so far today');
    });

    test('on weekdays: only on its days', () {
      final run = habit(id: 'run', schedule: monWedFri, reminder: sixPm);

      // Wed 21, Fri 23 and Mon 26 are in the window (21–27).
      expect(days(plan([history(run)])), [oct(21), oct(23), oct(26)]);
    });

    test('a week whose target is met: none until next week', () {
      final spanish = habit(
        id: 'spanish',
        schedule: const HabitSchedule.timesPerWeek(3),
        reminder: sixPm,
      );

      final reminders = plan([
        history(spanish, [
          done(oct(19), id: 'spanish'),
          done(oct(20), id: 'spanish'),
          done(oct(21), id: 'spanish'),
        ]),
      ]);

      expect(days(reminders), [oct(26), oct(27)]);
    });

    test('a habit starting later: from its start date', () {
      final later = habit(start: oct(25), reminder: sixPm);

      expect(days(plan([history(later)])), [oct(25), oct(26), oct(27)]);
    });

    test('an archived habit: none', () {
      final archived = habit(
        reminder: sixPm,
        archivedAt: DateTime.utc(2026, 10, 20),
      );

      expect(plan([history(archived)]), isEmpty);
    });

    test('times already past are dropped: 07:00 starts tomorrow', () {
      final run = habit(reminder: TimeOfDayValue(7, 0));

      final reminders = plan([history(run)]);

      expect(reminders.first.at, DateTime(2026, 10, 22, 7));
      expect(reminders, hasLength(6));
    });
  });

  group('the nudge', () {
    final settings = remindersOnly.copyWith(nudgeEnabled: true);
    final read = habit(id: 'read', title: 'Read 20 pages');
    final plan20 = habit(id: 'plan', title: 'Plan tomorrow');

    test('today at its time, with what\'s left', () {
      final nudges = ofKind(
        plan([history(read), history(plan20)], settings: settings),
        NotificationKind.nudge,
      ).toList();

      expect(nudges.first.at, DateTime(2026, 10, 21, 20));
      expect(nudges.first.title, '2 habits left today');
      expect(nudges.first.body, 'Read 20 pages, Plan tomorrow');
      expect(nudges.first.target, const NotificationTarget.today());
    });

    test('one left: singular; done habits are not listed', () {
      final nudge = ofKind(
        plan([
          history(read, [done(today, id: 'read')]),
          history(plan20),
        ], settings: settings),
        NotificationKind.nudge,
      ).first;

      expect(nudge.title, '1 habit left today');
      expect(nudge.body, 'Plan tomorrow');
    });

    test('all done: no nudge today (tomorrow still has one)', () {
      final nudges = ofKind(
        plan([
          history(read, [done(today, id: 'read')]),
        ], settings: settings),
        NotificationKind.nudge,
      );

      expect(days(nudges).first, oct(22));
    });

    test('more than three open: "and N more"', () {
      final habits = [
        for (final id in ['a', 'b', 'c', 'd', 'e'])
          history(habit(id: id, title: id.toUpperCase())),
      ];

      final nudge = ofKind(
        plan(habits, settings: settings),
        NotificationKind.nudge,
      ).first;

      expect(nudge.body, 'A, B, C and 2 more');
    });

    test('off: none', () {
      expect(plan([history(read)]), isEmpty);
    });
  });

  group('the summary', () {
    final settings = remindersOnly.copyWith(summaryEnabled: true);

    test('today at its time: done of due, and the perfect days', () {
      final water = habit(id: 'water');
      final read = habit(id: 'read');

      final summary = ofKind(
        plan([
          history(water, doneEvery(oct(18), today, id: 'water')),
          history(read, [
            ...doneEvery(oct(18), oct(20), id: 'read'),
            skip(today, id: 'read'),
          ]),
        ], settings: settings),
        NotificationKind.summary,
      ).first;

      expect(summary.at, DateTime(2026, 10, 21, 21, 30));
      // The skip isn't due; today counts once perfect: 18th to 21st.
      expect(summary.body, '1 of 1 done today, 4 perfect days');
    });

    test('a day with nothing due: no summary', () {
      final run = habit(schedule: const HabitSchedule.onWeekdays({1}));

      // Only Monday the 26th is due in the window.
      expect(days(plan([history(run)], settings: settings)), [oct(26)]);
    });

    test('no perfect days: just the count', () {
      final summary = ofKind(
        plan([history(habit())], settings: settings),
        NotificationKind.summary,
      ).first;

      expect(summary.body, '0 of 1 done today');
    });
  });

  group('the window', () {
    const everything = AppSettings();

    test('seven days, soonest first, and no further', () {
      final water = habit(reminder: sixPm);

      final all = plan([history(water)], settings: everything);

      expect(all.last.day, oct(27));
      expect(
        all.map((n) => n.at),
        orderedEquals([...all.map((n) => n.at)]..sort()),
      );
    });

    test('at most 60, the soonest kept', () {
      final many = [
        for (var i = 0; i < 12; i++)
          history(habit(id: 'h$i', reminder: TimeOfDayValue(8 + i, 0))),
      ];

      final all = plan(many, settings: everything);

      // 12 × 7 reminders, plus nudges and summaries: far more than 60.
      expect(all, hasLength(maxPlannedNotifications));
      expect(all.first.day, today);
      expect(all.last.day < oct(27), isTrue);
    });

    test('just before midnight: the evening ones are tomorrow\'s', () {
      final water = habit(reminder: sixPm);

      final all = plan(
        [history(water)],
        settings: everything,
        at: DateTime(2026, 10, 21, 23, 30),
      );

      expect(all.first.at, DateTime(2026, 10, 22, 18));
      expect(days(all).toSet(), isNot(contains(today)));
      // The window still ends on the 27th: it starts today, whose times
      // have passed.
      expect(all.last.day, oct(27));
    });

    test(
      'each keeps its wall-clock time, across the end of daylight saving',
      () {
        // Europe's clocks go back on Sunday 25 October 2026, inside the
        // window: 18:00 stays 18:00 local, whatever the zone.
        final all = plan([history(habit(reminder: sixPm))]);

        expect(all.map((n) => (n.at.hour, n.at.minute)).toSet(), {(18, 0)});
      },
    );
  });

  group('ids', () {
    final histories = [
      history(habit(id: 'water', reminder: sixPm)),
      history(habit(id: 'read', reminder: TimeOfDayValue(21, 0))),
    ];

    test('the same in every plan, and one per notification', () {
      final first = plan(histories, settings: const AppSettings());
      final second = plan(
        histories.reversed.toList(),
        settings: const AppSettings(),
      );

      expect(second.map((n) => n.id), first.map((n) => n.id));
      expect(first.map((n) => n.id).toSet(), hasLength(first.length));
    });

    test('from the kind, the habit and the day', () {
      final water = plan(histories).first;

      expect(
        water.id,
        notificationId(NotificationKind.reminder, today, habitId: 'water'),
      );
      expect(
        notificationId(NotificationKind.reminder, today, habitId: 'read'),
        isNot(water.id),
      );
      expect(
        notificationId(NotificationKind.reminder, oct(22), habitId: 'water'),
        isNot(water.id),
      );
      expect(notificationId(NotificationKind.nudge, today), isNot(water.id));
    });

    test('fit Android\'s 32-bit signed ids', () {
      for (final n in plan(histories, settings: const AppSettings())) {
        expect(n.id, inInclusiveRange(0, 0x7fffffff));
      }
    });
  });

  group('payloads', () {
    test('carry the target and the time', () {
      final reminder = plan([history(habit(id: 'water', reminder: sixPm))])
          .first;

      expect(reminder.payload, 'habit:water#2026-10-21T18:00');
      expect(
        NotificationTarget.parse(reminder.payload),
        const NotificationTarget.habit('water'),
      );
    });

    test('parse Today, and nothing else', () {
      expect(
        NotificationTarget.parse('today#2026-10-21T20:00'),
        const NotificationTarget.today(),
      );
      expect(NotificationTarget.parse(null), isNull);
      expect(NotificationTarget.parse('habit:'), isNull);
      expect(NotificationTarget.parse('elsewhere'), isNull);
    });
  });
}
