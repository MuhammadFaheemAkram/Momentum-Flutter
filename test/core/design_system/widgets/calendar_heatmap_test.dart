import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/overviews.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

import '../../../helpers/habit_builders.dart';
import '../../../helpers/pump_app.dart';

void main() {
  final detail = buildHabitDetail(habit(start: oct(1)), [
    done(oct(19)),
    skip(oct(18)),
    done(oct(14)),
  ], today: today);

  Future<List<HeatmapDay>> pump(
    WidgetTester tester, {
    bool canToggle = true,
  }) async {
    final toggled = <HeatmapDay>[];
    tester.usePhoneSurface();
    await tester.pumpThemed(
      SingleChildScrollView(
        child: CalendarHeatmap(
          days: detail.heatmap,
          tone: HabitPalette.tone('green', Brightness.light),
          onToggle: canToggle ? toggled.add : null,
        ),
      ),
    );
    return toggled;
  }

  testWidgets('each day says its date and state', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(tester);

    expect(find.bySemanticsLabel('Mon, 19 Oct: Done'), findsOneWidget);
    expect(find.bySemanticsLabel('Sun, 18 Oct: Skipped'), findsOneWidget);
    expect(find.bySemanticsLabel('Fri, 16 Oct: Missed'), findsOneWidget);
    expect(find.bySemanticsLabel('Wed, 21 Oct: To do'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('the last 30 days are buttons that toggle; older ones are not', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final toggled = await pump(tester);

    expect(
      tester.getSemantics(find.bySemanticsLabel('Fri, 16 Oct: Missed')),
      isSemantics(isButton: true, hasTapAction: true),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Mon, 28 Sep: Nothing due')),
      isSemantics(isButton: false, hasTapAction: false),
    );

    await tester.tap(find.bySemanticsLabel('Fri, 16 Oct: Missed'));
    expect(toggled.single.day, oct(16));
    handle.dispose();
  });

  testWidgets('without a toggle (archived), no day is a button', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, canToggle: false);

    expect(
      tester.getSemantics(find.bySemanticsLabel('Fri, 16 Oct: Missed')),
      isSemantics(isButton: false, hasTapAction: false),
    );
    handle.dispose();
  });

  test('the summary counts each state, never days that asked nothing', () {
    expect(
      CalendarHeatmap.summary(detail.heatmap),
      'Done on 2 days, skipped 1, missed 17',
    );
    expect(
      detail.heatmap.where((d) => d.state == DayState.missed),
      hasLength(17),
    );
  });
}
