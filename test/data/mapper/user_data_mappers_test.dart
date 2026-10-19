import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';

import '../../helpers/database.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  group('weekday bitmask', () {
    test('Monday is bit 0 and Sunday bit 6', () {
      expect(weekdayMask({1}), 1);
      expect(weekdayMask({7}), 64);
      expect(weekdayMask({1, 3, 5}), 1 + 4 + 16);
      expect(weekdayMask({1, 2, 3, 4, 5, 6, 7}), 127);
    });

    test('reads back the same days', () {
      for (final days in [
        {1},
        {7},
        {1, 3, 5},
        {6, 7},
        {1, 2, 3, 4, 5, 6, 7},
      ]) {
        expect(weekdaysOf(weekdayMask(days)), days);
      }
    });

    test('refuses a day that is not a weekday', () {
      expect(() => weekdayMask({0}), throwsRangeError);
      expect(() => weekdayMask({8}), throwsRangeError);
    });
  });

  test('every field survives a round trip through the database', () async {
    final db = newTestDatabase();
    addTearDown(db.close);
    final data = fullUserData();

    await db.userDataDao.replaceAll(data.toRows());
    final readBack = (await db.userDataDao.readAll()).toUserData();

    expect(readBack, data);
  });

  test("a routine's items come back in their saved order", () async {
    final db = newTestDatabase();
    addTearDown(db.close);
    final data = fullUserData();
    final rows = data.toRows();
    // Written in reverse: the order comes from `sort_order`, not insertion.
    await db.userDataDao.replaceAll(
      UserRows(
        habits: rows.habits,
        routines: rows.routines,
        routineItems: rows.routineItems.reversed.toList(),
      ),
    );

    final routine = (await db.userDataDao.readAll())
        .toUserData()
        .routines
        .single;
    expect(routine.items.map((i) => i.id), ['bed', 'stretch', 'plan']);
  });
}
