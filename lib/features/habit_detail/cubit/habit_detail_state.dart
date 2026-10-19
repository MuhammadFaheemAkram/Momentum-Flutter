import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

part 'habit_detail_state.freezed.dart';

enum HabitDetailStatus { loading, ready, notFound, failed }

@freezed
abstract class HabitDetailState with _$HabitDetailState {
  const factory HabitDetailState({
    @Default(HabitDetailStatus.loading) HabitDetailStatus status,
    HabitDetail? detail,

    /// Deleted from here: the page leaves.
    @Default(false) bool deleted,
    String? message,
    @Default(0) int messageSerial,
  }) = _HabitDetailState;
}
