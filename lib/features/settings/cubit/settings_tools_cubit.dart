import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/network/network_simulator.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/domain/usecase/background_use_cases.dart';
import 'package:momentum/domain/usecase/backup_use_cases.dart';
import 'package:momentum/domain/usecase/notification_use_cases.dart';
import 'package:momentum/domain/usecase/settings_use_cases.dart';
import 'package:momentum/features/settings/cubit/settings_tools_state.dart';

/// Settings' actions beyond the appearance: notifications and their
/// permission, backup, reset, and the developer tools. The values
/// themselves are read from the app-wide `SettingsCubit`.
@injectable
class SettingsToolsCubit extends Cubit<SettingsToolsState> {
  SettingsToolsCubit(
    this._setNotificationsEnabled,
    this._openNotificationSettings,
    this._updateNudge,
    this._updateSummary,
    this._updateDefaultReminder,
    this._setAutoBackup,
    this._backUpNow,
    this._resetProgress,
    this._runBackgroundTasks,
    this._previewPlan,
    this._network,
    CalendarClock clock,
  ) : super(
        SettingsToolsState(
          today: clock.today,
          failRequests: _network.failRequests,
        ),
      );

  final SetNotificationsEnabledUseCase _setNotificationsEnabled;
  final OpenNotificationSettingsUseCase _openNotificationSettings;
  final UpdateNudgeUseCase _updateNudge;
  final UpdateSummaryUseCase _updateSummary;
  final UpdateDefaultReminderUseCase _updateDefaultReminder;
  final SetAutoBackupUseCase _setAutoBackup;
  final BackUpNowUseCase _backUpNow;
  final ResetProgressUseCase _resetProgress;
  final RunBackgroundTasksUseCase _runBackgroundTasks;
  final PreviewNotificationPlanUseCase _previewPlan;
  final NetworkSimulator _network;

  /// Turning on asks for permission; denied, it stays off and the card
  /// explains where to allow notifications.
  Future<void> setNotificationsEnabled({required bool enabled}) async {
    if (state.running != null) return;
    emit(state.copyWith(running: SettingsTask.notifications));
    final done = await _setNotificationsEnabled(enabled: enabled);
    if (isClosed) return;
    emit(state.copyWith(running: null, notificationsDenied: enabled && !done));
  }

  Future<void> openNotificationSettings() => _openNotificationSettings();

  Future<void> setNudge({bool? enabled, TimeOfDayValue? time}) =>
      _updateNudge(enabled: enabled, time: time);

  Future<void> setSummary({bool? enabled, TimeOfDayValue? time}) =>
      _updateSummary(enabled: enabled, time: time);

  Future<void> setDefaultReminder(TimeOfDayValue time) =>
      _updateDefaultReminder(time);

  Future<void> setAutoBackup({required bool enabled}) =>
      _setAutoBackup(enabled: enabled);

  Future<void> backUpNow() => _run(SettingsTask.backup, () async {
    return switch (await _backUpNow()) {
      Ok(value: BackupReceipt(:final habits, :final logs)) =>
        'Backed up ${_count(habits, 'habit')}, ${_count(logs, 'log')}',
      Err(:final exception) => exception.message,
    };
  });

  Future<void> resetProgress() => _run(SettingsTask.reset, () async {
    return switch (await _resetProgress()) {
      Ok() => 'Progress reset. Your habits, routines and goals are still here.',
      Err(:final exception) => exception.message,
    };
  });

  /// The same use case the OS runs in the background, here and now.
  Future<void> runBackgroundTasks() =>
      _run(SettingsTask.backgroundTasks, () async {
        final report = await _runBackgroundTasks();
        final parts = [
          switch (report.badges) {
            Ok(value: final badges) when badges.isEmpty => 'no new badges',
            Ok(value: final badges) => _count(badges.length, 'new badge'),
            Err() => "badges couldn't be checked",
          },
          switch (report.backup) {
            BackupNotDue() => 'no backup due',
            BackupDone() => 'backed up',
            BackupFailed() => 'the backup failed',
          },
          switch (report.notifications) {
            Ok(value: final sync) when !sync.enabled => 'notifications off',
            Ok(value: final sync) => _count(
              sync.planned,
              'notification',
              suffix: ' planned',
            ),
            Err() => "notifications couldn't be planned",
          },
        ];
        return 'Background tasks done: ${parts.join(', ')}.';
      });

  Future<void> showPlan() async {
    if (state.running != null) return;
    emit(state.copyWith(running: SettingsTask.plan));
    final plan = await _previewPlan();
    if (isClosed) return;
    emit(
      state.copyWith(
        running: null,
        plan: plan,
        planSerial: state.planSerial + 1,
      ),
    );
  }

  void setFailRequests({required bool enabled}) {
    _network.failRequests = enabled;
    emit(state.copyWith(failRequests: enabled));
  }

  /// Runs [task] (one at a time), then shows the message it returns.
  Future<void> _run(SettingsTask task, Future<String> Function() run) async {
    if (state.running != null) return;
    emit(state.copyWith(running: task));
    final message = await run();
    if (isClosed) return;
    emit(
      state.copyWith(
        running: null,
        message: message,
        messageSerial: state.messageSerial + 1,
      ),
    );
  }

  static String _count(int n, String noun, {String suffix = ''}) =>
      '$n $noun${n == 1 ? '' : 's'}$suffix';
}
