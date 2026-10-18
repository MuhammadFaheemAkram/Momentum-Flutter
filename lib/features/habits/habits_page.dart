import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Habits: a placeholder until Phase 3.
class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Habits'),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () => const SearchRoute().push<void>(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Both tabs stay alive in the shell's IndexedStack, each with a FAB;
        // with the default hero tag, pushing any screen above them would
        // find two heroes with one tag and assert (conventions §11.59).
        heroTag: 'new-habit-habits',
        onPressed: () => const NewHabitRoute().push<void>(context),
        icon: const Icon(Icons.add),
        label: const Text('New habit'),
      ),
      body: const EmptyStateView(
        icon: Icons.checklist_outlined,
        title: 'Habits',
        message:
            'Your habits, with search and category filters, arrive in Phase 3.',
      ),
    );
  }
}
