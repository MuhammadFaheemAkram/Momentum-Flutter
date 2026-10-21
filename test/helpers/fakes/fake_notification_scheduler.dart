import 'dart:async';

import 'package:momentum/domain/model/planned_notification.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';

/// The device's notifications in memory: what's pending, the permission,
/// and a log of every call, in order (`schedule 123`, `cancel 45`,
/// `cancelAll`, `request`, `openSettings`).
///
/// [tap] and [chooseMarkDone] play the user's side.
class FakeNotificationScheduler
    implements NotificationScheduler, NotificationInteractions {
  FakeNotificationScheduler({
    this.permitted = false,
    this.grantsWhenAsked = true,
    this.launch,
  });

  /// Whether notifications are allowed now.
  bool permitted;

  /// What the system prompt answers.
  bool grantsWhenAsked;

  /// The tap that launched the app.
  NotificationTarget? launch;

  final pendingById = <int, PendingNotification>{};
  final scheduled = <int, PlannedNotification>{};
  final calls = <String>[];
  final _interactions = StreamController<NotificationInteraction>.broadcast(
    sync: true,
  );

  void tap(NotificationTarget target) =>
      _interactions.add(NotificationOpened(target));

  void chooseMarkDone(String habitId) =>
      _interactions.add(MarkDoneChosen(habitId));

  @override
  Future<bool> hasPermission() async => permitted;

  @override
  Future<bool> requestPermission() async {
    calls.add('request');
    if (grantsWhenAsked) permitted = true;
    return permitted;
  }

  @override
  Future<List<PendingNotification>> pending() async => [...pendingById.values];

  @override
  Future<void> schedule(PlannedNotification notification) async {
    calls.add('schedule ${notification.id}');
    scheduled[notification.id] = notification;
    pendingById[notification.id] = PendingNotification(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      payload: notification.payload,
    );
  }

  @override
  Future<void> cancel(int id) async {
    calls.add('cancel $id');
    scheduled.remove(id);
    pendingById.remove(id);
  }

  @override
  Future<void> cancelAll() async {
    calls.add('cancelAll');
    scheduled.clear();
    pendingById.clear();
  }

  @override
  Future<void> openSystemSettings() async => calls.add('openSettings');

  @override
  Future<NotificationTarget?> launchTarget() async => launch;

  @override
  Stream<NotificationInteraction> get interactions => _interactions.stream;
}
