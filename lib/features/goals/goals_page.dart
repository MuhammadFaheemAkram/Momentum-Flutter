import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';

/// Goals (from the drawer): a placeholder until Phase 4.
class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const TodayRoute().go(context),
        ),
        title: const Text('Goals'),
      ),
      body: const EmptyStateView(
        icon: Icons.flag_outlined,
        title: 'Goals',
        message: 'Daily, weekly and monthly goals arrive in Phase 4.',
      ),
    );
  }
}
