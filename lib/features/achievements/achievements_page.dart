import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Achievements: a placeholder until Phase 5.
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Achievements'),
      ),
      body: const EmptyStateView(
        icon: Icons.emoji_events_outlined,
        title: 'Achievements',
        message: 'Badges for streaks and milestones arrive in Phase 5.',
      ),
    );
  }
}
