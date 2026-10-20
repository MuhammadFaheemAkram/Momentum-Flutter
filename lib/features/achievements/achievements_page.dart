import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/achievements/cubit/achievements_cubit.dart';
import 'package:momentum/features/achievements/cubit/achievements_state.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Achievements (the fourth tab, "Badges" in the bar).
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AchievementsCubit>()..start(),
      child: const AchievementsView(),
    );
  }
}

/// Every badge: how many are unlocked, then the unlocked ones (with their
/// dates) and the locked ones (with their rule and progress), two by two,
/// one by one at large text.
class AchievementsView extends StatelessWidget {
  const AchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AchievementsCubit>();
    final state = context.watch<AchievementsCubit>().state;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        title: const Text('Achievements'),
      ),
      body: switch (state.status) {
        AchievementsStatus.loading => const LoadingView(
          message: 'Loading your badges…',
        ),
        AchievementsStatus.failed => ErrorView(
          message: "Your badges couldn't be loaded.",
          onRetry: cubit.start,
        ),
        AchievementsStatus.ready => LayoutBuilder(
          builder: (context, constraints) {
            final columns = context.prefersStackedLayout ? 1 : 2;
            final width =
                (constraints.maxWidth -
                    2 * AppSpacing.medium -
                    AppSpacing.xSmall * (columns - 1)) /
                columns;
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.medium),
              children: [
                Semantics(
                  container: true,
                  header: true,
                  child: Text(
                    '${state.unlockedCount} of ${state.statuses.length} '
                    'unlocked',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Wrap(
                  spacing: AppSpacing.xSmall,
                  runSpacing: AppSpacing.xSmall,
                  children: [
                    for (final status in state.ordered)
                      SizedBox(
                        width: width,
                        child: AchievementBadge(
                          status: status,
                          today: state.today!,
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      },
    );
  }
}
