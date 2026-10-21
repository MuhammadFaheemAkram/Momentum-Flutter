import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/domain/model/planned_notification.dart';

/// A reminder still to ring today: the time and the habit. Opens the habit.
class ReminderRow extends StatelessWidget {
  const ReminderRow({super.key, required this.reminder, required this.onTap});

  final PlannedNotification reminder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final time = DateLabels.time(
      reminder.time,
      use24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
    );
    return ListTile(
      leading: const Icon(Icons.notifications_active_outlined),
      title: Text(reminder.title),
      subtitle: Text('Reminder at $time'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
