import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/habits_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

@LazySingleton(as: HabitRepository)
class HabitRepositoryImpl implements HabitRepository {
  const HabitRepositoryImpl(this._habits, this._ids, this._clock);

  final HabitsDao _habits;
  final IdGenerator _ids;
  final Clock _clock;

  @override
  Stream<List<Habit>> watchHabits() => _habits.watchAll().map(
    (rows) => [for (final row in rows) row.toDomain()],
  );

  @override
  Stream<Habit?> watchHabit(String id) =>
      _habits.watchOne(id).map((row) => row?.toDomain());

  @override
  Future<Habit?> findHabit(String id) async =>
      (await _habits.findOne(id))?.toDomain();

  @override
  Future<Result<Habit>> createHabit(HabitDraft draft) =>
      guardWrite('Creating a habit', () async {
        final habit = _apply(
          draft,
          id: _ids.next('habit'),
          createdAt: _clock.now().toUtc(),
          sortOrder: await _habits.nextSortOrder(),
        );
        await _habits.insertHabit(habit.toRow());
        return habit;
      });

  @override
  Future<Result<Habit>> updateHabit(String id, HabitDraft draft) =>
      guardWrite('Updating a habit', () async {
        final existing = await _habits.findOne(id);
        if (existing == null) throw const NotFoundException('habit');
        final habit = _apply(
          draft,
          id: id,
          createdAt: existing.createdAt,
          sortOrder: existing.sortOrder,
        ).copyWith(archivedAt: existing.archivedAt);
        await _habits.updateHabit(habit.toRow());
        return habit;
      });

  @override
  Future<Result<void>> setArchived(String id, {required bool archived}) =>
      guardWrite('Archiving a habit', () async {
        final changed = await _habits.setArchivedAt(
          id,
          archived ? _clock.now().toUtc() : null,
        );
        if (changed == 0) throw const NotFoundException('habit');
      });

  @override
  Future<Result<void>> deleteHabit(String id) =>
      guardWrite('Deleting a habit', () async {
        await _habits.deleteHabit(id);
      });

  static Habit _apply(
    HabitDraft draft, {
    required String id,
    required DateTime createdAt,
    required int sortOrder,
  }) => Habit(
    id: id,
    title: draft.title.trim(),
    description: draft.description.trim(),
    category: draft.category,
    color: draft.color,
    icon: draft.icon,
    schedule: draft.schedule,
    dailyTarget: draft.dailyTarget,
    startDate: draft.startDate,
    reminder: draft.reminder,
    createdAt: createdAt,
    sortOrder: sortOrder,
  );
}
