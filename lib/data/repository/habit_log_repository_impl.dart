import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/habit_logs_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';

@LazySingleton(as: HabitLogRepository)
class HabitLogRepositoryImpl implements HabitLogRepository {
  const HabitLogRepositoryImpl(this._logs);

  final HabitLogsDao _logs;

  @override
  Stream<List<HabitLog>> watchLogs() =>
      _logs.watchAll().map((rows) => [for (final row in rows) row.toDomain()]);

  @override
  Stream<List<HabitLog>> watchLogsFor(String habitId) => _logs
      .watchForHabit(habitId)
      .map((rows) => [for (final row in rows) row.toDomain()]);

  @override
  Future<HabitLog?> findLog(String habitId, CalendarDate day) async =>
      (await _logs.findOne(habitId, day))?.toDomain();

  @override
  Future<Result<void>> addCheckIn(String habitId, CalendarDate day) =>
      guardWrite('Adding a check-in', () => _logs.addCheckIn(habitId, day));

  @override
  Future<Result<void>> skip(String habitId, CalendarDate day) =>
      guardWrite('Skipping a day', () => _logs.skip(habitId, day));

  @override
  Future<Result<void>> clear(String habitId, CalendarDate day) =>
      guardWrite('Clearing a day', () async {
        await _logs.clear(habitId, day);
      });

  @override
  Future<Result<void>> putLog(HabitLog log) =>
      guardWrite('Setting a day', () => _logs.putLog(log.toRow()));
}
