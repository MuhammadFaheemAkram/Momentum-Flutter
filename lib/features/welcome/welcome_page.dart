import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/placeholder_onboarding.dart';
import 'package:momentum/di/injection.dart';

/// First launch: explore with demo data, or start empty.
///
/// Neither button navigates. Each records the choice, and the router's
/// first-launch gate moves the user to Today. In Phase 1 both only set the
/// in-memory [PlaceholderOnboarding]; Phase 2 fetches the demo first (with a
/// progress indicator and a retry) and saves the choice.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final onboarding = getIt<PlaceholderOnboarding>();
    return WelcomeView(
      onExploreDemo: onboarding.complete,
      onStartEmpty: onboarding.complete,
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
    required this.onExploreDemo,
    required this.onStartEmpty,
  });

  final VoidCallback onExploreDemo;
  final VoidCallback onStartEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.trending_up_rounded,
                    size: AppIconSize.large * 1.5,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.medium),
                  Text(
                    'Momentum',
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  Text(
                    'Build habits that stick: check them off each day, keep '
                    'your streaks, run your routines and see your progress.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xLarge),
                  FilledButton(
                    onPressed: onExploreDemo,
                    child: const Text('Explore with demo data'),
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  TextButton(
                    onPressed: onStartEmpty,
                    child: const Text('Start empty'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
