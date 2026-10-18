// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $welcomeRoute,
  $mainShellRoute,
  $newHabitRoute,
  $habitDetailRoute,
  $routinesRoute,
  $goalsRoute,
  $searchRoute,
  $aboutRoute,
];

RouteBase get $welcomeRoute => GoRouteData.$route(
  path: '/welcome',
  hasOverriddenOnExit: false,
  factory: $WelcomeRoute._fromState,
);

mixin $WelcomeRoute on GoRouteData {
  static WelcomeRoute _fromState(GoRouterState state) => const WelcomeRoute();

  @override
  String get location => GoRouteData.$location('/welcome');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRoute => StatefulShellRouteData.$route(
  factory: $MainShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      navigatorKey: TodayBranch.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/today',
          hasOverriddenOnExit: false,
          factory: $TodayRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: HabitsBranch.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/habits',
          hasOverriddenOnExit: false,
          factory: $HabitsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: AnalyticsBranch.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/analytics',
          hasOverriddenOnExit: false,
          factory: $AnalyticsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: AchievementsBranch.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/achievements',
          hasOverriddenOnExit: false,
          factory: $AchievementsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: SettingsBranch.$navigatorKey,
      routes: [
        GoRouteData.$route(
          path: '/settings',
          hasOverriddenOnExit: false,
          factory: $SettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteExtension on MainShellRoute {
  static MainShellRoute _fromState(GoRouterState state) =>
      const MainShellRoute();
}

mixin $TodayRoute on GoRouteData {
  static TodayRoute _fromState(GoRouterState state) => const TodayRoute();

  @override
  String get location => GoRouteData.$location('/today');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $HabitsRoute on GoRouteData {
  static HabitsRoute _fromState(GoRouterState state) => const HabitsRoute();

  @override
  String get location => GoRouteData.$location('/habits');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AnalyticsRoute on GoRouteData {
  static AnalyticsRoute _fromState(GoRouterState state) =>
      const AnalyticsRoute();

  @override
  String get location => GoRouteData.$location('/analytics');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AchievementsRoute on GoRouteData {
  static AchievementsRoute _fromState(GoRouterState state) =>
      const AchievementsRoute();

  @override
  String get location => GoRouteData.$location('/achievements');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newHabitRoute => GoRouteData.$route(
  path: '/habits/new',
  hasOverriddenOnExit: false,
  factory: $NewHabitRoute._fromState,
);

mixin $NewHabitRoute on GoRouteData {
  static NewHabitRoute _fromState(GoRouterState state) => const NewHabitRoute();

  @override
  String get location => GoRouteData.$location('/habits/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $habitDetailRoute => GoRouteData.$route(
  path: '/habits/:habitId',
  hasOverriddenOnExit: false,
  factory: $HabitDetailRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'edit',
      hasOverriddenOnExit: false,
      factory: $EditHabitRoute._fromState,
    ),
  ],
);

mixin $HabitDetailRoute on GoRouteData {
  static HabitDetailRoute _fromState(GoRouterState state) =>
      HabitDetailRoute(habitId: state.pathParameters['habitId']!);

  HabitDetailRoute get _self => this as HabitDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/habits/${Uri.encodeComponent(_self.habitId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditHabitRoute on GoRouteData {
  static EditHabitRoute _fromState(GoRouterState state) =>
      EditHabitRoute(habitId: state.pathParameters['habitId']!);

  EditHabitRoute get _self => this as EditHabitRoute;

  @override
  String get location => GoRouteData.$location(
    '/habits/${Uri.encodeComponent(_self.habitId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $routinesRoute => GoRouteData.$route(
  path: '/routines',
  hasOverriddenOnExit: false,
  factory: $RoutinesRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'new',
      hasOverriddenOnExit: false,
      factory: $NewRoutineRoute._fromState,
    ),
    GoRouteData.$route(
      path: ':routineId/edit',
      hasOverriddenOnExit: false,
      factory: $EditRoutineRoute._fromState,
    ),
  ],
);

mixin $RoutinesRoute on GoRouteData {
  static RoutinesRoute _fromState(GoRouterState state) => const RoutinesRoute();

  @override
  String get location => GoRouteData.$location('/routines');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $NewRoutineRoute on GoRouteData {
  static NewRoutineRoute _fromState(GoRouterState state) =>
      const NewRoutineRoute();

  @override
  String get location => GoRouteData.$location('/routines/new');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditRoutineRoute on GoRouteData {
  static EditRoutineRoute _fromState(GoRouterState state) =>
      EditRoutineRoute(routineId: state.pathParameters['routineId']!);

  EditRoutineRoute get _self => this as EditRoutineRoute;

  @override
  String get location => GoRouteData.$location(
    '/routines/${Uri.encodeComponent(_self.routineId)}/edit',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $goalsRoute => GoRouteData.$route(
  path: '/goals',
  hasOverriddenOnExit: false,
  factory: $GoalsRoute._fromState,
);

mixin $GoalsRoute on GoRouteData {
  static GoalsRoute _fromState(GoRouterState state) => const GoalsRoute();

  @override
  String get location => GoRouteData.$location('/goals');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute => GoRouteData.$route(
  path: '/search',
  hasOverriddenOnExit: false,
  factory: $SearchRoute._fromState,
);

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aboutRoute => GoRouteData.$route(
  path: '/about',
  hasOverriddenOnExit: false,
  factory: $AboutRoute._fromState,
);

mixin $AboutRoute on GoRouteData {
  static AboutRoute _fromState(GoRouterState state) => const AboutRoute();

  @override
  String get location => GoRouteData.$location('/about');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
