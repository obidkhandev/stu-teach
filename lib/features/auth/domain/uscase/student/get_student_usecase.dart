import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:stu_teach/features/auth/domain/repository/student.dart';


class GetStudentUsecase extends UseCase<StudentModel, NoParams> {
  final StudentRepository _repo;

  GetStudentUsecase(this._repo);

  @override
  Future<Either<Failure, StudentModel>> call(NoParams params) {
    return _repo.getUser();
  }
}

