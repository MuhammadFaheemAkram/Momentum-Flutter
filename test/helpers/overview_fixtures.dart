import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

import 'habit_builders.dart';

// Read models for view tests, built by the real engine from small
// histories, so a view test sees exactly what the app would show.

final readHabit = habit(id: 'read').copyWith(title: 'Read 20 pages');
final waterHabit = habit(id: 'water', target: 8).copyWith(title: 'Drink water');
final runHabit = habit(
  id: 'run',
  schedule: monWedFri,
).copyWith(title: 'Morning run');

/// Wednesday: read done, water at 3 of 8, run open; one not due today.
TodayOverview todayFixture() => buildTodayOverview(
  [
    readHabit,
    waterHabit,
    runHabit,
    habit(
      id: 'gym',
      schedule: const HabitSchedule.onWeekdays({2}),
    ).copyWith(title: 'Gym'),
  ],
  [
    ...doneEvery(oct(14), oct(21), id: 'read'),
    ...doneEvery(oct(14), oct(20), id: 'water', count: 8),
    done(today, id: 'water', count: 3),
    done(oct(14), id: 'run'),
    done(oct(16), id: 'run'),
    done(oct(20), id: 'gym'),
    done(oct(19), id: 'run'),
  ],
  today: today,
);

HabitDetail detailFixture({bool archived = false}) => buildHabitDetail(
  readHabit.copyWith(
    startDate: oct(1),
    archivedAt: archived ? DateTime.utc(2026, 10, 21, 9) : null,
  ),
  [...doneEvery(oct(5), oct(12), id: 'read'), skip(oct(13), id: 'read')],
  today: today,
);
