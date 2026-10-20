import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_router.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/stream_listenable.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';

/// The root widget: themes, the router, and the badge celebrations.
///
/// This `State` owns the router and the [StreamListenable] that lets it
/// follow the settings, and disposes both. The router is created once, not
/// in `build`: a new router on every rebuild would reset navigation.
///
/// It also watches for badges just earned, for as long as the app runs
/// (`WatchNewAchievementsUseCase`): each is recorded once, and celebrated
/// with a SnackBar on whatever screen is showing, through the app's
/// [ScaffoldMessenger].
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
  final _settings = getIt<SettingsRepository>();
  late final _settingsChanges = StreamListenable(_settings.watch());
  late final GoRouter _router = createAppRouter(
    settings: _settings,
    refreshListenable: _settingsChanges,
    initialLocation: widget.initialLocation,
  );
  final _messenger = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription<List<AchievementId>>? _celebrations;

  @override
  void initState() {
    super.initState();
    _celebrations = getIt<WatchNewAchievementsUseCase>()().listen(_celebrate);
  }

  void _celebrate(List<AchievementId> badges) {
    _messenger.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            badges.length == 1
                ? 'Badge unlocked: ${badges.single.title}'
                : '${badges.length} badges unlocked',
          ),
          action: SnackBarAction(
            label: 'View',
            onPressed: () => _router.go(const AchievementsRoute().location),
          ),
        ),
      );
  }

  @override
  void dispose() {
    unawaited(_celebrations?.cancel());
    _router.dispose();
    _settingsChanges.dispose();
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
      scaffoldMessengerKey: _messenger,
    );
  }
}
