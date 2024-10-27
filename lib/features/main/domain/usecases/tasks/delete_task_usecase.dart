import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class DeleteTaskUseCase extends UseCase<void, DeleteTaskParams> {
  final TeacherTaskRepositories _repo;

  DeleteTaskUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) {
    return _repo.deleteTask(params.taskId);
  }
}

class DeleteTaskParams {
  final String taskId;

  DeleteTaskParams(this.taskId);
}