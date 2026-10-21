import 'package:momentum/domain/model/planned_notification.dart';

/// The device's notifications. An interface, so the use cases are tested
/// against a fake and no plugin is reachable from a Cubit test.
abstract interface class NotificationScheduler {
  /// Whether notifications are allowed now.
  Future<bool> hasPermission();

  /// Asks for permission if the system still can (Android 13+, iOS); `true`
  /// if notifications are allowed afterwards. Once denied, only the system
  /// settings can change it: the app can't ask twice.
  Future<bool> requestPermission();

  /// What's scheduled and hasn't rung yet.
  Future<List<PendingNotification>> pending();

  /// Schedules [notification] at its local time, replacing any with its id.
  Future<void> schedule(PlannedNotification notification);

  Future<void> cancel(int id);

  Future<void> cancelAll();

  /// The app's notification settings, where a denied permission can be
  /// changed.
  Future<void> openSystemSettings();
}

/// The id of a reminder's "Mark done" action.
const markDoneActionId = 'mark_done';

/// What the user did with a notification.
sealed class NotificationInteraction {
  const NotificationInteraction();

  /// The interaction a notification's [payload] and the chosen [actionId]
  /// stand for (`null` actionId: the notification itself was tapped), or
  /// `null` for one that isn't the app's.
  static NotificationInteraction? of({String? actionId, String? payload}) {
    final target = NotificationTarget.parse(payload);
    if (actionId == markDoneActionId) {
      return target is OpenHabit ? MarkDoneChosen(target.habitId) : null;
    }
    if (actionId != null && actionId.isNotEmpty) return null;
    return target == null ? null : NotificationOpened(target);
  }
}

/// Tapped: open the app on [target].
final class NotificationOpened extends NotificationInteraction {
  const NotificationOpened(this.target);

  final NotificationTarget target;
}

/// "Mark done" on a habit's reminder, without opening the app.
final class MarkDoneChosen extends NotificationInteraction {
  const MarkDoneChosen(this.habitId);

  final String habitId;
}

/// Notification taps and actions that reach the running app.
abstract interface class NotificationInteractions {
  /// The tap that launched the app (a cold start), if any.
  Future<NotificationTarget?> launchTarget();

  /// Taps and actions while the app runs (a warm start).
  Stream<NotificationInteraction> get interactions;
}
