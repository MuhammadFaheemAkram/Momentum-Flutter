import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/user_data.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/habit_builders.dart';

void main() {
  late DataStack stack;

  setUp(() => stack = DataStack());
  tearDown(() => stack.close());

  List<AchievementId> recorded(Result<List<AchievementId>> result) =>
      (result as Ok<List<AchievementId>>).value;

  test('evaluating records what is earned, once', () async {
    await stack.seed(
      UserData(
        habits: [habit(id: 'read')],
        logs: [done(oct(20), id: 'read')],
      ),
    );

    expect(recorded(await stack.evaluateAchievements()), [
      AchievementId.firstStep,
    ]);
    expect(recorded(await stack.evaluateAchievements()), isEmpty);
  });

  test('an unlock stays after the history that earned it is undone', () async {
    await stack.seed(
      UserData(
        habits: [habit(id: 'read')],
        logs: [done(today, id: 'read')],
      ),
    );
    await stack.evaluateAchievements();

    await stack.clearDay('read');

    final statuses = (await stack.watchAchievements().first).statuses;
    final first = statuses.singleWhere((s) => s.id == AchievementId.firstStep);
    expect(first.isUnlocked, isTrue);
    expect(first.unlock!.unlockedOn, today);
    expect(first.progress.current, 0);
  });

  test(
    'while watched, a check-in that earns a badge records it and says so',
    () async {
      await stack.seed(UserData(habits: [habit(id: 'read')]));
      final celebrated = <List<AchievementId>>[];
      final subscription = stack.watchNewAchievements().listen(celebrated.add);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(celebrated, isEmpty);

      await stack.addCheckIn('read');
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await subscription.cancel();

      expect(celebrated, [
        [AchievementId.firstStep],
      ]);
    },
  );

  test('search finds badges by their title or description', () async {
    final results = await stack.watchSearchResults('streak').first;

    expect(results.achievements, [
      AchievementId.streak7,
      AchievementId.streak30,
    ]);
    expect((await stack.watchSearchResults('morning').first).achievements, [
      AchievementId.earlyBird,
    ]);
  });
}
