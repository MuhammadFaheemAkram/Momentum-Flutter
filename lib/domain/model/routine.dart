import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';

part 'routine.freezed.dart';

/// An ordered checklist for a time of day ("Morning": make the bed, stretch,
/// …), checked off afresh each day.
@freezed
abstract class Routine with _$Routine {
  const factory Routine({
    required String id,
    required String title,
    @Default(RoutineTime.anytime) RoutineTime time,

    /// In the user's order: the list's order *is* the order.
    required List<RoutineItem> items,
    required DateTime createdAt,

    /// The position among the routines.
    required int sortOrder,
  }) = _Routine;
}

@freezed
abstract class RoutineItem with _$RoutineItem {
  const factory RoutineItem({required String id, required String title}) =
      _RoutineItem;
}

/// A routine item checked off on [day].
@freezed
abstract class RoutineCheck with _$RoutineCheck {
  const factory RoutineCheck({
    required String itemId,
    required CalendarDate day,
  }) = _RoutineCheck;
}

/// What the routine editor saves: the title, the time of day, and the items
/// in their order (existing ones keep their ids, so their check-offs stay).
@freezed
abstract class RoutineDraft with _$RoutineDraft {
  const factory RoutineDraft({
    required String title,
    @Default(RoutineTime.anytime) RoutineTime time,
    required List<RoutineItem> items,
  }) = _RoutineDraft;

  factory RoutineDraft.of(Routine routine) => RoutineDraft(
    title: routine.title,
    time: routine.time,
    items: routine.items,
  );
}

/// A routine as it stands today: which of its items are checked off.
@freezed
abstract class RoutineProgress with _$RoutineProgress {
  const factory RoutineProgress({
    required Routine routine,

    /// The ids of the items checked off today.
    required Set<String> checkedItemIds,
  }) = _RoutineProgress;

  const RoutineProgress._();

  int get done =>
      routine.items.where((item) => checkedItemIds.contains(item.id)).length;

  int get total => routine.items.length;

  bool get isComplete => total > 0 && done == total;
}
