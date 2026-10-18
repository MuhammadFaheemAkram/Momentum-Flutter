import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';

/// About: what Momentum is, and the open-source licenses. Phase 6 adds the
/// version and the editions on other platforms.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: fallbackCloseButton(
          context,
          () => const SettingsRoute().go(context),
        ),
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.medium),
        children: [
          Text('Momentum', style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.xSmall),
          Text(
            'A habit and productivity app: habits with schedules, streaks, '
            'routines, goals and achievements, all on your device. An '
            'open-source learning project.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.large),
          OutlinedButton.icon(
            onPressed: () =>
                showLicensePage(context: context, applicationName: 'Momentum'),
            icon: const Icon(Icons.article_outlined),
            label: const Text('Open-source licenses'),
          ),
        ],
      ),
    );
  }
}
