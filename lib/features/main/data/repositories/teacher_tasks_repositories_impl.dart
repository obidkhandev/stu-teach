import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/main/data/datasources/teacher_task_datasources.dart';
import 'package:stu_teach/features/main/data/datasources/upload_file_datasourse.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:stu_teach/features/main/domain/repositories/teacher_task_repositories.dart';

class TeacherTasksRepositoriesImpl extends TaskRepositories {
  final UploadFileDatasource _fileDatasource;
  final TaskDatasource _taskDatasource;

  TeacherTasksRepositoriesImpl(this._fileDatasource, this._taskDatasource);

  @override
  Future<Either<Failure, String>> uploadFile(File file) async {
    final response = await _fileDatasource.uploadFile(file);
    return response.fold(
          (failure) => Left(failure),
          (url) async {
        return Right(url);
      },
    );
  }

  @override
  Future<Either<Failure, String>> addTask(AddTaskRequestModel request) async {
    final response = await _taskDatasource.addTask(request);
    return response.fold(
          (failure) => Left(failure),
          (taskId) => Right(taskId), // Return the ID of the added task
    );
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    final response = await _taskDatasource.deleteTask(taskId);
    return response.fold(
          (failure) => Left(failure),
          (_) => const Right(null), // Successfully deleted
    );
  }

  @override
  Future<Either<Failure, void>> editTask(String taskId, AddTaskRequestModel request) async {
    final response = await _taskDatasource.editTask(taskId, request);
    return response.fold(
          (failure) => Left(failure),
          (_) => const Right(null), // Successfully edited
    );
  }

  @override
  Future<Either<Failure, List<TaskResponse>>> getAllTasks() async {
    final response = await _taskDatasource.getAllTasks();
    return response.fold(
          (failure) => Left(failure),
          (tasks) => Right(tasks), // Return the list of tasks
    );
  }
}
