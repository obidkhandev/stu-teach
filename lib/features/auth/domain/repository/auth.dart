import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/models/login/request/auth_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/auth_response_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> checkUserToAuth();
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, AuthResponseModel>> loginUser(AuthRequestModel request);
  Future<Either<Failure, AuthResponseModel>> registerUser(AuthRequestModel request);

}
