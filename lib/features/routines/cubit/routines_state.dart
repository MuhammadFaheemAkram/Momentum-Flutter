import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/routine.dart';

part 'routines_state.freezed.dart';

enum RoutinesStatus { loading, ready, failed }

@freezed
abstract class RoutinesState with _$RoutinesState {
  const factory RoutinesState({
    @Default(RoutinesStatus.loading) RoutinesStatus status,
    CalendarDate? today,
    @Default(<RoutineProgress>[]) List<RoutineProgress> routines,
    String? message,
    @Default(0) int messageSerial,
  }) = _RoutinesState;
}
