import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_draft.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/repository/habit_repository.dart';

import '../helpers/app_harness.dart';

// Badges and search on the real app, as of Wednesday 21 October 2026.
void main() {
  tearDown(getIt.reset);

  /// The badge watcher waits for writes to settle (300 ms of fake time)
  /// and records on the real event loop: both have to move.
  Future<void> letBadgesSettle(WidgetTester tester, Finder finder) async {
    for (var i = 0; i < 20 && finder.evaluate().isEmpty; i++) {
      await tester.pump(const Duration(milliseconds: 400));
      await tester.settleRealAsync();
    }
    expect(finder, findsWidgets, reason: 'no celebration');
  }

  testWidgets("the first completion earns First step: it's celebrated where "
      'you are, and View shows it', (tester) async {
    await pumpMomentum(
      tester,
      tall: true,
      beforeLaunch: () => tester.runAsync(
        () => getIt<HabitRepository>().createHabit(
          HabitDraft(
            title: 'Stretch',
            category: HabitCategory.fitness,
            color: HabitColor.teal,
            icon: HabitIcon.fitness,
            schedule: const HabitSchedule.daily(),
            startDate: CalendarDate(2026, 10, 21),
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('Mark Stretch done'));
    await letBadgesSettle(tester, find.text('Badge unlocked: First step'));

    await tester.tap(find.text('View'));
    await tester.pumpUntilFound(appBarTitled('Achievements'));
    expect(find.text('1 of 10 unlocked'), findsOneWidget);
    expect(find.text('Unlocked today'), findsOneWidget);
  });

  testWidgets('the demo, loaded from Welcome, earns its badges: celebrated '
      'together, not one by one', (tester) async {
    await pumpMomentum(tester, onboarded: false, tall: true);

    // Loading the demo writes table after table; without the watcher
    // waiting for the writes to settle, each would celebrate its own few.
    await tester.tap(find.text('Explore with demo data'));
    await tester.pumpUntilFound(appBarTitled('Today'));
    await letBadgesSettle(tester, find.textContaining('badges unlocked'));

    expect(find.textContaining('Badge unlocked:'), findsNothing);
  });

  testWidgets('search from Today: a habit found and opened; the search is '
      'remembered', (tester) async {
    await pumpMomentum(tester, withDemo: true, tall: true);

    await tester.tapAndSettle(find.byTooltip('Search'));
    await tester.enterText(find.byType(TextField), 'read');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpUntilFound(find.text('Read 20 pages'));
    expect(find.text('Habits (1)'), findsOneWidget);
    expect(find.text('Goals (1)'), findsOneWidget);

    await tester.tap(find.text('Read 20 pages'));
    await tester.pumpUntilFound(find.text('Last 12 weeks'));
    await tester.tapAndSettle(find.byTooltip('Back'));
    await tester.tapAndSettle(find.byTooltip('Clear search'));

    expect(find.text('Recent searches'), findsOneWidget);
    expect(find.text('read'), findsOneWidget);
  });
}
