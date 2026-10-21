import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/repository/backup_repository.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/domain/repository/user_data_repository.dart';

/// How long an automatic backup lasts before the next is due.
const autoBackupInterval = Duration(hours: 24);

/// Whether the background tasks should back up now: automatic backup is on,
/// and the last one is a day old (or there's none).
bool isBackupDue(AppSettings settings, DateTime now) {
  if (!settings.autoBackup) return false;
  final last = settings.lastBackupAt;
  return last == null || now.difference(last) >= autoBackupInterval;
}

/// Sends everything the user owns to the service, and saves the receipt's
/// time ("Last backup"). A failure is returned, never retried here
/// (correctness rule 12).
@injectable
class BackUpNowUseCase {
  const BackUpNowUseCase(this._userData, this._backups, this._settings);

  final UserDataRepository _userData;
  final BackupRepository _backups;
  final SettingsRepository _settings;

  Future<Result<BackupReceipt>> call() async {
    final Result<BackupReceipt> result;
    try {
      result = await _backups.upload(await _userData.readAll());
    } on Object catch (error, stackTrace) {
      log('Reading the backup failed', error: error, stackTrace: stackTrace);
      return const Err(UnknownException());
    }
    if (result case Ok(value: final receipt)) {
      await _settings.update(
        (s) => s.copyWith(lastBackupAt: receipt.receivedAt),
      );
    }
    return result;
  }
}

/// The background tasks' backup: only when due.
@injectable
class AutoBackupUseCase {
  const AutoBackupUseCase(this._backUpNow, this._settings, this._clock);

  final BackUpNowUseCase _backUpNow;
  final SettingsRepository _settings;
  final Clock _clock;

  Future<BackupOutcome> call() async {
    if (!isBackupDue(_settings.current, _clock.now())) {
      return const BackupNotDue();
    }
    return switch (await _backUpNow()) {
      Ok(:final value) => BackupDone(value),
      Err(:final exception) => BackupFailed(exception.message),
    };
  }
}

/// Clears logs, routine check-offs and badge unlocks in one transaction.
/// Habits, routines, goals and settings stay (correctness rule 11).
@injectable
class ResetProgressUseCase {
  const ResetProgressUseCase(this._userData);

  final UserDataRepository _userData;

  Future<Result<void>> call() => _userData.resetProgress();
}
