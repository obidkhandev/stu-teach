import 'package:bloc/bloc.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/core/usecase/usecase.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/add_task_usecaes.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/delete_task_usecase.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/edit_task_usecase.dart';
import 'package:stu_teach/features/main/domain/usecases/tasks/get_all_task_usecase.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final EditTaskUseCase _editTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskCubit(
      this._getAllTasksUseCase,
      this._addTaskUseCase,
      this._editTaskUseCase,
      this._deleteTaskUseCase,
      ) : super(TaskInitial());

  Future<void> fetchAllTasks() async {
    emit(TaskLoading());
    final result = await _getAllTasksUseCase(NoParams());

    emit(result.fold(
          (failure) => TaskError(failure),
          (tasks) => TaskLoaded(tasks),
    ));
  }

  Future<void> addTask(AddTaskRequestModel request) async {
    emit(TaskLoading());
    final result = await _addTaskUseCase(AddTaskParams(request));

    emit(result.fold(
          (failure) => TaskError(failure),
          (taskId) => TaskAdded(taskId),
    ));
  }

  Future<void> editTask(String taskId, AddTaskRequestModel request) async {
    emit(TaskLoading());
    final result = await _editTaskUseCase(EditTaskParams(taskId, request));

    emit(result.fold(
          (failure) => TaskError(failure),
          (_) => TaskEdited(),
    ));
  }

  Future<void> deleteTask(String taskId) async {
    emit(TaskLoading());
    final result = await _deleteTaskUseCase(DeleteTaskParams(taskId));

    emit(result.fold(
          (failure) => TaskError(failure),
          (_) => TaskDeleted(),
    ));
  }
}
