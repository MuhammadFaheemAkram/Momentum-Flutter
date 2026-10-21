import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/data/mapper/backup_mappers.dart';
import 'package:momentum/domain/model/backup.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/repository/backup_repository.dart';

@LazySingleton(as: BackupRepository)
class BackupRepositoryImpl implements BackupRepository {
  const BackupRepositoryImpl(this._service, this._clock);

  final MomentumService _service;
  final Clock _clock;

  @override
  Future<Result<BackupReceipt>> upload(UserData data) async {
    try {
      final receipt = await _service.uploadBackup(
        data.toBackupDto(exportedAt: _clock.now()),
      );
      return Ok(receipt.toDomain());
    } on AppException catch (exception) {
      return Err(exception);
    } on Object catch (error, stackTrace) {
      log('The backup failed', error: error, stackTrace: stackTrace);
      return const Err(UnknownException());
    }
  }
}
