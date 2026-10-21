import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/planned_notification.dart';

part 'settings_tools_state.freezed.dart';

/// What Settings is busy with: one at a time.
enum SettingsTask { notifications, backup, reset, backgroundTasks, plan }

@freezed
abstract class SettingsToolsState with _$SettingsToolsState {
  const factory SettingsToolsState({
    /// For "Last backup: Yesterday, 23:04".
    required CalendarDate today,
    SettingsTask? running,

    /// The system said no when notifications were turned on: the card that
    /// leads to the system settings shows.
    @Default(false) bool notificationsDenied,

    /// Settings → Developer → Simulate network failure.
    @Default(false) bool failRequests,

    /// The plan to show in a sheet; [planSerial] opens it once per request.
    NotificationPlanPreview? plan,
    @Default(0) int planSerial,

    /// A one-time SnackBar; [messageSerial] makes each one distinct.
    String? message,
    @Default(0) int messageSerial,
  }) = _SettingsToolsState;
}
