import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/today/cubit/today_cubit.dart';
import 'package:momentum/features/today/today_view.dart';

/// Today (the first tab).
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TodayCubit>()..start(),
      child: const TodayView(),
    );
  }
}
