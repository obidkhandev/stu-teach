
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/list_api.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/common/domain/repository/auth.dart';


class AuthRepository implements IAuthRepository {
  final SharedPreferences _preferences;
  AuthRepository(this._preferences);

  @override
  Future<Either<Failure, bool>> checkUserToAuth() async {
    try {
      String token = _preferences.getString(ListAPI.ACCESS_TOKEN) ?? '';
      return Right(token.isNotEmpty);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _preferences.setString(ListAPI.ACCESS_TOKEN, '');
      return const Right(true);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
