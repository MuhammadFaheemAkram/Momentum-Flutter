import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_router.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/stream_listenable.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';
import 'package:momentum/domain/usecase/habit_day_use_cases.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';
import 'package:momentum/features/settings/cubit/settings_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_state.dart';

/// The root widget: the app-wide `SettingsCubit`, themes, the router, and
/// the work that lasts as long as the app runs.
///
/// This `State` owns the router and the [StreamListenable] that lets it
/// follow the settings, and disposes both. The router is created once, not
/// in `build`: a new router on every rebuild would reset navigation.
///
/// While the app runs, it:
/// - celebrates badges just earned (`WatchNewAchievementsUseCase`), with a
///   SnackBar on whatever screen is showing, through the app's
///   [ScaffoldMessenger];
/// - keeps the notifications in step with the data
///   (`KeepNotificationsInSyncUseCase`), and again on every resume, after
///   reloading the settings the background isolate may have changed (a
///   backup's time, a permission revoked in system settings);
/// - follows notification taps (a habit's reminder opens the habit, the
///   nudge and the summary open Today) and runs a "Mark done" that reaches
///   it. A tap that *launched* the app arrives as [initialLocation].
class MomentumApp extends StatefulWidget {
  const MomentumApp({super.key, this.initialLocation});

  /// A notification's screen on a cold start, or a test's deep link. The
  /// app otherwise starts on Today, and the first-launch gate redirects
  /// from there.
  final String? initialLocation;

  /// Where a notification's [target] opens the app on a cold start: a
  /// habit's page, or (`null`) the usual start, Today.
  static String? locationFor(NotificationTarget? target) => switch (target) {
    OpenHabit(:final habitId) => HabitDetailRoute(habitId: habitId).location,
    OpenToday() || null => null,
  };

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
  final _subscriptions = <StreamSubscription<Object?>>[];
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _subscriptions.addAll([
      getIt<WatchNewAchievementsUseCase>()().listen(_celebrate),
      getIt<KeepNotificationsInSyncUseCase>()().listen((_) {}),
      getIt<NotificationInteractions>().interactions.listen(_follow),
    ]);
    _lifecycle = AppLifecycleListener(onResume: _resumed);
  }

  Future<void> _resumed() async {
    await _settings.reload();
    await getIt<SyncNotificationsUseCase>()();
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

  Future<void> _follow(NotificationInteraction interaction) async {
    switch (interaction) {
      case NotificationOpened(target: OpenHabit(:final habitId)):
        // Pushed, so Back returns to wherever the user was.
        unawaited(_router.push(HabitDetailRoute(habitId: habitId).location));
      case NotificationOpened(target: OpenToday()):
        _router.go(const TodayRoute().location);
      case MarkDoneChosen(:final habitId):
        if (await getIt<MarkHabitDoneUseCase>()(habitId) case Err(
          :final exception,
        )) {
          _messenger.currentState?.showSnackBar(
            SnackBar(content: Text(exception.message)),
          );
        }
    }
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    _router.dispose();
    _settingsChanges.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..load(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final seed = state.dynamicSeed;
          return MaterialApp.router(
            title: 'Momentum',
            debugShowCheckedModeBanner: false,
            theme: seed == null
                ? AppTheme.light()
                : AppTheme.fromWallpaper(Color(seed), Brightness.light),
            darkTheme: seed == null
                ? AppTheme.dark()
                : AppTheme.fromWallpaper(Color(seed), Brightness.dark),
            themeMode: switch (state.settings.themeMode) {
              AppThemeMode.system => ThemeMode.system,
              AppThemeMode.light => ThemeMode.light,
              AppThemeMode.dark => ThemeMode.dark,
            },
            routerConfig: _router,
            scaffoldMessengerKey: _messenger,
          );
        },
      ),
    );
  }
}
