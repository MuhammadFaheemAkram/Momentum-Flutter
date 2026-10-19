import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:momentum/core/common/app_exception.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/data/mapper/demo_mappers.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/repository/demo_repository.dart';

@LazySingleton(as: DemoRepository)
class DemoRepositoryImpl implements DemoRepository {
  const DemoRepositoryImpl(this._service, this._userData, this._clock);

  final MomentumService _service;
  final UserDataDao _userData;
  final Clock _clock;

  /// Fetch → check and map (as of now) → write. The checks run before the
  /// write, so damaged data never reaches the database.
  ///
  /// Every failure becomes an [AppException] the UI can show: the app's own
  /// pass through, malformed data becomes [DataFormatException], and
  /// anything else (a database error) is logged and becomes
  /// [UnknownException].
  @override
  Future<Result<void>> loadDemo() async {
    try {
      final demo = await _service.fetchDemo();
      final data = demo.toUserData(now: _clock.now());
      await _userData.replaceAll(data.toRows());
      return const Ok(null);
    } on AppException catch (exception) {
      return Err(exception);
    } on FormatException catch (error, stackTrace) {
      log('Loading the demo failed', error: error, stackTrace: stackTrace);
      return const Err(DataFormatException());
    } on CheckedFromJsonException catch (error, stackTrace) {
      log('Loading the demo failed', error: error, stackTrace: stackTrace);
      return const Err(DataFormatException());
    } on Object catch (error, stackTrace) {
      log('Loading the demo failed', error: error, stackTrace: stackTrace);
      return const Err(UnknownException());
    }
  }
}
