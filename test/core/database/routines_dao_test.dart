import 'package:drift/native.dart' show SqliteException;
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/database.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late AppDatabase db;
  final morning = routine(id: 'm', items: ['bed', 'stretch', 'plan']);

  setUp(() async {
    db = newTestDatabase();
    await db.userDataDao.replaceAll(
      UserData(
        routines: [morning],
        routineChecks: [
          RoutineCheck(itemId: 'm-bed', day: today),
          RoutineCheck(itemId: 'm-plan', day: today),
        ],
      ).toRows(),
    );
  });
  tearDown(() => db.close());

  List<RoutineItemRow> rowsFor(List<String> ids) => [
    for (final (index, id) in ids.indexed)
      RoutineItemRow(id: id, routineId: 'm', title: id, sortOrder: index),
  ];

  Future<List<String>> itemOrder() async => [
    for (final row in await db.routinesDao.itemsOf('m')) row.id,
  ];

  Future<Set<String>> checked() async => {
    for (final row in await db.select(db.routineChecks).get()) row.itemId,
  };

  test('a save rewrites every position: the new order sticks', () async {
    await db.routinesDao.saveRoutine(
      morning.toRow(),
      rowsFor(['m-plan', 'm-bed', 'm-stretch']),
    );

    expect(await itemOrder(), ['m-plan', 'm-bed', 'm-stretch']);
  });

  test(
    'kept steps keep their check-offs; a removed one takes its own',
    () async {
      await db.routinesDao.saveRoutine(
        morning.toRow(),
        rowsFor(['m-stretch', 'm-plan', 'new']),
      );

      expect(await itemOrder(), ['m-stretch', 'm-plan', 'new']);
      expect(await checked(), {'m-plan'});
    },
  );

  test(
    'all in one transaction: a broken step leaves everything as it was',
    () async {
      final broken = [
        ...rowsFor(['m-plan', 'm-bed']),
        // Belongs to a routine that isn't there: the foreign key fails after
        // the routine, the deletion and two steps were written.
        const RoutineItemRow(
          id: 'x',
          routineId: 'nope',
          title: 'x',
          sortOrder: 2,
        ),
      ];

      await expectLater(
        db.routinesDao.saveRoutine(
          morning.toRow().copyWith(title: 'Changed'),
          broken,
        ),
        throwsA(isA<SqliteException>()),
      );

      expect((await db.routinesDao.findRoutine('m'))!.title, 'Routine m');
      expect(await itemOrder(), ['m-bed', 'm-stretch', 'm-plan']);
      expect(await checked(), {'m-bed', 'm-plan'});
    },
  );

  test('checking twice is one check; un-checking removes it', () async {
    await db.routinesDao.setChecked('m-stretch', today, checked: true);
    await db.routinesDao.setChecked('m-stretch', today, checked: true);
    expect(await checked(), {'m-bed', 'm-plan', 'm-stretch'});

    await db.routinesDao.setChecked('m-bed', today, checked: false);
    expect(await checked(), {'m-plan', 'm-stretch'});
  });

  test('deleting a routine takes its steps and check-offs', () async {
    await db.routinesDao.deleteRoutine('m');

    expect(await db.select(db.routineItems).get(), isEmpty);
    expect(await checked(), isEmpty);
  });
}
