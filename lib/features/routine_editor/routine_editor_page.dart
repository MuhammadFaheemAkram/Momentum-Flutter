import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_cubit.dart';
import 'package:momentum/features/routine_editor/routine_editor_view.dart';

/// The routine editor, as a full-screen dialog: new, or editing [routineId].
class RoutineEditorPage extends StatelessWidget {
  const RoutineEditorPage({super.key, this.routineId});

  final String? routineId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RoutineEditorCubit>(param1: routineId)..load(),
      child: const RoutineEditorView(),
    );
  }
}
