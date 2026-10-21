import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as fln;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// The device's notifications, with `flutter_local_notifications`: the
/// planned notifications, their "Mark done" action, and taps.
///
/// - **One notification per planned time**, not repeating ones: the plan
///   already says which days each habit is due (see `planNotifications`).
///   Each is scheduled in the device's time zone, looked up again before
///   every sync, so a trip across zones keeps "07:30" at 07:30 local.
/// - **Inexact on Android:** a habit reminder doesn't need the minute, and
///   exact alarms need a special permission since Android 14. Scheduled
///   notifications survive a reboot through the plugin's boot receiver (in
///   the manifest).
/// - **Two channels** on Android, so the user can silence the nudge and the
///   summary but keep their reminders.
/// - **"Mark done"** is a notification action that doesn't open the app:
///   an iOS category registered at initialization, an Android action on the
///   reminder. The plugin runs it in a background isolate
///   ([onBackgroundAction], a top-level function).
///
/// Not injectable itself: `AppModule` and the background graph each build
/// one with the background entry point.
class LocalNotifications
    implements NotificationScheduler, NotificationInteractions {
  LocalNotifications({required this.onBackgroundAction});

  /// Runs a "Mark done" chosen while the app isn't in the foreground.
  /// Must be a top-level or static function marked
  /// `@pragma('vm:entry-point')`.
  final void Function(fln.NotificationResponse response) onBackgroundAction;

  static const _reminderCategory = 'habit_reminder';

  final _plugin = fln.FlutterLocalNotificationsPlugin();
  final _interactions = StreamController<NotificationInteraction>.broadcast();
  Future<void>? _initialized;

  /// Sets the plugin up once. Permission isn't requested here: only when
  /// the user turns notifications on, so the system prompt has a reason.
  Future<void> _initialize() => _initialized ??= () async {
    tz_data.initializeTimeZones();
    await _plugin.initialize(
      settings: fln.InitializationSettings(
        android: const fln.AndroidInitializationSettings('ic_notification'),
        iOS: fln.DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          notificationCategories: [
            fln.DarwinNotificationCategory(
              _reminderCategory,
              actions: [
                fln.DarwinNotificationAction.plain(
                  markDoneActionId,
                  'Mark done',
                ),
              ],
            ),
          ],
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final interaction = NotificationInteraction.of(
          actionId: response.actionId,
          payload: response.payload,
        );
        if (interaction != null) _interactions.add(interaction);
      },
      onDidReceiveBackgroundNotificationResponse: onBackgroundAction,
    );
  }();

  fln.AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        fln.AndroidFlutterLocalNotificationsPlugin
      >();

  fln.IOSFlutterLocalNotificationsPlugin? get _ios => _plugin
      .resolvePlatformSpecificImplementation<
        fln.IOSFlutterLocalNotificationsPlugin
      >();

  @override
  Stream<NotificationInteraction> get interactions {
    unawaited(_initialize());
    return _interactions.stream;
  }

  @override
  Future<NotificationTarget?> launchTarget() async {
    await _initialize();
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details == null || !details.didNotificationLaunchApp) return null;
    final response = details.notificationResponse;
    return switch (NotificationInteraction.of(
      actionId: response?.actionId,
      payload: response?.payload,
    )) {
      NotificationOpened(:final target) => target,
      _ => null,
    };
  }

  @override
  Future<bool> hasPermission() async {
    await _initialize();
    final android = _android;
    if (android != null) {
      return await android.areNotificationsEnabled() ?? false;
    }
    final options = await _ios?.checkPermissions();
    return options?.isEnabled ?? false;
  }

  @override
  Future<bool> requestPermission() async {
    await _initialize();
    final android = _android;
    if (android != null) {
      // Android 13+ shows the prompt (twice at most); older versions allow
      // by default, unless the user turned notifications off.
      await android.requestNotificationsPermission();
      return hasPermission();
    }
    return await _ios?.requestPermissions(alert: true, sound: true) ?? false;
  }

  @override
  Future<List<PendingNotification>> pending() async {
    await _initialize();
    return [
      for (final request in await _plugin.pendingNotificationRequests())
        PendingNotification(
          id: request.id,
          title: request.title,
          body: request.body,
          payload: request.payload,
        ),
    ];
  }

  @override
  Future<void> schedule(PlannedNotification notification) async {
    await _initialize();
    await _useDeviceZone();
    final day = notification.day;
    final time = notification.time;
    // The wall-clock time in today's rules for the zone: 20:00 stays 20:00
    // across a daylight-saving change.
    final at = tz.TZDateTime(
      tz.local,
      day.year,
      day.month,
      day.day,
      time.hour,
      time.minute,
    );
    // The plan dropped past times, but a sync can straddle the minute.
    if (!at.isAfter(tz.TZDateTime.now(tz.local))) return;
    await _plugin.zonedSchedule(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      payload: notification.payload,
      scheduledDate: at,
      notificationDetails: _details(notification),
      androidScheduleMode: fln.AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> cancel(int id) async {
    await _initialize();
    await _plugin.cancel(id: id);
  }

  @override
  Future<void> cancelAll() async {
    await _initialize();
    await _plugin.cancelAllPendingNotifications();
  }

  @override
  Future<void> openSystemSettings() async {
    await _initialize();
    await _plugin.openAppNotificationSettings();
  }

  static fln.NotificationDetails _details(PlannedNotification notification) {
    if (notification.kind == NotificationKind.reminder) {
      return const fln.NotificationDetails(
        android: fln.AndroidNotificationDetails(
          'habit_reminders',
          'Habit reminders',
          channelDescription: "Each habit's reminder, on the days it's due",
          actions: [
            fln.AndroidNotificationAction(markDoneActionId, 'Mark done'),
          ],
        ),
        iOS: fln.DarwinNotificationDetails(
          categoryIdentifier: _reminderCategory,
        ),
      );
    }
    return const fln.NotificationDetails(
      android: fln.AndroidNotificationDetails(
        'daily_check_ins',
        'Nudge and summary',
        channelDescription:
            'Habits still open in the evening, and how the day went',
      ),
      iOS: fln.DarwinNotificationDetails(),
    );
  }

  /// Follows the device's time zone, looked up at most once a minute (a
  /// sync schedules many notifications in a row).
  Future<void> _useDeviceZone() async {
    final now = DateTime.now();
    final checked = _zoneCheckedAt;
    if (checked != null && now.difference(checked).inMinutes < 1) return;
    final zone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(_location(zone.identifier));
    _zoneCheckedAt = now;
  }

  DateTime? _zoneCheckedAt;

  /// The zone's rules, or UTC if this database doesn't know the name (a
  /// newer zone than the bundled data).
  static tz.Location _location(String identifier) {
    try {
      return tz.getLocation(identifier);
    } on tz.LocationNotFoundException {
      return tz.UTC;
    }
  }
}
