import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/achievement.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';
import 'package:momentum/domain/usecase/backup_use_cases.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';

/// What one run of the background tasks did.
final class BackgroundReport {
  const BackgroundReport({
    required this.badges,
    required this.backup,
    required this.notifications,
  });

  final Result<List<AchievementId>> badges;
  final BackupOutcome backup;
  final Result<NotificationSyncReport> notifications;
}

/// The periodic maintenance, run by the OS in a background isolate (and by
/// Settings → Developer → Run background tasks now):
/// 1. **badges:** record any just earned (a streak can complete through a
///    reminder's "Mark done" while the app is closed);
/// 2. **backup**, when automatic backup is on and a day has passed;
/// 3. **notifications:** plan again, so the seven-day window keeps rolling
///    even if the app isn't opened for days.
///
/// Each step runs whatever the others did: one failing doesn't stop the
/// rest, and each reports its own outcome. Nothing is retried in a loop:
/// the next run tries again.
///
/// When this runs isn't guaranteed: Android's WorkManager defers work in
/// Doze and to batch it with other apps; iOS's BGTaskScheduler runs it when
/// it judges best (often overnight, on a charger), or not at all for an app
/// the user rarely opens. So nothing here is time-critical: the notifications
/// themselves are already scheduled with the OS, days ahead.
@injectable
class RunBackgroundTasksUseCase {
  const RunBackgroundTasksUseCase(
    this._evaluateAchievements,
    this._autoBackup,
    this._syncNotifications,
  );

  final EvaluateAchievementsUseCase _evaluateAchievements;
  final AutoBackupUseCase _autoBackup;
  final SyncNotificationsUseCase _syncNotifications;

  Future<BackgroundReport> call() async {
    final badges = await _evaluateAchievements();
    final backup = await _autoBackup();
    final notifications = await _syncNotifications();
    return BackgroundReport(
      badges: badges,
      backup: backup,
      notifications: notifications,
    );
  }
}
