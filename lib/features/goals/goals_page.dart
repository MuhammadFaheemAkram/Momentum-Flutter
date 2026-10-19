import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/goals/cubit/goals_cubit.dart';
import 'package:momentum/features/goals/goals_view.dart';

/// Goals (from the drawer, and from Today).
class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GoalsCubit>()..start(),
      child: const GoalsView(),
    );
  }
}
