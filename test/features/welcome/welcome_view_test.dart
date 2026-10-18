import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/features/welcome/welcome_page.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('each choice reports itself', (tester) async {
    final chosen = <String>[];
    await tester.pumpThemed(
      WelcomeView(
        onExploreDemo: () => chosen.add('demo'),
        onStartEmpty: () => chosen.add('empty'),
      ),
    );

    await tester.tap(find.text('Explore with demo data'));
    await tester.tap(find.text('Start empty'));

    expect(chosen, ['demo', 'empty']);
  });
}
