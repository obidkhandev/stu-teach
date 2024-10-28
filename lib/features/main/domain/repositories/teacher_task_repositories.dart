import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';

abstract class TaskRepositories{
  Future<Either<Failure, String>> uploadFile(File file);

  Future<Either<Failure, List<TaskResponse>>> getAllTasks();
  Future<Either<Failure, String>> addTask(AddTaskRequestModel request);
  Future<Either<Failure, void>> editTask(String taskId,AddTaskRequestModel request);
  Future<Either<Failure, void>> deleteTask(String taskId);


}