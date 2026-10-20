import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/achievements.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/achievement_unlock.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';

import '../../helpers/habit_builders.dart';

void main() {
  AchievementInput input({
    List<HabitHistory> histories = const [],
    List<Routine> routines = const [],
    List<RoutineCheck> checks = const [],
  }) => AchievementInput(
    histories: histories,
    routines: routines,
    checks: checks,
    today: today,
  );

  AchievementProgress progressOf(AchievementId id, AchievementInput data) =>
      achievementProgress(id, data);

  bool met(AchievementId id, AchievementInput data) =>
      progressOf(id, data).isMet;

  /// A daily habit done on the [days] days up to yesterday.
  HabitHistory doneDays(int days, {String id = 'h', CalendarDate? start}) =>
      history(
        habit(id: id, start: start ?? CalendarDate(2026, 6, 1)),
        doneEvery(today.addDays(-days), today.addDays(-1), id: id),
      );

  test('First step: one completion', () {
    expect(met(AchievementId.firstStep, input()), isFalse);
    expect(
      met(AchievementId.firstStep, input(histories: [doneDays(1)])),
      isTrue,
    );
  });

  test('7-day and 30-day streaks: at 7 and 30, not at 6 and 29', () {
    expect(
      met(AchievementId.streak7, input(histories: [doneDays(6)])),
      isFalse,
    );
    expect(met(AchievementId.streak7, input(histories: [doneDays(7)])), isTrue);
    expect(
      met(AchievementId.streak30, input(histories: [doneDays(29)])),
      isFalse,
    );
    expect(
      met(AchievementId.streak30, input(histories: [doneDays(30)])),
      isTrue,
    );
    expect(
      progressOf(AchievementId.streak7, input(histories: [doneDays(6)])),
      const AchievementProgress(
        current: 6,
        target: 7,
        measure: AchievementMeasure.streakDays,
      ),
    );
  });

  test('a weekly habit counts in weeks, never as a day streak', () {
    final weekly = history(
      habit(
        schedule: const HabitSchedule.timesPerWeek(6),
        start: CalendarDate(2026, 6, 1),
      ),
      doneEvery(today.addDays(-40), today.addDays(-1)),
    );

    expect(
      progressOf(AchievementId.streak7, input(histories: [weekly])).current,
      0,
    );
  });

  test('Perfect week: 7 perfect days in a row, not 6', () {
    expect(
      met(AchievementId.perfectWeek, input(histories: [doneDays(6)])),
      isFalse,
    );
    expect(
      met(AchievementId.perfectWeek, input(histories: [doneDays(7)])),
      isTrue,
    );
  });

  test('Century: 100 completions, not 99', () {
    final ninetyNine = [doneDays(50, id: 'a'), doneDays(49, id: 'b')];

    expect(met(AchievementId.century, input(histories: ninetyNine)), isFalse);
    expect(
      met(
        AchievementId.century,
        input(
          histories: [
            ...ninetyNine,
            doneDays(1, id: 'c'),
          ],
        ),
      ),
      isTrue,
    );
  });

  group('Early bird', () {
    final morning = routine(id: 'm', items: ['a', 'b']);
    List<RoutineCheck> finishedOn(int days) => [
      for (var d = 1; d <= days; d++) ...[
        RoutineCheck(itemId: 'm-a', day: today.addDays(-d)),
        RoutineCheck(itemId: 'm-b', day: today.addDays(-d)),
      ],
    ];

    test('a morning routine finished on 5 days, not 4', () {
      expect(
        met(
          AchievementId.earlyBird,
          input(routines: [morning], checks: finishedOn(4)),
        ),
        isFalse,
      );
      expect(
        met(
          AchievementId.earlyBird,
          input(routines: [morning], checks: finishedOn(5)),
        ),
        isTrue,
      );
    });

    test('a day with a step left, or an evening routine, does not count', () {
      final partly = [
        for (var d = 1; d <= 5; d++)
          RoutineCheck(itemId: 'm-a', day: today.addDays(-d)),
      ];
      final evening = routine(
        id: 'm',
        time: RoutineTime.evening,
        items: ['a', 'b'],
      );

      expect(
        progressOf(
          AchievementId.earlyBird,
          input(routines: [morning], checks: partly),
        ).current,
        0,
      );
      expect(
        met(
          AchievementId.earlyBird,
          input(routines: [evening], checks: finishedOn(5)),
        ),
        isFalse,
      );
    });
  });

  test('Habit builder: 5 habits going, archived ones not counted', () {
    final four = [for (var i = 0; i < 4; i++) history(habit(id: '$i'))];
    final archived = history(
      habit(id: 'x', archivedAt: DateTime.utc(2026, 10)),
    );

    expect(
      met(AchievementId.habitBuilder, input(histories: [...four, archived])),
      isFalse,
    );
    expect(
      met(
        AchievementId.habitBuilder,
        input(
          histories: [
            ...four,
            history(habit(id: '4')),
          ],
        ),
      ),
      isTrue,
    );
  });

  group('Consistency master', () {
    test('before 30 days of history, the progress is the history', () {
      final young = doneDays(28, start: today.addDays(-28));

      expect(
        progressOf(AchievementId.consistencyMaster, input(histories: [young])),
        const AchievementProgress(
          current: 29,
          target: 30,
          measure: AchievementMeasure.historyDays,
        ),
      );
    });

    test('with 30 days, a score of 80 earns it and 79 does not', () {
      // 30 days, today pending: the last 6 days weigh double. Missing 3 of
      // the 23 earlier days scores (2×6 + 20) / (2×6 + 23) = 91;
      // missing 7 scores 80, and 8 scores 77.
      HabitHistory missing(int count) {
        final h = habit(start: today.addDays(-29));
        return history(h, [
          for (var d = 1; d <= 29; d++)
            if (d <= 6 || d > 6 + count) done(today.addDays(-d)),
        ]);
      }

      expect(
        progressOf(
          AchievementId.consistencyMaster,
          input(histories: [missing(7)]),
        ).current,
        80,
      );
      expect(
        met(AchievementId.consistencyMaster, input(histories: [missing(7)])),
        isTrue,
      );
      expect(
        met(AchievementId.consistencyMaster, input(histories: [missing(8)])),
        isFalse,
      );
    });
  });

  group('Comeback', () {
    test('done again after 8 days or more, with days missed between', () {
      final h = habit(start: oct(1));

      expect(
        met(
          AchievementId.comeback,
          input(
            histories: [
              history(h, [done(oct(5)), done(oct(12))]),
            ],
          ),
        ),
        isFalse,
        reason: '6 days between',
      );
      expect(
        met(
          AchievementId.comeback,
          input(
            histories: [
              history(h, [done(oct(5)), done(oct(13))]),
            ],
          ),
        ),
        isTrue,
        reason: '7 days between',
      );
    });

    test(
      'a week of skips is not "away", and a first completion is not a comeback',
      () {
        final h = habit(start: oct(1));
        final skipped = [
          done(oct(5)),
          for (var d = 6; d <= 13; d++) skip(oct(d)),
          done(oct(14)),
        ];

        expect(
          met(AchievementId.comeback, input(histories: [history(h, skipped)])),
          isFalse,
        );
        expect(
          met(
            AchievementId.comeback,
            input(
              histories: [
                history(h, [done(oct(20))]),
              ],
            ),
          ),
          isFalse,
        );
      },
    );
  });

  test('All rounder: completions in 5 categories, not 4', () {
    final categories = HabitCategory.values.take(5).toList();
    List<HabitHistory> inCategories(int count) => [
      for (final (i, category) in categories.take(count).indexed)
        history(habit(id: '$i').copyWith(category: category), [
          done(oct(20), id: '$i'),
        ]),
    ];

    expect(
      met(AchievementId.allRounder, input(histories: inCategories(4))),
      isFalse,
    );
    expect(
      met(AchievementId.allRounder, input(histories: inCategories(5))),
      isTrue,
    );
  });

  group('unlocks', () {
    final unlock = AchievementUnlock(
      achievementId: AchievementId.streak7.name,
      unlockedOn: oct(12),
      unlockedAt: DateTime.utc(2026, 10, 12, 9),
    );

    test('a badge earned and not unlocked is new; unlocked, it is not', () {
      final data = input(histories: [doneDays(7)]);

      expect(
        newlyEarned(data, const []),
        containsAll([AchievementId.firstStep, AchievementId.streak7]),
      );
      expect(
        newlyEarned(data, [unlock]),
        isNot(contains(AchievementId.streak7)),
      );
    });

    test('an unlock stays, after the progress that earned it is gone', () {
      final statuses = achievementStatuses(input(), [unlock]);
      final streak7 = statuses.singleWhere(
        (s) => s.id == AchievementId.streak7,
      );

      expect(streak7.isUnlocked, isTrue);
      expect(streak7.progress.current, 0);
      expect(statuses, hasLength(AchievementId.values.length));
    });
  });
}
