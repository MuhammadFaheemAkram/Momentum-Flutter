import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/features/search/bloc/search_bloc.dart';
import 'package:momentum/features/search/bloc/search_event.dart';
import 'package:momentum/features/search/search_view.dart';

/// Search (from the drawer and the Today and Habits app bars).
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<SearchBloc>()..add(const SearchSubscriptionRequested()),
      child: const SearchView(),
    );
  }
}
