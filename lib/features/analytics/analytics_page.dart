import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Analytics: a placeholder until Phase 5.
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Analytics'),
      ),
      body: const EmptyStateView(
        icon: Icons.insights_outlined,
        title: 'Analytics',
        message: 'Completion rates, the consistency score and charts arrive in Phase 5.',
      ),
    );
  }
}
