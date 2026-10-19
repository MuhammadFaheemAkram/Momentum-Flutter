import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart';
import 'package:momentum/features/habit_detail/habit_detail_view.dart';

/// One habit ([habitId]): its calendar, streaks and stats.
class HabitDetailPage extends StatelessWidget {
  const HabitDetailPage({super.key, required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HabitDetailCubit>(param1: habitId)..start(),
      child: const HabitDetailView(),
    );
  }
}
