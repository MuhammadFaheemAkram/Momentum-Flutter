import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart';
import 'package:momentum/features/habit_form/habit_form_view.dart';

/// The habit form, as a full-screen dialog: new, or editing [habitId].
class HabitFormPage extends StatelessWidget {
  const HabitFormPage({super.key, this.habitId});

  final String? habitId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HabitFormCubit>(param1: habitId)..load(),
      child: const HabitFormView(),
    );
  }
}
