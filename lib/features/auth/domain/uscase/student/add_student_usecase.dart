import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:stu_teach/features/auth/domain/repository/student.dart';


class AddStudentUsecase extends UseCase<bool, AddStudentParams> {
  final StudentRepository _repo;

  AddStudentUsecase(this._repo);

  @override
  Future<Either<Failure, bool>> call(AddStudentParams params) {
    return _repo.addUser(params.request);
  }
}

class AddStudentParams extends Equatable {
  final StudentModel request;

  const AddStudentParams({required this.request});

  @override
  List<Object?> get props => [
    request,
  ];
}
