import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';

/// One habit ([habitId]): a placeholder until Phase 3. Opened by a link (or,
/// later, a notification) it has nothing to go back to, so it offers Close.
class HabitDetailPage extends StatelessWidget {
  const HabitDetailPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const HabitsRoute().go(context),
        ),
        title: const Text('Habit'),
      ),
      body: const EmptyStateView(
        icon: Icons.event_repeat_outlined,
        title: 'Habit',
        message: 'Its calendar, streaks and stats arrive in Phase 3.',
      ),
    );
  }
}
