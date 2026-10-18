import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';

/// Search (from the drawer and app bars): a placeholder until Phase 5.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const TodayRoute().go(context),
        ),
        title: const Text('Search'),
      ),
      body: const EmptyStateView(
        icon: Icons.search,
        title: 'Search',
        message: 'Search across habits, routines, goals and achievements arrives in Phase 5.',
      ),
    );
  }
}
