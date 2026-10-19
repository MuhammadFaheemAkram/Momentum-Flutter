import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/routine.dart';

part 'routine_editor_state.freezed.dart';

enum RoutineEditorStatus { loading, editing, notFound }

/// How the editor closed: the page pops with it.
sealed class RoutineEditorExit {
  const RoutineEditorExit();
}

final class RoutineSaved extends RoutineEditorExit {
  const RoutineSaved(this.routine, {required this.created});

  final Routine routine;
  final bool created;
}

final class RoutineDeleted extends RoutineEditorExit {
  const RoutineDeleted(this.title);

  final String title;
}

final class RoutineDiscarded extends RoutineEditorExit {
  const RoutineDiscarded();
}

@freezed
abstract class RoutineEditorState with _$RoutineEditorState {
  const factory RoutineEditorState({
    @Default(RoutineEditorStatus.loading) RoutineEditorStatus status,

    /// What the routine was when opened, to tell whether anything changed.
    RoutineDraft? original,
    RoutineDraft? draft,

    /// Errors show under the fields only after a first Save.
    @Default(false) bool showErrors,
    @Default(false) bool saving,
    RoutineEditorExit? exit,
    String? errorMessage,
    @Default(0) int errorSerial,
  }) = _RoutineEditorState;

  const RoutineEditorState._();

  bool get isDirty => draft != null && draft != original;

  bool get canAddItem => (draft?.items.length ?? 0) < RoutineLimits.maxItems;

  String? get titleError =>
      showErrors ? routineTitleError(draft?.title ?? '') : null;

  String? get itemsError =>
      showErrors ? routineItemsError(draft?.items ?? const []) : null;

  String? itemError(RoutineItem item) =>
      showErrors ? routineItemTitleError(item.title) : null;
}
