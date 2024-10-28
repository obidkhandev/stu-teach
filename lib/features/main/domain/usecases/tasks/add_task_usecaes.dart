// Use case for adding a task
import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class AddTaskUseCase extends UseCase<String, AddTaskParams> {
  final TaskRepositories _repo;

  AddTaskUseCase(this._repo);

  @override
  Future<Either<Failure, String>> call(AddTaskParams params) {
    return _repo.addTask(params.request);
  }
}

class AddTaskParams {
  final AddTaskRequestModel request;

  AddTaskParams(this.request);
}
