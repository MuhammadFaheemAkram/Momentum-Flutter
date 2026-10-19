import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';
import '../../helpers/test_dependencies.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  final draft = HabitDraft(
    title: '  Read 20 pages ',
    description: ' Before bed. ',
    category: HabitCategory.reading,
    color: HabitColor.green,
    icon: HabitIcon.book,
    schedule: const HabitSchedule.onWeekdays({1, 3, 5}),
    dailyTarget: 2,
    startDate: today,
    reminder: TimeOfDayValue(21, 0),
  );

  test('creating adds a habit at the end, with an id and the time', () async {
    await stack.seed(UserData(habits: [habit(id: 'a')]));

    final result = await stack.habits.createHabit(draft);

    final created = (result as Ok<Habit>).value;
    expect(created.id, startsWith('habit_'));
    expect(
      (created.title, created.description),
      ('Read 20 pages', 'Before bed.'),
    );
    expect(created.sortOrder, 1);
    expect(created.createdAt, demoNow.toUtc());
    expect(await stack.habits.findHabit(created.id), created);
  });

  test('updating keeps the id, the time, the position, the archive and the '
      'history', () async {
    final original = habit(id: 'a', archivedAt: DateTime.utc(2026, 10));
    await stack.seed(
      UserData(
        habits: [original],
        logs: [done(oct(20), id: 'a')],
      ),
    );

    final result = await stack.habits.updateHabit('a', draft);

    final updated = (result as Ok<Habit>).value;
    expect(updated.title, 'Read 20 pages');
    expect(updated.schedule, const HabitSchedule.onWeekdays({1, 3, 5}));
    expect(
      (updated.createdAt, updated.sortOrder, updated.archivedAt),
      (original.createdAt, original.sortOrder, original.archivedAt),
    );
    expect(await stack.logs.findLog('a', oct(20)), isA<HabitLog>());
  });

  test('updating or archiving a habit that is gone says so', () async {
    expect(
      await stack.habits.updateHabit('nope', draft),
      isA<Err<Habit>>().having(
        (e) => e.exception,
        'exception',
        isA<NotFoundException>(),
      ),
    );
    expect(
      await stack.habits.setArchived('nope', archived: true),
      isA<Err<void>>(),
    );
  });

  test('archiving stamps the time; unarchiving clears it', () async {
    await stack.seed(UserData(habits: [habit(id: 'a')]));

    await stack.habits.setArchived('a', archived: true);
    expect((await stack.habits.findHabit('a'))!.archivedAt, demoNow.toUtc());

    await stack.habits.setArchived('a', archived: false);
    expect((await stack.habits.findHabit('a'))!.archivedAt, isNull);
  });

  test('deleting takes the history with it', () async {
    await stack.seed(
      UserData(
        habits: [habit(id: 'a')],
        logs: [done(oct(20), id: 'a')],
      ),
    );

    await stack.habits.deleteHabit('a');

    expect(await stack.habits.findHabit('a'), isNull);
    expect(await stack.logs.findLog('a', oct(20)), isNull);
  });
}
