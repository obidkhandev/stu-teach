import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/main/data/datasources/upload_file_datasourse.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';


class TeacherTasksRepositoriesImpl extends TeacherTaskRepositories {
  final UploadFileDatasource _fileDatasource;

  TeacherTasksRepositoriesImpl(this._fileDatasource);

  @override
  Future<Either<Failure, String>> uploadFile(File file) async {
    final response = await _fileDatasource.uploadFile(file);
    return response.fold(
          (failure) => Left(failure),
          (response) async {
        return Right(response);
      },
    );
  }


}
