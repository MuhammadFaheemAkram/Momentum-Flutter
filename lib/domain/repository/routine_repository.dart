import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/routine.dart';

abstract interface class RoutineRepository {
  /// Every routine with its items in order, on listen and after every change.
  Stream<List<Routine>> watchRoutines();

  /// Every check-off.
  Stream<List<RoutineCheck>> watchChecks();

  Future<Routine?> findRoutine(String id);

  /// Creates a routine ([id] null) or rewrites [id]'s: its title, its time,
  /// and its items in their order, all in one transaction.
  Future<Result<Routine>> saveRoutine(RoutineDraft draft, {String? id});

  Future<Result<void>> deleteRoutine(String id);

  Future<Result<void>> setChecked(
    String itemId,
    CalendarDate day, {
    required bool checked,
  });
}
