import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/list_api.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/datasourse/auth_datasourse.dart';
import 'package:stu_teach/features/auth/data/models/login/request/auth_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/auth_response_model.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';

class AuthRepository implements IAuthRepository {
  final SharedPreferences _preferences;
  final AuthDatasource loginDatasourceImpl;

  AuthRepository(this._preferences, this.loginDatasourceImpl);

  @override
  Future<Either<Failure, bool>> checkUserToAuth() async {
    try {
      String token = _preferences.getString(ListAPI.ACCESS_TOKEN) ?? '';
      if (token.isEmpty) {
        return const Left(CacheFailure());
      } else {
        return const Right(true);
      }
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _preferences.setString(ListAPI.ACCESS_TOKEN, '');
      await _preferences.setString(ListAPI.userID, '');
      return const Right(true);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> loginUser(
      AuthRequestModel request) async {
    final response = await loginDatasourceImpl.login(request);
    return response.fold(
      (failure) => Left(failure),
      (response) async {
        return Right(response);
      },
    );
  }

  @override
  Future<Either<Failure, AuthResponseModel>> registerUser(
      AuthRequestModel request) async {
    final response = await loginDatasourceImpl.register(request);
    return response.fold(
      (failure) => Left(failure),
      (response) async {
        return Right(response);
      },
    );
  }
}
