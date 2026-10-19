import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/database.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = newTestDatabase();
    await db.userDataDao.replaceAll(
      UserData(
        habits: [habit(id: 'read')],
        goals: [goal(scope: const GoalScope.habit('read'))],
      ).toRows(),
    );
  });
  tearDown(() => db.close());

  test(
    'an update to all habits writes the null habit (conventions §11.57)',
    () async {
      final row = (await db.goalsDao.findGoal('g'))!;

      await db.goalsDao.updateGoal(
        row.copyWith(kind: GoalKind.allHabits, habitId: const Value(null)),
      );

      final updated = (await db.goalsDao.findGoal('g'))!;
      expect((updated.kind, updated.habitId), (GoalKind.allHabits, null));
    },
  );

  test('a goal is watched until deleted', () async {
    expect(await db.goalsDao.watchGoals().first, hasLength(1));

    await db.goalsDao.deleteGoal('g');

    expect(await db.goalsDao.watchGoals().first, isEmpty);
  });
}
