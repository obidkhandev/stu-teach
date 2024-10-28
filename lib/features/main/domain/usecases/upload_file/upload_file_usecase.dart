import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class UploadFileUseCase extends UseCase<String, UploadFileParams> {
  final TaskRepositories _repo;

  UploadFileUseCase(this._repo);

  @override
  Future<Either<Failure, String>> call(UploadFileParams params) {
    return _repo.uploadFile(params.file);
  }
}

class UploadFileParams {
  final File file;

  UploadFileParams(this.file);
}