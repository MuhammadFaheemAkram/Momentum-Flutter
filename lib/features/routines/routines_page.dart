import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';

/// Routines (from the drawer): a placeholder until Phase 4.
class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const TodayRoute().go(context),
        ),
        title: const Text('Routines'),
      ),
      body: const EmptyStateView(
        icon: Icons.wb_twilight_outlined,
        title: 'Routines',
        message: 'Morning and evening routines with ordered items arrive in Phase 4.',
      ),
    );
  }
}
