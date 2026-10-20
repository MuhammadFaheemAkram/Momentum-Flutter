import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/database.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = newTestDatabase());
  tearDown(() => db.close());

  group('unlocks', () {
    test('each is recorded once, with the day it was first earned', () async {
      final first = await db.achievementsDao.recordUnlocks(
        ['firstStep', 'streak7'],
        day: oct(12),
        at: DateTime.utc(2026, 10, 12, 9),
      );
      final again = await db.achievementsDao.recordUnlocks(
        ['streak7', 'century'],
        day: oct(21),
        at: DateTime.utc(2026, 10, 21, 9),
      );

      expect(first, ['firstStep', 'streak7']);
      expect(again, ['century']);
      final rows = await db.achievementsDao.watchUnlocks().first;
      expect(
        {for (final row in rows) row.achievementId: row.unlockedOn},
        {'firstStep': oct(12), 'streak7': oct(12), 'century': oct(21)},
      );
    });
  });

  group('search', () {
    setUp(() async {
      await db.userDataDao.replaceAll(
        UserData(
          habits: [
            habit(id: 'read').copyWith(title: 'Read 20 pages'),
            habit(id: 'water').copyWith(
              title: 'Drink water',
              description: 'Aim for 100% of 8 glasses',
            ),
            habit(id: 'snake').copyWith(title: 'snake_case practice'),
          ],
          routines: [
            Routine(
              id: 'm',
              title: 'Morning',
              items: const [RoutineItem(id: 'i', title: 'Read the news')],
              createdAt: DateTime.utc(2026),
              sortOrder: 0,
            ),
          ],
          goals: [goal().copyWith(title: 'Read on 20 days')],
        ).toRows(),
      );
    });

    Future<List<String>> habits(String text) async => [
      for (final row in await db.searchDao.watchHabits(text).first) row.id,
    ];

    test('matches names and descriptions, ignoring case', () async {
      expect(await habits('READ'), ['read']);
      expect(await habits('glasses'), ['water']);
    });

    test('% and _ are plain characters, not wildcards', () async {
      expect(await habits('100%'), ['water']);
      expect(await habits('%'), ['water']);
      expect(await habits('e_c'), ['snake']);
      expect(await habits(r'\'), isEmpty);
    });

    test('a routine is found by a step too; goals by their name', () async {
      final routines = await db.searchDao.watchRoutines('news').first;
      final goals = await db.searchDao.watchGoals('read').first;

      expect(routines.single.id, 'm');
      expect(goals.single.title, 'Read on 20 days');
    });
  });
}
