import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_state.dart';

/// Opens the routine editor (new, or [routineId]'s), and says what happened
/// on the screen it was opened from.
Future<void> openRoutineEditor(
  BuildContext context, {
  String? routineId,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final exit = routineId == null
      ? await const NewRoutineRoute().push<RoutineEditorExit>(context)
      : await EditRoutineRoute(routineId: routineId)
            .push<RoutineEditorExit>(context);
  final message = switch (exit) {
    RoutineSaved(:final routine, created: true) => 'Added ${routine.title}',
    RoutineDeleted(:final title) => 'Deleted $title',
    _ => null,
  };
  if (message != null) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
