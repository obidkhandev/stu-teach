import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> checkUserToAuth();
  Future<Either<Failure, bool>> logout();
}
