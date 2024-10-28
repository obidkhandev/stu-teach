import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';

abstract class StudentRepository {
  Future<Either<Failure, bool>> addUser(StudentModel request);
  Future<Either<Failure, StudentModel>> getUser();
}