import 'dart:async';
import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/common/first_value.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/common/settled_stream.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/calculation/notification_plan.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:stream_transform/stream_transform.dart';

/// The plan for now, from the current habits, logs and [settings].
Future<List<PlannedNotification>> _plan(
  HabitRepository habits,
  HabitLogRepository logs,
  AppSettings settings,
  Clock clock,
) async {
  final (allHabits, allLogs) = (
    await habits.watchHabits().firstValue,
    await logs.watchLogs().firstValue,
  );
  return planNotifications(
    now: clock.now(),
    histories: [for (final habit in allHabits) HabitHistory(habit, allLogs)],
    settings: settings,
  );
}

/// Makes the device's notifications match the plan: plan → compare with
/// what's pending → cancel what's stale, schedule what's new or changed,
/// leave the rest.
///
/// - **Off** (or permission revoked): everything is cancelled. A revoked
///   permission also turns the switch off, so it never reads "on" while
///   nothing can ring (correctness rule 8).
/// - **One sync at a time:** calls queue up, so two syncs never interleave
///   their cancels and schedules. A singleton, so the app's watcher, a
///   resume and Settings share the queue.
@lazySingleton
class SyncNotificationsUseCase {
  SyncNotificationsUseCase(
    this._settings,
    this._habits,
    this._logs,
    this._scheduler,
    this._clock,
  );

  final SettingsRepository _settings;
  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final NotificationScheduler _scheduler;
  final Clock _clock;

  Future<void> _queue = Future.value();

  Future<Result<NotificationSyncReport>> call() {
    final run = _queue.then((_) => _sync());
    _queue = run;
    return run;
  }

  Future<Result<NotificationSyncReport>> _sync() async {
    try {
      var settings = _settings.current;
      var revoked = false;
      if (settings.notificationsEnabled && !await _scheduler.hasPermission()) {
        await _settings.update((s) => s.copyWith(notificationsEnabled: false));
        settings = _settings.current;
        revoked = true;
      }
      final pending = await _scheduler.pending();
      if (!settings.notificationsEnabled) {
        if (pending.isNotEmpty) await _scheduler.cancelAll();
        return Ok(
          NotificationSyncReport(
            enabled: false,
            cancelled: pending.length,
            permissionRevoked: revoked,
          ),
        );
      }
      final plan = await _plan(_habits, _logs, settings, _clock);
      final wanted = {for (final n in plan) n.id};
      final pendingById = {for (final p in pending) p.id: p};
      var cancelled = 0;
      for (final stale in pending.where((p) => !wanted.contains(p.id))) {
        await _scheduler.cancel(stale.id);
        cancelled++;
      }
      var scheduled = 0;
      for (final notification in plan) {
        final current = pendingById[notification.id];
        if (current != null && notification.matches(current)) continue;
        // Scheduling an id again replaces it: no cancel first.
        await _scheduler.schedule(notification);
        scheduled++;
      }
      return Ok(
        NotificationSyncReport(
          enabled: true,
          planned: plan.length,
          scheduled: scheduled,
          cancelled: cancelled,
          kept: plan.length - scheduled,
        ),
      );
    } on Object catch (error, stackTrace) {
      log('Syncing notifications failed', error: error, stackTrace: stackTrace);
      return const Err(UnknownException());
    }
  }
}

/// While the app runs: the plan applied again after every change to the
/// habits, their logs or the settings, and at midnight (the clock first,
/// conventions §11.61), so the seven-day window keeps rolling.
///
/// Debounced ([settle]), like the badge watcher: a write that touches many
/// rows (the demo, a reset) syncs once, when it settles. Each sync runs to
/// the end before the next (`asyncMap`).
@injectable
class KeepNotificationsInSyncUseCase {
  const KeepNotificationsInSyncUseCase(
    this._sync,
    this._habits,
    this._logs,
    this._settings,
    this._clock, {
    @ignoreParam this.settle = const Duration(milliseconds: 300),
  });

  final SyncNotificationsUseCase _sync;
  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final SettingsRepository _settings;
  final CalendarClock _clock;
  final Duration settle;

  Stream<Result<NotificationSyncReport>> call() {
    final data = _habits
        .watchHabits()
        .combineLatest(_logs.watchLogs(), (habits, logs) => (habits, logs))
        .combineLatest(_settings.watch(), (data, settings) => (data, settings));
    return _clock
        .watchToday()
        .combineLatest(data, (today, data) => (today, data))
        .settled(settle)
        .asyncMap((_) => _sync());
  }
}

/// Turns notifications on (asking for permission) or off. `true` when the
/// switch ends up where the user put it; `false` when permission was
/// denied, and it stays off.
@injectable
class SetNotificationsEnabledUseCase {
  const SetNotificationsEnabledUseCase(this._settings, this._scheduler);

  final SettingsRepository _settings;
  final NotificationScheduler _scheduler;

  Future<bool> call({required bool enabled}) async {
    if (enabled) {
      try {
        if (!await _scheduler.requestPermission()) return false;
      } on Object catch (error, stackTrace) {
        log(
          'Asking for permission failed',
          error: error,
          stackTrace: stackTrace,
        );
        return false;
      }
    }
    await _settings.update((s) => s.copyWith(notificationsEnabled: enabled));
    return true;
  }
}

/// The plan as it stands, and what the device holds: Settings → Developer.
@injectable
class PreviewNotificationPlanUseCase {
  const PreviewNotificationPlanUseCase(
    this._settings,
    this._habits,
    this._logs,
    this._scheduler,
    this._clock,
  );

  final SettingsRepository _settings;
  final HabitRepository _habits;
  final HabitLogRepository _logs;
  final NotificationScheduler _scheduler;
  final Clock _clock;

  Future<NotificationPlanPreview> call() async {
    final settings = _settings.current;
    return NotificationPlanPreview(
      plan: await _plan(_habits, _logs, settings, _clock),
      pending: (await _scheduler.pending()).length,
      enabled: settings.notificationsEnabled,
    );
  }
}

/// Opens the system settings, where a denied permission can be changed.
@injectable
class OpenNotificationSettingsUseCase {
  const OpenNotificationSettingsUseCase(this._scheduler);

  final NotificationScheduler _scheduler;

  Future<void> call() => _scheduler.openSystemSettings();
}
