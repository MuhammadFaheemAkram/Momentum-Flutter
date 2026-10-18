import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/features/about/about_page.dart';
import 'package:momentum/features/achievements/achievements_page.dart';
import 'package:momentum/features/analytics/analytics_page.dart';
import 'package:momentum/features/goals/goals_page.dart';
import 'package:momentum/features/habit_detail/habit_detail_page.dart';
import 'package:momentum/features/habit_form/habit_form_page.dart';
import 'package:momentum/features/habits/habits_page.dart';
import 'package:momentum/features/routine_editor/routine_editor_page.dart';
import 'package:momentum/features/routines/routines_page.dart';
import 'package:momentum/features/search/search_page.dart';
import 'package:momentum/features/settings/settings_page.dart';
import 'package:momentum/features/shell/main_shell.dart';
import 'package:momentum/features/today/today_page.dart';
import 'package:momentum/features/welcome/welcome_page.dart';

part 'app_routes.g.dart';

// Typed routes: every destination is a class, and `go_router_builder`
// generates its path parsing, `location` getter and `go`/`push` helpers. A
// typo or a missing parameter is a compile error instead of a runtime "page
// not found".
//
// The tree has three parts:
// 1. Welcome, shown until the user has started (first launch);
// 2. the tab shell: Today, Habits, Analytics, Achievements, Settings;
// 3. root-level screens, pushed *above* the shell: a habit and its form,
//    and the drawer's destinations (Routines, Goals, Search, About).

// ---------------------------------------------------------------------------
// 1. Welcome

@TypedGoRoute<WelcomeRoute>(path: '/welcome')
class WelcomeRoute extends GoRouteData with $WelcomeRoute {
  const WelcomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WelcomePage();
}

// ---------------------------------------------------------------------------
// 2. The tab shell

/// `StatefulShellRoute` gives every tab its own Navigator and keeps inactive
/// tabs alive in an IndexedStack, so switching tabs preserves each tab's
/// state (a search, a filter, a scroll position).
@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<TodayBranch>(
      routes: [TypedGoRoute<TodayRoute>(path: '/today')],
    ),
    TypedStatefulShellBranch<HabitsBranch>(
      routes: [TypedGoRoute<HabitsRoute>(path: '/habits')],
    ),
    TypedStatefulShellBranch<AnalyticsBranch>(
      routes: [TypedGoRoute<AnalyticsRoute>(path: '/analytics')],
    ),
    TypedStatefulShellBranch<AchievementsBranch>(
      routes: [TypedGoRoute<AchievementsRoute>(path: '/achievements')],
    ),
    TypedStatefulShellBranch<SettingsBranch>(
      routes: [TypedGoRoute<SettingsRoute>(path: '/settings')],
    ),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainShell(navigationShell: navigationShell);
  }
}

// A named navigator key per tab makes each back stack addressable (and
// readable in debugging tools).

class TodayBranch extends StatefulShellBranchData {
  const TodayBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'todayTab');
}

class HabitsBranch extends StatefulShellBranchData {
  const HabitsBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'habitsTab');
}

class AnalyticsBranch extends StatefulShellBranchData {
  const AnalyticsBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'analyticsTab');
}

class AchievementsBranch extends StatefulShellBranchData {
  const AchievementsBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'achievementsTab');
}

class SettingsBranch extends StatefulShellBranchData {
  const SettingsBranch();

  static final GlobalKey<NavigatorState> $navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'settingsTab');
}

class TodayRoute extends GoRouteData with $TodayRoute {
  const TodayRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TodayPage();
}

class HabitsRoute extends GoRouteData with $HabitsRoute {
  const HabitsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HabitsPage();
}

class AnalyticsRoute extends GoRouteData with $AnalyticsRoute {
  const AnalyticsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AnalyticsPage();
}

class AchievementsRoute extends GoRouteData with $AchievementsRoute {
  const AchievementsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AchievementsPage();
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsPage();
}

// ---------------------------------------------------------------------------
// 3. Root-level screens
//
// Declared at the top level, so they live in the *root* Navigator: pushing
// one covers the tab bar, and Back (or the iOS swipe) returns to the tab it
// came from with its state intact. A habit opens from Today, Habits, a
// notification and Search, so one route beats a copy per tab.

/// `/habits/new`: the habit form as a full-screen dialog (it slides up and
/// has a Close button), Material's counterpart of an iOS sheet. Declared
/// before `/habits/:habitId`, or "new" would be read as an id.
@TypedGoRoute<NewHabitRoute>(path: '/habits/new')
class NewHabitRoute extends GoRouteData with $NewHabitRoute {
  const NewHabitRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<void>(
        key: state.pageKey,
        fullscreenDialog: true,
        child: const HabitFormPage(),
      );
}

/// `/habits/:habitId`: a habit's history and stats, with its form as a
/// child, so a link to the form opens with the habit underneath and Close
/// returns to it. (The Habits tab is `/habits`.)
@TypedGoRoute<HabitDetailRoute>(
  path: '/habits/:habitId',
  routes: [TypedGoRoute<EditHabitRoute>(path: 'edit')],
)
class HabitDetailRoute extends GoRouteData with $HabitDetailRoute {
  const HabitDetailRoute({required this.habitId});

  final String habitId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HabitDetailPage(habitId: habitId);
}

/// `/habits/:habitId/edit`: the same form, filled in.
class EditHabitRoute extends GoRouteData with $EditHabitRoute {
  const EditHabitRoute({required this.habitId});

  final String habitId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<void>(
        key: state.pageKey,
        fullscreenDialog: true,
        child: HabitFormPage(habitId: habitId),
      );
}

/// `/routines` (from the drawer), with the editor as children, so Close
/// returns to the list. `new` is declared before `:routineId/edit`.
@TypedGoRoute<RoutinesRoute>(
  path: '/routines',
  routes: [
    TypedGoRoute<NewRoutineRoute>(path: 'new'),
    TypedGoRoute<EditRoutineRoute>(path: ':routineId/edit'),
  ],
)
class RoutinesRoute extends GoRouteData with $RoutinesRoute {
  const RoutinesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RoutinesPage();
}

/// `/routines/new`: the routine editor as a full-screen dialog.
class NewRoutineRoute extends GoRouteData with $NewRoutineRoute {
  const NewRoutineRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<void>(
        key: state.pageKey,
        fullscreenDialog: true,
        child: const RoutineEditorPage(),
      );
}

/// `/routines/:routineId/edit`.
class EditRoutineRoute extends GoRouteData with $EditRoutineRoute {
  const EditRoutineRoute({required this.routineId});

  final String routineId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      MaterialPage<void>(
        key: state.pageKey,
        fullscreenDialog: true,
        child: RoutineEditorPage(routineId: routineId),
      );
}

/// `/goals` (from the drawer).
@TypedGoRoute<GoalsRoute>(path: '/goals')
class GoalsRoute extends GoRouteData with $GoalsRoute {
  const GoalsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const GoalsPage();
}

/// `/search` (from the drawer, and Today's and Habits' app bars).
@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SearchPage();
}

/// `/about` (from the drawer, and Settings).
@TypedGoRoute<AboutRoute>(path: '/about')
class AboutRoute extends GoRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AboutPage();
}
