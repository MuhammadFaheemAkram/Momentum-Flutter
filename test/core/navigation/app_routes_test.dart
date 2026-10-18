import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/core/navigation/first_launch_redirect.dart';

void main() {
  test('tab routes have their own paths', () {
    expect(const TodayRoute().location, '/today');
    expect(const HabitsRoute().location, '/habits');
    expect(const AnalyticsRoute().location, '/analytics');
    expect(const AchievementsRoute().location, '/achievements');
    expect(const SettingsRoute().location, '/settings');
  });

  test('screens above the tabs build their locations from typed data', () {
    expect(const NewHabitRoute().location, '/habits/new');
    expect(const HabitDetailRoute(habitId: 'h1').location, '/habits/h1');
    expect(const EditHabitRoute(habitId: 'h1').location, '/habits/h1/edit');
    expect(const RoutinesRoute().location, '/routines');
    expect(const NewRoutineRoute().location, '/routines/new');
    expect(
      const EditRoutineRoute(routineId: 'r1').location,
      '/routines/r1/edit',
    );
    expect(const GoalsRoute().location, '/goals');
    expect(const SearchRoute().location, '/search');
    expect(const AboutRoute().location, '/about');
  });

  test("the gate's constants match the typed routes", () {
    expect(const WelcomeRoute().location, welcomePath);
    expect(const TodayRoute().location, todayPath);
  });
}
