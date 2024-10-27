import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/login/request/login_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/login_response_model.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';


class LoginUserUsecase extends UseCase<LoginResponseModel, LoginParams> {
  final IAuthRepository _repo;

  LoginUserUsecase(this._repo);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginParams params) {
    return _repo.loginUser(params.request);
  }
}

class LoginParams extends Equatable {
  final LoginRequestModel request;

  const LoginParams({required this.request});

  @override
  List<Object?> get props => [
        request,
      ];
}
