import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/calendar_date.dart';

part 'achievement_unlock.freezed.dart';

/// A badge the user has earned, and when.
///
/// The one achievement fact that *is* stored. Everything else in the app is
/// derived, but a badge is a moment: "7-day streak, unlocked 12 Oct" must
/// stay true after the streak breaks. So an unlock is recorded once and
/// never changes (the rules themselves live in code).
@freezed
abstract class AchievementUnlock with _$AchievementUnlock {
  const factory AchievementUnlock({
    required String achievementId,
    required CalendarDate unlockedOn,
    required DateTime unlockedAt,
  }) = _AchievementUnlock;
}
