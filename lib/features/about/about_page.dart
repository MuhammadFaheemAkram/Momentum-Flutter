import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/device_info.dart';

/// About: what Momentum is, its version, the same app on other platforms,
/// and the open-source licenses.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _editions = [
    ('Android', 'Kotlin, Jetpack Compose, Room, WorkManager'),
    ('iOS', 'Swift, SwiftUI, SwiftData, BGTaskScheduler'),
    ('Flutter', 'Dart, material_ui, drift, workmanager (this app)'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = getIt<AppInfo>();
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const SettingsRoute().go(context),
        ),
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.medium),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Momentum', style: theme.textTheme.headlineSmall),
                Text(
                  'Version ${info.versionLabel}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  'A habit and productivity app: habits with schedules, '
                  'streaks, routines, goals and achievements, all on your '
                  'device. An open-source learning project.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SectionHeader('The same app on other platforms'),
          for (final (platform, stack) in _editions)
            ListTile(
              leading: const Icon(Icons.devices_outlined),
              title: Text(platform),
              subtitle: Text(stack),
            ),
          const SizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton.icon(
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: 'Momentum',
                  applicationVersion: info.versionLabel,
                ),
                icon: const Icon(Icons.article_outlined),
                label: const Text('Open-source licenses'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
