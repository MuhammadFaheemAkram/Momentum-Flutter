import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'habit_logs_dao.g.dart';

/// The three things that happen to a day's log. Each is one statement on the
/// (habit, day) primary key, so a double tap can't create two logs.
@DriftAccessor(tables: [HabitLogs])
class HabitLogsDao extends DatabaseAccessor<AppDatabase>
    with _$HabitLogsDaoMixin {
  HabitLogsDao(super.attachedDatabase);

  /// Every log; the engine derives everything from them. A user's history
  /// is small (a few thousand rows after years), so loading it whole keeps
  /// every streak exact.
  Stream<List<HabitLogRow>> watchAll() =>
      (select(habitLogs)..orderBy([
            (t) => OrderingTerm(expression: t.habitId),
            (t) => OrderingTerm(expression: t.day),
          ]))
          .watch();

  Stream<List<HabitLogRow>> watchForHabit(String habitId) =>
      (select(habitLogs)
            ..where((t) => t.habitId.equals(habitId))
            ..orderBy([(t) => OrderingTerm(expression: t.day)]))
          .watch();

  /// [day]'s log as it is now, if any.
  Future<HabitLogRow?> findOne(String habitId, CalendarDate day) =>
      (select(habitLogs)
            ..where((t) => t.habitId.equals(habitId) & t.day.equalsValue(day)))
          .getSingleOrNull();

  /// Makes [row] the day's log, whatever was there (backfill, and putting
  /// a log back after an undo).
  Future<void> putLog(HabitLogRow row) =>
      into(habitLogs).insert(row, onConflict: DoUpdate((_) => row));

  /// One more check-in on [day]: the first creates the log, the next ones
  /// add to it (`INSERT … ON CONFLICT DO UPDATE`), and a skipped day becomes
  /// a done one.
  Future<void> addCheckIn(String habitId, CalendarDate day) {
    return into(habitLogs).insert(
      HabitLogsCompanion.insert(habitId: habitId, day: day, count: 1),
      onConflict: DoUpdate(
        (old) => HabitLogsCompanion.custom(
          count: old.count + const Constant(1),
          skipped: const Constant(false),
        ),
      ),
    );
  }

  /// Marks [day] skipped, dropping any check-ins.
  Future<void> skip(String habitId, CalendarDate day) {
    final skip = HabitLogsCompanion.insert(
      habitId: habitId,
      day: day,
      count: 0,
      skipped: const Value(true),
    );
    return into(habitLogs).insert(skip, onConflict: DoUpdate((_) => skip));
  }

  /// Undo: [day] goes back to having no log at all.
  Future<void> clear(String habitId, CalendarDate day) {
    return (delete(
      habitLogs,
    )..where((t) => t.habitId.equals(habitId) & t.day.equalsValue(day))).go();
  }
}
