import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup.freezed.dart';

/// What the service confirmed it stored.
@freezed
abstract class BackupReceipt with _$BackupReceipt {
  const factory BackupReceipt({
    required DateTime receivedAt,
    required int habits,
    required int logs,
  }) = _BackupReceipt;
}

/// What an automatic backup did.
sealed class BackupOutcome {
  const BackupOutcome();
}

/// Off, or the last one is less than a day old.
final class BackupNotDue extends BackupOutcome {
  const BackupNotDue();
}

final class BackupDone extends BackupOutcome {
  const BackupDone(this.receipt);

  final BackupReceipt receipt;
}

/// Reported, not retried: the next run tries again (correctness rule 12).
final class BackupFailed extends BackupOutcome {
  const BackupFailed(this.message);

  final String message;
}
