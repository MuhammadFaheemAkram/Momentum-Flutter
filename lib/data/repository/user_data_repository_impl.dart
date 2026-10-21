import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/guard_write.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/data/mapper/user_data_mappers.dart';
import 'package:momentum/domain/model/user_data.dart';
import 'package:momentum/domain/repository/user_data_repository.dart';

@LazySingleton(as: UserDataRepository)
class UserDataRepositoryImpl implements UserDataRepository {
  const UserDataRepositoryImpl(this._userData);

  final UserDataDao _userData;

  @override
  Future<UserData> readAll() async => (await _userData.readAll()).toUserData();

  @override
  Future<Result<void>> resetProgress() =>
      guardWrite('Resetting progress', _userData.resetProgress);
}
