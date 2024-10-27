import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/common/domain/repository/auth.dart';




class CheckUserToAuthUseCase extends UseCase<bool, NoParams> {
  final IAuthRepository _authRepository;
  CheckUserToAuthUseCase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      _authRepository.checkUserToAuth();
}
