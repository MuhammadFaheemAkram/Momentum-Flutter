import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/routines.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/repository/routine_repository.dart';
import 'package:stream_transform/stream_transform.dart';

/// The routines with today's check-offs, live, and again at midnight (the
/// clock first: conventions §11.61).
@injectable
class WatchRoutinesUseCase {
  const WatchRoutinesUseCase(this._routines, this._clock);

  final RoutineRepository _routines;
  final CalendarClock _clock;

  Stream<({CalendarDate today, List<RoutineProgress> routines})> call() =>
      _clock.watchToday().combineLatest(
        _routines.watchRoutines().combineLatest(
          _routines.watchChecks(),
          (routines, checks) => (routines, checks),
        ),
        (today, data) => (
          today: today,
          routines: routinesToday(data.$1, data.$2, today: today),
        ),
      );
}

@injectable
class FindRoutineUseCase {
  const FindRoutineUseCase(this._routines);

  final RoutineRepository _routines;

  Future<Routine?> call(String id) => _routines.findRoutine(id);
}

/// Creates or rewrites a routine, items and their order in one transaction,
/// after checking the editor's rules.
@injectable
class SaveRoutineUseCase {
  const SaveRoutineUseCase(this._routines);

  final RoutineRepository _routines;

  Future<Result<Routine>> call(RoutineDraft draft, {String? id}) async {
    if (routineDraftError(draft) case final problem?) {
      return Err(InvalidInputException(problem));
    }
    return _routines.saveRoutine(draft, id: id);
  }
}

@injectable
class DeleteRoutineUseCase {
  const DeleteRoutineUseCase(this._routines);

  final RoutineRepository _routines;

  Future<Result<void>> call(String id) => _routines.deleteRoutine(id);
}

/// Checks a routine step off for today, or un-checks it. Routines start
/// afresh each day: only today's check-offs can change.
@injectable
class ToggleRoutineItemUseCase {
  const ToggleRoutineItemUseCase(this._routines, this._clock);

  final RoutineRepository _routines;
  final CalendarClock _clock;

  Future<Result<void>> call(String itemId, {required bool checked}) =>
      _routines.setChecked(itemId, _clock.today, checked: checked);
}
