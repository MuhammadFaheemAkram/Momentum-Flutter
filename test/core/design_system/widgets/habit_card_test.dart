import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_log.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

import '../../../helpers/habit_builders.dart';
import '../../../helpers/pump_app.dart';

void main() {
  HabitToday itemOf(Habit h, [List<HabitLog> logs = const []]) =>
      habitToday(history(h, logs), today: today);

  Future<List<String>> pumpCard(
    WidgetTester tester,
    HabitToday item, {
    bool withActions = true,
  }) async {
    final calls = <String>[];
    await tester.pumpThemed(
      Material(
        child: HabitCard(
          item: item,
          today: today,
          onOpen: () => calls.add('open'),
          onCheckIn: () => calls.add('check'),
          onUndo: () => calls.add('undo'),
          actions: withActions
              ? [HabitAction('Skip today', Icons.redo, () => calls.add('skip'))]
              : const [],
        ),
      ),
    );
    return calls;
  }

  testWidgets('a once-a-day habit: name, schedule, state in words, and a '
      'check button', (tester) async {
    final calls = await pumpCard(
      tester,
      itemOf(habit(schedule: monWedFri), doneEvery(oct(19), oct(19))),
    );

    expect(find.text('Habit h'), findsOneWidget);
    expect(find.text('Mon · Wed · Fri'), findsOneWidget);
    expect(find.text('To do today'), findsOneWidget);
    expect(find.text('1-day streak'), findsOneWidget);

    await tester.tap(find.byTooltip('Mark Habit h done'));
    await tester.tap(find.text('Habit h'));
    expect(calls, ['check', 'open']);
  });

  testWidgets('done, its button undoes', (tester) async {
    final calls = await pumpCard(tester, itemOf(habit(), [done(today)]));

    expect(find.text('Done'), findsOneWidget);
    await tester.tap(find.byTooltip('Mark Habit h not done'));
    expect(calls, ['undo']);
  });

  testWidgets('a counted habit shows its count and a +1 button', (
    tester,
  ) async {
    final calls = await pumpCard(
      tester,
      itemOf(habit(target: 8), [done(today, count: 3)]),
    );

    expect(find.text('3 / 8 today'), findsOneWidget);
    expect(find.byTooltip('Mark Habit h done'), findsNothing);
    await tester.tap(find.byTooltip('Add one to Habit h'));
    expect(calls, ['check']);
  });

  testWidgets('skipped, archived, not started: each says so', (tester) async {
    await pumpCard(tester, itemOf(habit(), [skip(today)]));
    expect(find.text('Skipped today'), findsOneWidget);

    await pumpCard(tester, itemOf(habit(archivedAt: DateTime.utc(2026, 10))));
    expect(find.text('Archived'), findsOneWidget);

    await pumpCard(tester, itemOf(habit(start: oct(25))));
    expect(find.text('Starts Sun, 25 Oct'), findsOneWidget);
  });

  testWidgets('its menu lists the actions', (tester) async {
    final calls = await pumpCard(tester, itemOf(habit()));

    await tester.tap(find.byTooltip('More for Habit h'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip today'));
    await tester.pumpAndSettle();

    expect(calls, ['skip']);
  });

  testWidgets('a screen reader hears the card as one button', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpCard(tester, itemOf(habit()), withActions: false);

    expect(
      tester.getSemantics(find.text('Habit h')),
      isSemantics(
        label: 'Habit h\nDaily\nTo do today',
        isButton: true,
        hasTapAction: true,
      ),
    );
    handle.dispose();
  });

  testWidgets('at large text, the buttons go under the text', (tester) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearAllTestValues);
    tester.usePhoneSurface();
    await pumpCard(tester, itemOf(habit()));

    final text = tester.getBottomLeft(find.text('To do today'));
    final button = tester.getTopLeft(find.byTooltip('Mark Habit h done'));
    expect(button.dy, greaterThan(text.dy));
  });
}
