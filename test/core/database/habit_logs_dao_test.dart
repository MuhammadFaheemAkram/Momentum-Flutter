import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/database.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = newTestDatabase();
    await db.userDataDao.replaceAll(
      UserData(habits: [habitFixture(dailyTarget: 8)]).toRows(),
    );
  });
  tearDown(() => db.close());

  final day = fixtureDay;

  Future<List<(int, bool)>> logs() async => [
    for (final row in await db.select(db.habitLogs).get())
      (row.count, row.skipped),
  ];

  test('+1 starts a log, then adds to the same one', () async {
    await db.habitLogsDao.addCheckIn('h', day);
    expect(await logs(), [(1, false)]);

    await db.habitLogsDao.addCheckIn('h', day);
    await db.habitLogsDao.addCheckIn('h', day);
    expect(await logs(), [(3, false)]);
  });

  test('each day has its own log', () async {
    await db.habitLogsDao.addCheckIn('h', day);
    await db.habitLogsDao.addCheckIn('h', day.addDays(-1));

    expect(await logs(), hasLength(2));
  });

  test(
    'skip drops the check-ins; +1 after a skip makes the day done',
    () async {
      await db.habitLogsDao.addCheckIn('h', day);
      await db.habitLogsDao.addCheckIn('h', day);
      await db.habitLogsDao.skip('h', day);
      expect(await logs(), [(0, true)]);

      await db.habitLogsDao.skip('h', day);
      expect(await logs(), [(0, true)]);

      await db.habitLogsDao.addCheckIn('h', day);
      expect(await logs(), [(1, false)]);
    },
  );

  test('undo leaves no log, whatever the day held', () async {
    await db.habitLogsDao.addCheckIn('h', day);
    await db.habitLogsDao.skip('h', day.addDays(-1));

    await db.habitLogsDao.clear('h', day);
    await db.habitLogsDao.clear('h', day.addDays(-1));
    await db.habitLogsDao.clear('h', day.addDays(-2));

    expect(await logs(), isEmpty);
  });
}
