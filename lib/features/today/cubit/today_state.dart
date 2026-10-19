import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';

part 'today_state.freezed.dart';

enum TodayStatus { loading, ready, failed }

@freezed
abstract class TodayState with _$TodayState {
  const factory TodayState({
    @Default(TodayStatus.loading) TodayStatus status,
    TodayOverview? overview,

    /// A one-time message (a SnackBar); [noticeSerial] makes each one
    /// distinct, so the same message twice still shows twice.
    HabitNotice? notice,
    @Default(0) int noticeSerial,
  }) = _TodayState;
}
