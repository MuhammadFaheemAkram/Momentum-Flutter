import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/domain/calculation/routines.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';

import '../../helpers/habit_builders.dart';

void main() {
  test('in the order of the day, then the user order', () {
    final routines = routinesToday(
      [
        routine(id: 'any', time: RoutineTime.anytime),
        routine(id: 'evening', time: RoutineTime.evening),
        routine(id: 'morning2', sortOrder: 2),
        routine(id: 'morning1', sortOrder: 1),
        routine(id: 'noon', time: RoutineTime.afternoon),
      ],
      const [],
      today: today,
    );

    expect(routines.map((r) => r.routine.id), [
      'morning1',
      'morning2',
      'noon',
      'evening',
      'any',
    ]);
  });

  test("counts only today's check-offs, of its own items", () {
    final [progress] = routinesToday(
      [routine()],
      [
        RoutineCheck(itemId: 'r-a', day: today),
        RoutineCheck(itemId: 'r-b', day: oct(20)),
        RoutineCheck(itemId: 'other-a', day: today),
      ],
      today: today,
    );

    expect(progress.checkedItemIds, {'r-a'});
    expect((progress.done, progress.total, progress.isComplete), (1, 3, false));
  });

  test('complete once every step is checked', () {
    final [progress] = routinesToday(
      [
        routine(items: ['a']),
      ],
      [RoutineCheck(itemId: 'r-a', day: today)],
      today: today,
    );

    expect(progress.isComplete, isTrue);
  });
}
