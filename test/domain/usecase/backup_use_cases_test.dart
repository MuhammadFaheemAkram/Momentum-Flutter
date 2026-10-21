import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/network/fake_momentum_service.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/usecase/backup_use_cases.dart';

import '../../helpers/data_stack.dart';
import '../../helpers/test_dependencies.dart';
import '../../helpers/user_data_fixtures.dart';

void main() {
  late DataStack stack;

  setUp(() async {
    stack = DataStack();
    await stack.seed(fullUserData());
  });
  tearDown(() => stack.close());

  group('BackUpNowUseCase', () {
    test('sends everything, and saves the receipt\'s time', () async {
      final result = await stack.backUpNow();

      final receipt = (result as Ok<BackupReceipt>).value;
      expect(receipt.habits, 3);
      expect(receipt.logs, 3);
      expect(receipt.receivedAt, demoNow);
      expect(stack.settings.current.lastBackupAt, demoNow);
      final sent = jsonDecode(
        (stack.service as FakeMomentumService).latestBackup!,
      ) as Map<String, dynamic>;
      expect(sent['habits'], hasLength(3));
    });

    test('offline: the failure is returned, and nothing is saved', () async {
      stack.network.failRequests = true;

      final result = await stack.backUpNow();

      expect((result as Err).exception, isA<NetworkException>());
      expect(stack.settings.current.lastBackupAt, isNull);
    });
  });

  group('isBackupDue', () {
    const on = AppSettings(autoBackup: true);

    test('off: never', () {
      expect(isBackupDue(const AppSettings(), demoNow), isFalse);
    });

    test('on, never backed up: now', () {
      expect(isBackupDue(on, demoNow), isTrue);
    });

    test('a day after the last one, not before', () {
      final last = demoNow.subtract(autoBackupInterval);

      expect(isBackupDue(on.copyWith(lastBackupAt: last), demoNow), isTrue);
      expect(
        isBackupDue(
          on.copyWith(lastBackupAt: last.add(const Duration(minutes: 1))),
          demoNow,
        ),
        isFalse,
      );
    });
  });

  group('AutoBackupUseCase', () {
    test('not due: nothing is sent', () async {
      expect(await stack.autoBackup(), isA<BackupNotDue>());
      expect((stack.service as FakeMomentumService).latestBackup, isNull);
    });

    test('due: backs up', () async {
      stack.settings.publish(const AppSettings(autoBackup: true));

      final outcome = await stack.autoBackup();

      expect((outcome as BackupDone).receipt.logs, 3);
    });

    test('failing: reported, with the reason', () async {
      stack.settings.publish(const AppSettings(autoBackup: true));
      stack.network.failRequests = true;

      final outcome = await stack.autoBackup();

      expect(
        (outcome as BackupFailed).message,
        const NetworkException().message,
      );
    });
  });

  test('ResetProgressUseCase: the history goes, the habits stay', () async {
    expect(await stack.resetProgress(), isA<Ok<void>>());

    final data = await stack.userData.readAll();
    expect(data.logs, isEmpty);
    expect(data.routineChecks, isEmpty);
    expect(data.unlocks, isEmpty);
    expect(data.habits, hasLength(3));
  });
}
