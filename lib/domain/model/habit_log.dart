import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'habit_log.freezed.dart';

/// What happened to a habit on one [day]: one log per habit per day.
///
/// Either a skip (`count` 0) or a number of check-ins (`count` ≥ 1). A day
/// with no log is simply not done. The logs are the habit's whole history:
/// streaks, rates, goals and badges are all derived from them.
@freezed
abstract class HabitLog with _$HabitLog {
  @Assert('skipped ? count == 0 : count >= 1', 'a skip or a count')
  const factory HabitLog({
    required String habitId,
    required CalendarDate day,

    /// Check-ins that day. Above the habit's daily target is allowed ("9 /
    /// 8"), and still counts as one done day.
    @Default(1) int count,

    /// Skipped on purpose (ill, travelling): neither done nor missed, so it
    /// neither breaks nor extends a streak.
    @Default(false) bool skipped,
  }) = _HabitLog;
}
