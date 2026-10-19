import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/habit_overviews.dart';
import 'package:momentum/features/habit_actions/habit_notice.dart';

part 'habits_state.freezed.dart';

enum HabitsStatus { loading, ready, failed }

@freezed
abstract class HabitsState with _$HabitsState {
  const factory HabitsState({
    @Default(HabitsStatus.loading) HabitsStatus status,
    CalendarDate? today,

    /// Every habit, archived ones too.
    @Default(<HabitToday>[]) List<HabitToday> habits,
    @Default('') String query,
    HabitCategory? category,
    @Default(false) bool showArchived,
    HabitNotice? notice,
    @Default(0) int noticeSerial,
  }) = _HabitsState;

  const HabitsState._();

  /// The habits the filters let through, in the user's order. The search
  /// matches the name and the description, ignoring case. The list is a
  /// person's habits, a few dozen at most, so it's filtered in memory.
  List<HabitToday> get visible {
    final words = query.trim().toLowerCase();
    return [
      for (final item in habits)
        if ((showArchived || item.habit.archivedAt == null) &&
            (category == null || item.habit.category == category) &&
            (words.isEmpty ||
                item.habit.title.toLowerCase().contains(words) ||
                item.habit.description.toLowerCase().contains(words)))
          item,
    ];
  }

  bool get isFiltered => query.trim().isNotEmpty || category != null;

  int get archivedCount =>
      habits.where((item) => item.habit.archivedAt != null).length;
}
