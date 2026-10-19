import 'package:material_ui/material_ui.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_log.dart';

/// How to put a day back after an action: its log before, or none.
class DayRestore {
  const DayRestore({
    required this.habitId,
    required this.day,
    required this.previous,
  });

  final String habitId;
  final CalendarDate day;
  final HabitLog? previous;
}

/// A one-time message after an action on a habit, with an Undo when the
/// action can be undone ("Skipped Morning run today · Undo").
class HabitNotice {
  const HabitNotice(this.message, {this.restore, this.unarchive});

  final String message;
  final DayRestore? restore;

  /// The habit to bring back, after "Archived …".
  final String? unarchive;

  bool get canUndo => restore != null || unarchive != null;
}

/// Shows [notice] as a SnackBar; Undo calls [onUndo].
void showHabitNotice(
  BuildContext context,
  HabitNotice notice, {
  required VoidCallback onUndo,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(notice.message),
        action: notice.canUndo
            ? SnackBarAction(label: 'Undo', onPressed: onUndo)
            : null,
      ),
    );
}
