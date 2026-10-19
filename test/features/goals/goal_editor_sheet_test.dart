import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/features/goals/widgets/goal_editor_sheet.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

void main() {
  final read = habit(id: 'read').copyWith(title: 'Read');
  final old = habit(
    id: 'old',
    archivedAt: DateTime.utc(2026, 10),
  ).copyWith(title: 'Old habit');

  /// Opens the sheet over a button; [_Opened.result] is what it popped with.
  Future<_Opened> open(WidgetTester tester, {Goal? existing}) async {
    final opened = _Opened();
    tester.useTallPhoneSurface();
    await tester.pumpThemed(
      Builder(
        builder: (context) => TextButton(
          onPressed: () async => opened.result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) =>
                GoalEditorSheet(habits: [read, old], existing: existing),
          ),
          child: const Text('open'),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    return opened;
  }

  testWidgets('a new goal: all habits, weekly, saved with its choices', (
    tester,
  ) async {
    final opened = await open(tester);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Lots');
    await tester.enterText(
      find.widgetWithText(TextField, 'Completions this week'),
      '25',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(
      opened.result,
      isA<SaveGoalResult>().having(
        (r) => r.draft,
        'draft',
        const GoalDraft(
          title: 'Lots',
          scope: GoalScope.allHabits(),
          period: GoalPeriod.weekly,
          target: 25,
        ),
      ),
    );
  });

  testWidgets('one habit: only active habits are offered, and one must be '
      'picked', (tester) async {
    await open(tester);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Read more');
    await tester.tap(find.text('One habit'));
    await tester.pumpAndSettle();
    expect(find.text('Read'), findsOneWidget);
    expect(find.text('Old habit'), findsNothing);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Pick the habit it counts'), findsOneWidget);
  });

  testWidgets('a bad target says so', (tester) async {
    await open(tester);

    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Lots');
    await tester.enterText(
      find.widgetWithText(TextField, 'Completions this week'),
      '500',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Pick a target from 1 to 200'), findsOneWidget);
  });

  testWidgets('editing a goal on a habit archived since keeps the habit', (
    tester,
  ) async {
    await open(tester, existing: goal(scope: const GoalScope.habit('old')));

    expect(find.text('Edit goal'), findsOneWidget);
    expect(find.text('Old habit'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });
}

class _Opened {
  GoalEditorResult? result;
}
