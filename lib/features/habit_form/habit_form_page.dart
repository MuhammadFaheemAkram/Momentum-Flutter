import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';

/// The habit form, as a full-screen dialog: new, or editing [habitId]. A
/// placeholder until Phase 3.
///
/// Its Close button is always there (an app bar adds one only when it can
/// pop), and for a deep link with nothing underneath it goes to a sensible
/// home instead of popping the router's last page (conventions §11.47).
class HabitFormPage extends StatelessWidget {
  const HabitFormPage({super.key, this.habitId});

  final String? habitId;

  void _close(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      const HabitsRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(onPressed: () => _close(context)),
        title: Text(habitId == null ? 'New habit' : 'Edit habit'),
      ),
      body: const EmptyStateView(
        icon: Icons.edit_calendar_outlined,
        title: 'New habit',
        message: 'The habit form, with its schedule, reminder, color and icon, arrives in Phase 3.',
      ),
    );
  }
}
