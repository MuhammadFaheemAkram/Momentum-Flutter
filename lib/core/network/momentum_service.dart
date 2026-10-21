import 'package:momentum/core/network/dto/backup_dto.dart';
import 'package:momentum/core/network/dto/demo_dto.dart';

/// The app's only "remote" API.
///
/// Momentum is local-first: everything the user owns lives in drift, and
/// every screen reads it there. The service only delivers the demo and
/// receives backups. It still looks like a real API (async, typed DTOs,
/// throwing `AppException`s), so a real implementation could replace the
/// fake without changing any caller.
abstract interface class MomentumService {
  /// The demo: habits with eight weeks of logs, routines, goals.
  ///
  /// Throws a `NetworkException` when the request fails, and a
  /// `FormatException` (or `CheckedFromJsonException`) for malformed data.
  Future<DemoDto> fetchDemo();

  /// Receives a full backup; answers with what it stored. Throws a
  /// `NetworkException` when the request fails.
  Future<BackupReceiptDto> uploadBackup(BackupDto backup);
}
