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
