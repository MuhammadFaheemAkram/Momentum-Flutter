import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/user_data.dart';

/// Backups, to the (fake) service.
abstract interface class BackupRepository {
  /// Sends [data] as a full backup, and returns what the service stored.
  Future<Result<BackupReceipt>> upload(UserData data);
}
