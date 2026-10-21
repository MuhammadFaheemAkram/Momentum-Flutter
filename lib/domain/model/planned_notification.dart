import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

part 'planned_notification.freezed.dart';

enum NotificationKind {
  /// A habit's own reminder, at its time, on a day it's due.
  reminder('Reminder'),

  /// "2 habits left today", while something due is still open.
  nudge('Nudge'),

  /// "4 of 5 done today", at the end of the day.
  summary('Summary');

  const NotificationKind(this.label);

  final String label;
}

/// Where a notification's tap leads.
///
/// It travels as the notification's payload text (`habit:<id>` or
/// `today`), so it survives the app being killed: a tap that launches the
/// app reads it back with [NotificationTarget.parse].
@freezed
sealed class NotificationTarget with _$NotificationTarget {
  const factory NotificationTarget.habit(String habitId) = OpenHabit;

  const factory NotificationTarget.today() = OpenToday;

  const NotificationTarget._();

  /// The target in [payload], or `null` for anything else (a payload from
  /// an older version, or none).
  static NotificationTarget? parse(String? payload) {
    final target = payload?.split(_fingerprintSeparator).first;
    if (target == _today) return const NotificationTarget.today();
    if (target != null && target.startsWith(_habitPrefix)) {
      final id = target.substring(_habitPrefix.length);
      if (id.isNotEmpty) return NotificationTarget.habit(id);
    }
    return null;
  }

  String encode() => switch (this) {
    OpenHabit(:final habitId) => '$_habitPrefix$habitId',
    OpenToday() => _today,
  };

  static const _habitPrefix = 'habit:';
  static const _today = 'today';
}

const _fingerprintSeparator = '#';

/// One notification the app wants on the device: the planner's output.
@freezed
abstract class PlannedNotification with _$PlannedNotification {
  const factory PlannedNotification({
    /// Stable from one plan to the next for the same kind, habit and day
    /// (`notificationId`), so the scheduler can tell what changed.
    required int id,
    required NotificationKind kind,

    /// The user's calendar day and time: "20:00 on Thursday" stays 20:00
    /// local time, across a daylight-saving change too. The scheduler turns
    /// it into an instant in the device's time zone.
    required CalendarDate day,
    required TimeOfDayValue time,
    required String title,
    required String body,
    required NotificationTarget target,

    /// The habit a reminder is for (it gets a "Mark done" action).
    String? habitId,
  }) = _PlannedNotification;

  const PlannedNotification._();

  /// The local wall-clock time it rings.
  DateTime get at =>
      DateTime(day.year, day.month, day.day, time.hour, time.minute);

  /// The payload stored with it: the [target], and the time it rings.
  ///
  /// The device's list of pending notifications gives back an id, a title,
  /// a body and a payload, but not the time. Keeping the time in the
  /// payload lets the scheduler see that a reminder moved from 07:00 to
  /// 07:30 and reschedule it.
  String get payload =>
      '${target.encode()}$_fingerprintSeparator'
      '${day.toIso()}T${time.toHhMm()}';
}

/// A notification already on the device, as the system reports it.
@freezed
abstract class PendingNotification with _$PendingNotification {
  const factory PendingNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) = _PendingNotification;
}

extension PlannedNotificationMatch on PlannedNotification {
  /// Whether [pending] is this notification, unchanged.
  bool matches(PendingNotification pending) =>
      pending.id == id &&
      pending.title == title &&
      pending.body == body &&
      pending.payload == payload;
}

/// What a sync did to the device's notifications.
@freezed
abstract class NotificationSyncReport with _$NotificationSyncReport {
  const factory NotificationSyncReport({
    /// Whether notifications are on (and allowed).
    required bool enabled,

    /// The plan's size.
    @Default(0) int planned,
    @Default(0) int scheduled,
    @Default(0) int cancelled,

    /// Already on the device, unchanged: left alone.
    @Default(0) int kept,

    /// The system no longer allows notifications: the switch turned off.
    @Default(false) bool permissionRevoked,
  }) = _NotificationSyncReport;
}

/// The plan as Settings → Developer shows it.
@freezed
abstract class NotificationPlanPreview with _$NotificationPlanPreview {
  const factory NotificationPlanPreview({
    /// What the planner wants now (planned even while notifications are
    /// off, so it can be inspected).
    required List<PlannedNotification> plan,

    /// How many are pending on the device.
    required int pending,
    required bool enabled,
  }) = _NotificationPlanPreview;
}
