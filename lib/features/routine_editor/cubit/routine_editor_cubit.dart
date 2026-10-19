import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/id_generator.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/domain/usecase/routine_use_cases.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_state.dart';

/// Creates a routine ([routineId] null) or edits [routineId]'s: its title,
/// time of day, and steps, which can be added, renamed, removed and
/// reordered. Nothing is written until Save, which writes the routine and
/// every step's position in one transaction.
@injectable
class RoutineEditorCubit extends Cubit<RoutineEditorState> {
  RoutineEditorCubit(
    this._findRoutine,
    this._saveRoutine,
    this._deleteRoutine,
    this._ids,
    @factoryParam this.routineId,
  ) : super(const RoutineEditorState());

  final FindRoutineUseCase _findRoutine;
  final SaveRoutineUseCase _saveRoutine;
  final DeleteRoutineUseCase _deleteRoutine;
  final IdGenerator _ids;
  final String? routineId;

  bool get isNew => routineId == null;

  Future<void> load() async {
    final id = routineId;
    if (id == null) {
      // A first, empty step to type into.
      final draft = RoutineDraft(
        title: '',
        items: [RoutineItem(id: _ids.next('item'), title: '')],
      );
      emit(
        state.copyWith(
          status: RoutineEditorStatus.editing,
          original: draft,
          draft: draft,
        ),
      );
      return;
    }
    final routine = await _findRoutine(id);
    if (isClosed) return;
    if (routine == null) {
      emit(state.copyWith(status: RoutineEditorStatus.notFound));
      return;
    }
    final draft = RoutineDraft.of(routine);
    emit(
      state.copyWith(
        status: RoutineEditorStatus.editing,
        original: draft,
        draft: draft,
      ),
    );
  }

  void _update(RoutineDraft Function(RoutineDraft draft) change) {
    final draft = state.draft;
    if (draft == null || state.saving) return;
    emit(state.copyWith(draft: change(draft)));
  }

  void titleChanged(String title) => _update((d) => d.copyWith(title: title));

  void timeChanged(RoutineTime time) => _update((d) => d.copyWith(time: time));

  /// A new, empty step at the end; returns its id (for the view to focus).
  String? addItem() {
    if (!state.canAddItem) return null;
    final item = RoutineItem(id: _ids.next('item'), title: '');
    _update((d) => d.copyWith(items: [...d.items, item]));
    return item.id;
  }

  void itemChanged(String id, String title) => _update(
    (d) => d.copyWith(
      items: [
        for (final item in d.items)
          item.id == id ? item.copyWith(title: title) : item,
      ],
    ),
  );

  void removeItem(String id) => _update(
    (d) => d.copyWith(items: [...d.items.where((item) => item.id != id)]),
  );

  /// Moves the step at [oldIndex] to [newIndex], its place once moved
  /// (`ReorderableListView.onReorderItem`). The screen-reader actions (Move
  /// up, Move down, to the start, to the end) arrive here too.
  void moveItem(int oldIndex, int newIndex) => _update((d) {
    final items = [...d.items];
    items.insert(newIndex, items.removeAt(oldIndex));
    return d.copyWith(items: items);
  });

  /// Saves, unless nothing changed (then it just closes). With a problem,
  /// the errors appear under the fields instead.
  Future<void> save() async {
    final draft = state.draft;
    if (draft == null || state.saving) return;
    if (!isNew && !state.isDirty) {
      emit(state.copyWith(exit: const RoutineDiscarded()));
      return;
    }
    if (routineDraftError(draft) != null) {
      emit(state.copyWith(showErrors: true));
      return;
    }
    emit(state.copyWith(saving: true));
    final result = await _saveRoutine(draft, id: routineId);
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            saving: false,
            exit: RoutineSaved(value, created: isNew),
          ),
        );
      case Err(:final exception):
        _fail(exception.message);
    }
  }

  void discard() => emit(state.copyWith(exit: const RoutineDiscarded()));

  Future<void> delete() async {
    final id = routineId;
    if (id == null || state.saving) return;
    emit(state.copyWith(saving: true));
    final result = await _deleteRoutine(id);
    if (isClosed) return;
    switch (result) {
      case Ok():
        emit(
          state.copyWith(
            saving: false,
            exit: RoutineDeleted(state.original?.title ?? ''),
          ),
        );
      case Err(:final exception):
        _fail(exception.message);
    }
  }

  void _fail(String message) => emit(
    state.copyWith(
      saving: false,
      errorMessage: message,
      errorSerial: state.errorSerial + 1,
    ),
  );
}
