import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_log.dart';

/// The habits' history: one log per habit per day.
abstract interface class HabitLogRepository {
  Stream<List<HabitLog>> watchLogs();

  Stream<List<HabitLog>> watchLogsFor(String habitId);

  Future<HabitLog?> findLog(String habitId, CalendarDate day);

  /// One more check-in; a skipped day becomes a done one.
  Future<Result<void>> addCheckIn(String habitId, CalendarDate day);

  Future<Result<void>> skip(String habitId, CalendarDate day);

  /// The day goes back to having no log.
  Future<Result<void>> clear(String habitId, CalendarDate day);

  /// Makes [log] the day's log, whatever was there.
  Future<Result<void>> putLog(HabitLog log);
}
