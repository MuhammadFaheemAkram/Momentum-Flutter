import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/welcome/cubit/welcome_cubit.dart';
import 'package:momentum/features/welcome/cubit/welcome_state.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WelcomeCubit>(),
      child: const WelcomeView(),
    );
  }
}

/// First launch: explore with demo data, or start empty.
///
/// Neither button navigates: the choice is saved, and the router's
/// first-launch gate moves the user to Today. The demo comes from the fake
/// service, so it can take a moment, and fail: the error appears above the
/// buttons and the demo button becomes "Try again", while "Start empty"
/// stays available.
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WelcomeCubit>();
    final state = context.watch<WelcomeCubit>().state;
    final theme = Theme.of(context);
    final busy = state.isStarting;
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
                  if (state.errorMessage case final message?) ...[
                    _DemoError(message: message),
                    const SizedBox(height: AppSpacing.medium),
                  ],
                  FilledButton(
                    onPressed: busy ? null : cubit.exploreDemo,
                    child: _Label(
                      text: state.errorMessage == null
                          ? 'Explore with demo data'
                          : 'Try again',
                      busyText: 'Loading the demo',
                      busy: state.starting == StartChoice.demo,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xSmall),
                  TextButton(
                    onPressed: busy ? null : cubit.startEmpty,
                    child: _Label(
                      text: 'Start empty',
                      busyText: 'Starting',
                      busy: state.starting == StartChoice.empty,
                    ),
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

/// Why the demo didn't load. A live region, so a screen reader announces it
/// when it appears.
class _DemoError extends StatelessWidget {
  const _DemoError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.errorContainer,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Row(
          children: [
            Icon(Icons.cloud_off_outlined, color: scheme.onErrorContainer),
            const SizedBox(width: AppSpacing.small),
            Expanded(
              child: Semantics(
                liveRegion: true,
                child: Text(
                  message,
                  style: TextStyle(color: scheme.onErrorContainer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A button's label, or a small spinner while its start runs.
class _Label extends StatelessWidget {
  const _Label({
    required this.text,
    required this.busyText,
    required this.busy,
  });

  final String text;
  final String busyText;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    if (!busy) return Text(text);
    return Semantics(
      label: busyText,
      child: const SizedBox.square(
        dimension: 20,
        child: CircularProgressIndicator.adaptive(strokeWidth: 2),
      ),
    );
  }
}
