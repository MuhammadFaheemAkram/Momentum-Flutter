import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Today (the first tab): a placeholder until Phase 3.
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Today'),
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
        heroTag: 'new-habit-today',
        onPressed: () => const NewHabitRoute().push<void>(context),
        icon: const Icon(Icons.add),
        label: const Text('New habit'),
      ),
      body: const EmptyStateView(
        icon: Icons.today_outlined,
        title: 'Today',
        message: 'Today\'s habits, your streak and the completion ring arrive in Phase 3.',
      ),
    );
  }
}
