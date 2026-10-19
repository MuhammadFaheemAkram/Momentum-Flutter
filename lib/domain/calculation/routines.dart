import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/routine.dart';

/// Each routine with the items checked off on [today], in the order of the
/// day (morning, afternoon, evening, any time: `RoutineTime`'s declared
/// order), then the user's order.
List<RoutineProgress> routinesToday(
  List<Routine> routines,
  List<RoutineCheck> checks, {
  required CalendarDate today,
}) {
  final checkedToday = {
    for (final check in checks)
      if (check.day == today) check.itemId,
  };
  final ordered = [...routines]
    ..sort((a, b) {
      final byTime = a.time.index.compareTo(b.time.index);
      return byTime != 0 ? byTime : a.sortOrder.compareTo(b.sortOrder);
    });
  return [
    for (final routine in ordered)
      RoutineProgress(
        routine: routine,
        checkedItemIds: {
          for (final item in routine.items)
            if (checkedToday.contains(item.id)) item.id,
        },
      ),
  ];
}
