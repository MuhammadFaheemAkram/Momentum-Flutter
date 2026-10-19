import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';
import 'package:momentum/data/mapper/demo_mappers.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

import '../../helpers/test_dependencies.dart';

void main() {
  // demoNow: Wednesday 21 October 2026, 15:00. This ISO week began on
  // Monday the 19th; the one before on the 12th.
  final today = CalendarDate(2026, 10, 21);

  DemoHabitDto habit({
    String id = 'run',
    DemoScheduleDto schedule = const DemoScheduleDto(
      type: DemoScheduleType.onWeekdays,
      weekdays: [1, 3, 5],
    ),
    int startWeeksAgo = 2,
    int dailyTarget = 1,
    String? reminder,
    List<DemoLogDto> logs = const [],
    DemoTodayDto? today,
  }) => DemoHabitDto(
    id: id,
    title: 'Morning run',
    category: HabitCategory.fitness,
    color: HabitColor.orange,
    icon: HabitIcon.run,
    schedule: schedule,
    startWeeksAgo: startWeeksAgo,
    dailyTarget: dailyTarget,
    reminder: reminder,
    logs: logs,
    today: today,
  );

  DemoDto demo({
    List<DemoHabitDto>? habits,
    List<DemoRoutineDto> routines = const [],
    List<DemoGoalDto> goals = const [],
  }) => DemoDto(habits: habits ?? [habit()], routines: routines, goals: goals);

  DemoRoutineDto routine({
    List<DemoRoutineItemDto>? items,
    int createdWeeksAgo = 1,
  }) => DemoRoutineDto(
    id: 'morning',
    title: 'Morning',
    time: RoutineTime.morning,
    createdWeeksAgo: createdWeeksAgo,
    items:
        items ??
        const [
          DemoRoutineItemDto(
            id: 'bed',
            title: 'Make the bed',
            checks: [DemoDayDto(weeksAgo: 1, weekday: 7)],
            checkedToday: true,
          ),
        ],
  );

  Matcher refusedFor(String problem) => throwsA(
    isA<FormatException>().having(
      (e) => e.message,
      'message',
      contains(problem),
    ),
  );

  group('days', () {
    test('a weekday of an ISO week stays on that weekday', () {
      final data = demo(
        habits: [
          habit(
            logs: const [
              DemoLogDto(weeksAgo: 1, weekday: 1, count: 1),
              DemoLogDto(weeksAgo: 1, weekday: 5, count: 1),
              DemoLogDto(weeksAgo: 0, weekday: 1, count: 1),
            ],
          ),
        ],
      ).toUserData(now: demoNow);

      expect(data.logs.map((l) => l.day), [
        CalendarDate(2026, 10, 12),
        CalendarDate(2026, 10, 16),
        CalendarDate(2026, 10, 19),
      ]);
      expect(data.logs.map((l) => l.day.weekday), [1, 5, 1]);
    });

    test("today and this week's days still to come are left out; `today` "
        'says how today stands', () {
      final data = demo(
        habits: [
          habit(
            logs: const [
              DemoLogDto(weeksAgo: 0, weekday: 1, count: 1),
              DemoLogDto(weeksAgo: 0, weekday: 3, count: 1),
              DemoLogDto(weeksAgo: 0, weekday: 5, count: 1),
            ],
            today: const DemoTodayDto(skipped: true),
          ),
        ],
      ).toUserData(now: demoNow);

      expect(data.logs, [
        HabitLog(habitId: 'run', day: CalendarDate(2026, 10, 19)),
        HabitLog(habitId: 'run', day: today, count: 0, skipped: true),
      ]);
    });

    test('a habit starts on the Monday of its first week', () {
      final data = demo(habits: [habit()]).toUserData(now: demoNow);

      expect(data.habits.single.startDate, CalendarDate(2026, 10, 5));
    });

    test('instants are 08:00 on their day, never later than now, in UTC', () {
      final early = DateTime(2026, 10, 19, 7);
      final data = demo(
        habits: [habit(startWeeksAgo: 0)],
        goals: const [
          DemoGoalDto(
            id: 'g',
            title: 'Goal',
            period: GoalPeriod.weekly,
            target: 3,
            createdWeeksAgo: 1,
          ),
        ],
      ).toUserData(now: early);

      // Monday the 19th at 07:00: the habit starts today, before 08:00.
      expect(data.habits.single.createdAt, early.toUtc());
      expect(data.goals.single.createdAt, DateTime(2026, 10, 12, 8).toUtc());
      expect(data.goals.single.createdAt.isUtc, isTrue);
    });
  });

  test('maps every field', () {
    final data = demo(
      habits: [
        habit(
          id: 'water',
          schedule: const DemoScheduleDto(type: DemoScheduleType.daily),
          dailyTarget: 8,
          reminder: '10:00',
          today: const DemoTodayDto(count: 3),
        ),
        habit(
          id: 'spanish',
          schedule: const DemoScheduleDto(
            type: DemoScheduleType.timesPerWeek,
            times: 5,
          ),
        ),
        habit(),
      ],
      routines: [routine()],
      goals: const [
        DemoGoalDto(
          id: 'all',
          title: 'Complete 25 habits this week',
          period: GoalPeriod.weekly,
          target: 25,
          createdWeeksAgo: 1,
        ),
        DemoGoalDto(
          id: 'one',
          title: 'Water on 20 days',
          habitId: 'water',
          period: GoalPeriod.monthly,
          target: 20,
          createdWeeksAgo: 0,
        ),
      ],
    ).toUserData(now: demoNow);

    final [water, spanish, run] = data.habits;
    expect(water.schedule, const HabitSchedule.daily());
    expect(water.dailyTarget, 8);
    expect(water.reminder, TimeOfDayValue(10, 0));
    expect(spanish.schedule, const HabitSchedule.timesPerWeek(5));
    expect(run.schedule, const HabitSchedule.onWeekdays({1, 3, 5}));
    expect(run.reminder, isNull);
    expect(data.habits.map((h) => h.sortOrder), [0, 1, 2]);
    expect(data.logs.single, HabitLog(habitId: 'water', day: today, count: 3));

    final morning = data.routines.single;
    expect((morning.title, morning.time), ('Morning', RoutineTime.morning));
    expect(morning.items.single.title, 'Make the bed');
    expect(data.routineChecks.map((c) => c.day), [
      CalendarDate(2026, 10, 18),
      today,
    ]);

    expect(data.goals.map((g) => g.scope), [
      const GoalScope.allHabits(),
      const GoalScope.habit('water'),
    ]);
    expect(data.goals.last.createdOn, CalendarDate(2026, 10, 19));
    expect(data.unlocks, isEmpty);
  });

  group('refuses', () {
    void refuses(DemoDto Function() build, String problem) {
      expect(() => build().toUserData(now: demoNow), refusedFor(problem));
    }

    test('two habits with one id', () {
      refuses(() => demo(habits: [habit(), habit()]), 'duplicate habit id');
    });

    test('a log before its habit started', () {
      refuses(
        () => demo(
          habits: [
            habit(
              startWeeksAgo: 1,
              logs: const [DemoLogDto(weeksAgo: 2, weekday: 1, count: 1)],
            ),
          ],
        ),
        'a log before it',
      );
    });

    test('two logs on one day', () {
      refuses(
        () => demo(
          habits: [
            habit(
              logs: const [
                DemoLogDto(weeksAgo: 1, weekday: 1, count: 1),
                DemoLogDto(weeksAgo: 1, weekday: 1, count: 2),
              ],
            ),
          ],
        ),
        'two logs on 2026-10-12',
      );
    });

    test('a log that is both a skip and a count, or neither', () {
      for (final log in const [
        DemoLogDto(weeksAgo: 1, weekday: 1, count: 2, skipped: true),
        DemoLogDto(weeksAgo: 1, weekday: 1),
      ]) {
        refuses(
          () => demo(
            habits: [
              habit(logs: [log]),
            ],
          ),
          'a skip or 1–99',
        );
      }
      refuses(
        () => demo(habits: [habit(today: const DemoTodayDto())]),
        'a skip or 1–99',
      );
    });

    test('a day outside the week, or in a future week', () {
      refuses(
        () => demo(
          habits: [
            habit(logs: const [DemoLogDto(weeksAgo: 1, weekday: 8, count: 1)]),
          ],
        ),
        'weekday 8',
      );
      refuses(
        () => demo(
          habits: [
            habit(logs: const [DemoLogDto(weeksAgo: -1, weekday: 1, count: 1)]),
          ],
        ),
        'in a future week',
      );
    });

    test('a schedule that is incomplete or mixed', () {
      for (final schedule in const [
        DemoScheduleDto(type: DemoScheduleType.onWeekdays),
        DemoScheduleDto(type: DemoScheduleType.onWeekdays, weekdays: [1, 1]),
        DemoScheduleDto(type: DemoScheduleType.onWeekdays, weekdays: [0]),
        DemoScheduleDto(type: DemoScheduleType.timesPerWeek),
        DemoScheduleDto(type: DemoScheduleType.timesPerWeek, times: 7),
        DemoScheduleDto(type: DemoScheduleType.daily, weekdays: [1]),
      ]) {
        expect(
          () =>
              demo(habits: [habit(schedule: schedule)])
                  .toUserData(now: demoNow),
          throwsFormatException,
          reason: '${schedule.type} ${schedule.weekdays} ${schedule.times}',
        );
      }
    });

    test('a daily target outside 1–20, and a bad reminder time', () {
      refuses(() => demo(habits: [habit(dailyTarget: 21)]), 'a daily target');
      expect(
        () => demo(habits: [habit(reminder: '7:00')]).toUserData(now: demoNow),
        throwsFormatException,
      );
    });

    test('a routine with no items, or a check before it began', () {
      refuses(() => demo(routines: [routine(items: [])]), '1–20 items');
      refuses(
        () => demo(
          routines: [
            routine(
              createdWeeksAgo: 0,
              items: const [
                DemoRoutineItemDto(
                  id: 'bed',
                  title: 'Make the bed',
                  checks: [DemoDayDto(weeksAgo: 1, weekday: 1)],
                ),
              ],
            ),
          ],
        ),
        'a check before its routine',
      );
    });

    test('a goal on a habit that is not there, or with a bad target', () {
      refuses(
        () => demo(
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
        ),
        'unknown habit nope',
      );
      refuses(
        () => demo(
          goals: const [
            DemoGoalDto(
              id: 'g',
              title: 'Goal',
              period: GoalPeriod.daily,
              target: 201,
              createdWeeksAgo: 0,
            ),
          ],
        ),
        'a target of 1–200',
      );
    });

    test('an empty title', () {
      refuses(
        () => demo(
          habits: [
            const DemoHabitDto(
              id: 'x',
              title: '  ',
              category: HabitCategory.health,
              color: HabitColor.blue,
              icon: HabitIcon.water,
              schedule: DemoScheduleDto(type: DemoScheduleType.daily),
              startWeeksAgo: 0,
            ),
          ],
        ),
        'a title of 1–60',
      );
    });
  });
}
