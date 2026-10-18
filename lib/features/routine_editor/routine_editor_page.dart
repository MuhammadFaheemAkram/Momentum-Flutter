import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';

/// The routine editor, as a full-screen dialog: new, or editing [routineId].
/// A placeholder until Phase 4.
///
/// Its Close button is always there (an app bar adds one only when it can
/// pop), and for a deep link with nothing underneath it goes to a sensible
/// home instead of popping the router's last page (conventions §11.47).
class RoutineEditorPage extends StatelessWidget {
  const RoutineEditorPage({super.key, this.routineId});

  final String? routineId;

  void _close(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      const RoutinesRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(onPressed: () => _close(context)),
        title: Text(routineId == null ? 'New routine' : 'Edit routine'),
      ),
      body: const EmptyStateView(
        icon: Icons.edit_note,
        title: 'New routine',
        message: 'The routine editor, with items you reorder by dragging, arrives in Phase 4.',
      ),
    );
  }
}
