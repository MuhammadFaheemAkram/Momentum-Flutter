import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/habits/cubit/habits_cubit.dart';
import 'package:momentum/features/habits/habits_view.dart';

/// Habits (the second tab).
class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HabitsCubit>()..start(),
      child: const HabitsView(),
    );
  }
}
