import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/fallback_close_button.dart';
import 'package:momentum/features/routine_editor/open_routine_editor.dart';
import 'package:momentum/features/routines/cubit/routines_cubit.dart';
import 'package:momentum/features/routines/cubit/routines_state.dart';

/// Every routine, in the order of the day, each with today's steps to check
/// off. Opened by a link it has nothing to go back to, so it offers Close.
class RoutinesView extends StatelessWidget {
  const RoutinesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RoutinesCubit>();
    final state = context.watch<RoutinesCubit>().state;
    return BlocListener<RoutinesCubit, RoutinesState>(
      listenWhen: (previous, current) =>
          previous.messageSerial != current.messageSerial,
      listener: (context, state) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(state.message ?? ''))),
      child: Scaffold(
        appBar: AppBar(
          leading: fallbackCloseButton(
            context,
            () => const TodayRoute().go(context),
          ),
          title: const Text('Routines'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => openRoutineEditor(context),
          icon: const Icon(Icons.add),
          label: const Text('New routine'),
        ),
        body: switch (state.status) {
          RoutinesStatus.loading => const LoadingView(
            message: 'Loading your routines…',
          ),
          RoutinesStatus.failed => ErrorView(
            message: "Your routines couldn't be loaded.",
            onRetry: cubit.start,
          ),
          RoutinesStatus.ready when state.routines.isEmpty => EmptyStateView(
            icon: Icons.wb_twilight_outlined,
            title: 'No routines yet',
            message:
                'A routine is a short checklist for a time of day, like a '
                'morning one: make the bed, stretch, plan the day.',
            action: FilledButton(
              onPressed: () => openRoutineEditor(context),
              child: const Text('New routine'),
            ),
          ),
          RoutinesStatus.ready => ListView(
            padding: const EdgeInsets.only(top: AppSpacing.xSmall, bottom: 96),
            children: [
              for (final progress in state.routines)
                RoutineCard(
                  progress: progress,
                  onToggle: cubit.toggle,
                  onEdit: () => openRoutineEditor(
                    context,
                    routineId: progress.routine.id,
                  ),
                ),
            ],
          ),
        },
      ),
    );
  }
}
