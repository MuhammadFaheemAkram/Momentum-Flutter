import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/goals.dart';
import 'package:momentum/domain/calculation/routines.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/routine.dart';

import '../../../helpers/habit_builders.dart';
import '../../../helpers/pump_app.dart';

void main() {
  final progress = routinesToday(
    [routine()],
    [RoutineCheck(itemId: 'r-b', day: today)],
    today: today,
  ).single;

  testWidgets('a routine card: its steps in order, done ones checked and '
      'crossed out', (tester) async {
    final toggled = <(String, bool)>[];
    await tester.pumpThemed(
      RoutineCard(
        progress: progress,
        onToggle: (item, {required checked}) => toggled.add((item.id, checked)),
        onEdit: () {},
      ),
    );

    expect(find.text('Morning · 1 / 3'), findsOneWidget);
    final checks = tester.widgetList<CheckboxListTile>(
      find.byType(CheckboxListTile),
    );
    expect([for (final c in checks) c.value], [false, true, false]);
    final done = tester.widget<Text>(find.text('Step b'));
    expect(done.style?.decoration, TextDecoration.lineThrough);

    await tester.tap(find.text('Step a'));
    await tester.tap(find.text('Step b'));
    expect(toggled, [('r-a', true), ('r-b', false)]);
  });

  testWidgets('a routine named after its time says it once', (tester) async {
    await tester.pumpThemed(
      RoutineCard(
        progress: RoutineProgress(
          routine: routine().copyWith(title: 'Morning'),
          checkedItemIds: const {},
        ),
        onToggle: (_, {required checked}) {},
        onEdit: () {},
      ),
    );

    expect(find.text('0 / 3'), findsOneWidget);
  });

  testWidgets("Today's routine tile: its count, or Done", (tester) async {
    await tester.pumpThemed(
      RoutineSummaryTile(
        progress: RoutineProgress(
          routine: routine(items: ['a']),
          checkedItemIds: const {'r-a'},
        ),
        onTap: () {},
      ),
    );

    expect(find.text('Done'), findsOneWidget);
  });

  testWidgets('a goal card: its count, what it counts, when it resets', (
    tester,
  ) async {
    final histories = [
      history(habit(id: 'read'), [done(today, id: 'read')]),
    ];
    await tester.pumpThemed(
      Column(
        children: [
          GoalCard(
            progress: goalProgress(goal(), histories, today: today),
            today: today,
          ),
          GoalCard(
            progress: goalProgress(
              goal(id: 'one', scope: const GoalScope.habit('read'), target: 1),
              histories,
              today: today,
            ),
            today: today,
          ),
        ],
      ),
    );

    expect(find.text('1 of 5 this week'), findsOneWidget);
    expect(find.text('All habits · Resets Monday'), findsOneWidget);
    // Met: said in words, with a check.
    expect(find.text('Done this week · Resets Monday'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}
