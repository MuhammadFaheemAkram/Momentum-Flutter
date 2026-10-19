import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/daos/routines_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/repository/routine_repository.dart';
import 'package:stream_transform/stream_transform.dart';

@LazySingleton(as: RoutineRepository)
class RoutineRepositoryImpl implements RoutineRepository {
  const RoutineRepositoryImpl(this._routines, this._ids, this._clock);

  final RoutinesDao _routines;
  final IdGenerator _ids;
  final Clock _clock;

  @override
  Stream<List<Routine>> watchRoutines() => _routines
      .watchRoutines()
      .combineLatest(_routines.watchItems(), _assemble);

  @override
  Stream<List<RoutineCheck>> watchChecks() => _routines.watchChecks().map(
    (rows) => [
      for (final row in rows) RoutineCheck(itemId: row.itemId, day: row.day),
    ],
  );

  @override
  Future<Routine?> findRoutine(String id) async {
    final row = await _routines.findRoutine(id);
    return row?.toDomain(await _routines.itemsOf(id));
  }

  @override
  Future<Result<Routine>> saveRoutine(RoutineDraft draft, {String? id}) =>
      guardWrite('Saving a routine', () async {
        final existing = id == null ? null : await _routines.findRoutine(id);
        if (id != null && existing == null) {
          throw const NotFoundException('routine');
        }
        final routine = Routine(
          id: existing?.id ?? _ids.next('routine'),
          title: draft.title.trim(),
          time: draft.time,
          items: [
            for (final item in draft.items)
              item.copyWith(title: item.title.trim()),
          ],
          createdAt: existing?.createdAt ?? _clock.now().toUtc(),
          sortOrder: existing?.sortOrder ?? await _routines.nextSortOrder(),
        );
        await _routines.saveRoutine(routine.toRow(), [
          for (final (index, item) in routine.items.indexed)
            RoutineItemRow(
              id: item.id,
              routineId: routine.id,
              title: item.title,
              sortOrder: index,
            ),
        ]);
        return routine;
      });

  @override
  Future<Result<void>> deleteRoutine(String id) =>
      guardWrite('Deleting a routine', () async {
        await _routines.deleteRoutine(id);
      });

  @override
  Future<Result<void>> setChecked(
    String itemId,
    CalendarDate day, {
    required bool checked,
  }) => guardWrite(
    'Checking off a routine step',
    () => _routines.setChecked(itemId, day, checked: checked),
  );

  static List<Routine> _assemble(
    List<RoutineRow> routines,
    List<RoutineItemRow> items,
  ) {
    final byRoutine = <String, List<RoutineItemRow>>{};
    for (final item in items) {
      (byRoutine[item.routineId] ??= []).add(item);
    }
    return [
      for (final row in routines) row.toDomain(byRoutine[row.id] ?? const []),
    ];
  }
}
