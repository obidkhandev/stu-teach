
// Use case for editing a task
import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class EditTaskUseCase extends UseCase<void, EditTaskParams> {
  final TaskRepositories _repo;

  EditTaskUseCase(this._repo);

  @override
  Future<Either<Failure, void>> call(EditTaskParams params) {
    return _repo.editTask(params.taskId, params.request);
  }
}

class EditTaskParams {
  final String taskId;
  final AddTaskRequestModel request;

  EditTaskParams(this.taskId, this.request);
}
