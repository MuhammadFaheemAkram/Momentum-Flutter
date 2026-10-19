import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';

/// Opens the habit form (new, or [habitId]'s), and says what happened on
/// the screen it was opened from: "Added Read 20 pages", "Deleted …".
/// Returns how the form closed, for a caller that must react (Habit detail
/// leaves when its habit is deleted).
Future<HabitFormExit?> openHabitForm(
  BuildContext context, {
  String? habitId,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final exit = habitId == null
      ? await const NewHabitRoute().push<HabitFormExit>(context)
      : await EditHabitRoute(habitId: habitId).push<HabitFormExit>(context);
  final message = switch (exit) {
    HabitSaved(:final habit, created: true) => 'Added ${habit.title}',
    HabitDeleted(:final title) => 'Deleted $title',
    _ => null,
  };
  if (message != null) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
  return exit;
}
