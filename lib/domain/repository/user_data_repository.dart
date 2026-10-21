import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/user_data.dart';

/// Everything the user owns, at once: what a backup sends, and what Reset
/// progress clears part of.
abstract interface class UserDataRepository {
  /// Every row, read in one transaction so the tables agree.
  Future<UserData> readAll();

  /// Clears the history: every log, routine check-off and badge unlock, in
  /// one transaction. Habits, routines, goals and settings stay.
  Future<Result<void>> resetProgress();
}
