import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/login/request/auth_request_model.dart';
import 'package:stu_teach/features/auth/data/models/login/response/auth_response_model.dart';
import 'package:stu_teach/features/auth/domain/repository/auth.dart';


class RegisterUserUsecase extends UseCase<AuthResponseModel, RegisterParams> {
  final IAuthRepository _repo;

  RegisterUserUsecase(this._repo);

  @override
  Future<Either<Failure, AuthResponseModel>> call(RegisterParams params) {
    return _repo.registerUser(params.request);
  }
}

class RegisterParams extends Equatable {
  final AuthRequestModel request;

  const RegisterParams({required this.request});

  @override
  List<Object?> get props => [
    request,
  ];
}
