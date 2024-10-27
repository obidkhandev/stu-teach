
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stu_teach/core/api/list_api.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/datasourse/login_datasourse.dart';
import 'package:stu_teach/features/auth/data/models/login/request/login_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/login_response_model.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';



class AuthRepository implements IAuthRepository {
  final SharedPreferences _preferences;
  final LoginDatasource loginDatasourceImpl;
  AuthRepository(this._preferences, this.loginDatasourceImpl);

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

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel request) async {
    final response = await loginDatasourceImpl.loginUser(request);
    return response.fold(
          (failure) => Left(failure),
          (response) async {
        return Right(response);
      },
    );
  }
}
