import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/auth/data/datasourse/student_datasources.dart';
import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';
import 'package:stu_teach/features/auth/domain/repository/student.dart';

class StudentRepositoryImpl extends StudentRepository {

  final StudentDatasource studentDatasource;

  StudentRepositoryImpl(this.studentDatasource);


  @override
  Future<Either<Failure, bool>> addUser(StudentModel request) async {
    final response = await studentDatasource.addStudent(request);
    return response.fold(
          (failure) => Left(failure),
          (response) async {
        return Right(response);
      },
    );
  }



  @override
  Future<Either<Failure, StudentModel>> getUser() async{
    final response = await studentDatasource.getStudent();
    return response.fold(
          (failure) => Left(failure),
          (response) async {
        return Right(response);
      },
    );
  }
}