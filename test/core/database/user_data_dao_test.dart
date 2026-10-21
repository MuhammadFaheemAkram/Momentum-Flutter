import 'package:drift/native.dart' show SqliteException;
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/habit_log.dart';

import '../../helpers/database.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = newTestDatabase());
  tearDown(() => db.close());

  test(
    'replaceAll writes every table, and twice gives the same result',
    () async {
      final rows = fullUserData().toRows();

      await db.userDataDao.replaceAll(rows);
      await db.userDataDao.replaceAll(rows);

      final stored = await db.userDataDao.readAll();
      expect(stored.habits, hasLength(3));
      expect(stored.logs, hasLength(3));
      expect(stored.routines, hasLength(1));
      expect(stored.routineItems, hasLength(3));
      expect(stored.routineChecks, hasLength(2));
      expect(stored.goals, hasLength(2));
      expect(stored.unlocks, hasLength(1));
    },
  );

  test('replaceAll replaces: what was there before is gone', () async {
    await db.userDataDao.replaceAll(fullUserData().toRows());

    final smaller = fullUserData().copyWith(
      habits: [habitFixture(id: 'only')],
      logs: [HabitLog(habitId: 'only', day: fixtureDay)],
      routines: [],
      routineChecks: [],
      goals: [],
      unlocks: [],
    );
    await db.userDataDao.replaceAll(smaller.toRows());

    final stored = await db.userDataDao.readAll();
    expect(stored.habits.map((h) => h.id), ['only']);
    expect(stored.logs, hasLength(1));
    expect(stored.routineItems, isEmpty);
    expect(stored.unlocks, isEmpty);
  });

  test('a broken row rolls everything back', () async {
    await db.userDataDao.replaceAll(fullUserData().toRows());

    // A log of a habit that isn't there breaks the foreign key, after the
    // old rows were deleted and the habits written.
    final broken = fullUserData().copyWith(
      logs: [HabitLog(habitId: 'nope', day: fixtureDay)],
    );
    await expectLater(
      db.userDataDao.replaceAll(broken.toRows()),
      throwsA(isA<SqliteException>()),
    );

    final stored = await db.userDataDao.readAll();
    expect(stored.logs, hasLength(3));
    expect(stored.unlocks, hasLength(1));
  });

  test('resetProgress clears logs, check-offs and unlocks; habits, routines '
      'and goals stay', () async {
    await db.userDataDao.replaceAll(fullUserData().toRows());

    await db.userDataDao.resetProgress();

    final stored = await db.userDataDao.readAll();
    expect(stored.logs, isEmpty);
    expect(stored.routineChecks, isEmpty);
    expect(stored.unlocks, isEmpty);
    expect(stored.habits, hasLength(3));
    expect(stored.routines, hasLength(1));
    expect(stored.routineItems, hasLength(3));
    expect(stored.goals, hasLength(2));
  });
}
