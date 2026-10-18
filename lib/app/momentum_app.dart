import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_router.dart';
import 'package:momentum/core/navigation/placeholder_onboarding.dart';
import 'package:momentum/di/injection.dart';

/// The root widget: themes and the router.
///
/// This `State` owns the router and disposes it. The router is created once,
/// not in `build`: a new router on every rebuild would reset navigation.
/// Phase 6 adds the app-scoped `SettingsCubit` here, above
/// `MaterialApp.router`, for the theme mode and dynamic color.
class MomentumApp extends StatefulWidget {
  const MomentumApp({super.key, this.initialLocation});

  /// Lets tests start on a deep link. The app itself starts on Today, and
  /// the first-launch gate redirects from there.
  final String? initialLocation;

  @override
  State<MomentumApp> createState() => _MomentumAppState();
}

class _MomentumAppState extends State<MomentumApp> {
  late final GoRouter _router = createAppRouter(
    onboarding: getIt<PlaceholderOnboarding>(),
    initialLocation: widget.initialLocation,
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Momentum',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: _router,
    );
  }
}
