import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Settings: so far only About. Appearance, dynamic color, notifications,
/// backup, reset progress and the developer tools arrive in Phase 6.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.medium),
            child: Text(
              'Appearance, notifications and backup arrive in Phase 6.',
            ),
          ),
          const SectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Momentum'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => const AboutRoute().push<void>(context),
          ),
        ],
      ),
    );
  }
}
