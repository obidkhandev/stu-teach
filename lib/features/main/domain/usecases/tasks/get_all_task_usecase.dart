
import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class GetAllTasksUseCase extends UseCase<List<TaskResponse>, NoParams> {
  final TaskRepositories _repo;

  GetAllTasksUseCase(this._repo);

  @override
  Future<Either<Failure, List<TaskResponse>>> call(NoParams params) {
    return _repo.getAllTasks();
  }
}
