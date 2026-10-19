import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';

import '../../helpers/database.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = newTestDatabase();
    await db.userDataDao.replaceAll(fullUserData().toRows());
  });
  tearDown(() => db.close());

  test('lists every habit in the user order, archived ones too', () async {
    final rows = await db.habitsDao.watchAll().first;

    expect(rows.map((r) => r.id), ['water', 'run', 'spanish']);
  });

  test('the next position is after the last; 0 with none', () async {
    expect(await db.habitsDao.nextSortOrder(), 3);

    await db.delete(db.habits).go();
    expect(await db.habitsDao.nextSortOrder(), 0);
  });

  test('an update rewrites the habit and keeps its history', () async {
    final water = (await db.habitsDao.findOne('water'))!;

    final updated = await db.habitsDao.updateHabit(
      water.copyWith(title: 'Water', dailyTarget: 6),
    );

    expect(updated, isTrue);
    expect((await db.habitsDao.findOne('water'))!.title, 'Water');
    // An UPDATE, not a REPLACE: the cascade didn't take the logs or goals.
    final logs = await db.select(db.habitLogs).get();
    final goals = await db.select(db.goals).get();
    expect(logs.where((l) => l.habitId == 'water'), hasLength(2));
    expect(goals.map((g) => g.habitId), contains('water'));
  });

  test('archiving sets and clears the time', () async {
    final at = DateTime.utc(2026, 10, 21, 9);

    await db.habitsDao.setArchivedAt('water', at);
    expect((await db.habitsDao.findOne('water'))!.archivedAt, at);

    await db.habitsDao.setArchivedAt('water', null);
    expect((await db.habitsDao.findOne('water'))!.archivedAt, isNull);
    expect(await db.habitsDao.setArchivedAt('nope', at), 0);
  });

  test('a habit is watched until it is deleted', () async {
    final seen = <String?>[];
    final subscription = db.habitsDao
        .watchOne('run')
        .listen((row) => seen.add(row?.id));
    await pumpEventQueue();

    await db.habitsDao.deleteHabit('run');
    await pumpEventQueue();
    await subscription.cancel();

    expect(seen, ['run', null]);
  });

  test('a log is put as given, and read back by its day', () async {
    final row = HabitLogRow(
      habitId: 'water',
      day: fixtureDay,
      count: 8,
      skipped: false,
    );

    await db.habitLogsDao.putLog(row);

    expect(await db.habitLogsDao.findOne('water', fixtureDay), row);
    expect(
      (await db.habitLogsDao.watchForHabit('water').first).map((l) => l.day),
      [fixtureDay.addDays(-1), fixtureDay],
    );
  });
}
