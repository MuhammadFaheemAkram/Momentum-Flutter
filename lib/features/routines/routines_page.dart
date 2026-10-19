import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/routines/cubit/routines_cubit.dart';
import 'package:momentum/features/routines/routines_view.dart';

/// Routines (from the drawer, and from Today).
class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RoutinesCubit>()..start(),
      child: const RoutinesView(),
    );
  }
}
