import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/features/shell/app_navigation_drawer.dart';

import '../../helpers/pump_app.dart';

void main() {
  Future<List<DrawerDestination>> pumpDrawer(
    WidgetTester tester, {
    int currentTab = 0,
  }) async {
    final selected = <DrawerDestination>[];
    tester.usePhoneSurface();
    await tester.pumpThemed(
      AppNavigationDrawer(currentTab: currentTab, onSelected: selected.add),
    );
    return selected;
  }

  List<String> labels(WidgetTester tester) => [
    for (final tile in tester.widgetList<ListTile>(find.byType(ListTile)))
      (tile.title! as Text).data!,
  ];

  testWidgets('the tabs, then the screens, then About', (tester) async {
    await pumpDrawer(tester);

    expect(labels(tester), [
      'Today',
      'Habits',
      'Analytics',
      'Achievements',
      'Settings',
      'Routines',
      'Goals',
      'Search',
      'About',
    ]);
  });

  testWidgets('only the current tab is selected', (tester) async {
    await pumpDrawer(tester, currentTab: 2);

    final selected = [
      for (final tile in tester.widgetList<ListTile>(find.byType(ListTile)))
        if (tile.selected) (tile.title! as Text).data,
    ];
    expect(selected, ['Analytics']);
  });

  testWidgets('each item reports where it leads', (tester) async {
    final selected = await pumpDrawer(tester);

    await tester.tap(find.text('Achievements'));
    await tester.tap(find.text('Routines'));
    await tester.tap(find.text('About'));

    expect(selected, [
      isA<TabDestination>().having((d) => d.index, 'index', 3),
      ScreenDestination.routines,
      ScreenDestination.about,
    ]);
  });

  test('the tab bar shortens only what would break', () {
    expect(
      [for (final tab in AppTab.values) tab.barLabel],
      ['Today', 'Habits', 'Analytics', 'Badges', 'Settings'],
    );
    expect(AppTab.achievements.label, 'Achievements');
  });

  testWidgets('at large text it widens, so long labels keep whole words', (
    tester,
  ) async {
    await pumpDrawer(tester);
    expect(tester.getSize(find.byType(Drawer)).width, 304);

    // AX3 on iOS, about 235 %. (The test font's square glyphs make the
    // words themselves no measure: the width is what changes.)
    tester.platformDispatcher.textScaleFactorTestValue = 2.35;
    addTearDown(tester.platformDispatcher.clearAllTestValues);
    await pumpDrawer(tester);

    expect(tester.getSize(find.byType(Drawer)).width, closeTo(390 * 0.9, 0.01));
  });
}
