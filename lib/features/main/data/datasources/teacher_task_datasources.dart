import 'package:dartz/dartz.dart';
import 'package:stu_teach/core/error/failure.dart';
import 'package:stu_teach/features/main/data/model/add_task/request/add_task_request_model.dart';
import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class TaskDatasource {
  Future<Either<Failure, List<TaskResponse>>> getAllTasks();
  Future<Either<Failure, String>> addTask(AddTaskRequestModel request);
  Future<Either<Failure, void>> editTask(String taskId,AddTaskRequestModel request);
  Future<Either<Failure, void>> deleteTask(String taskId);

}


class TaskDatasourceImpl implements TaskDatasource {
  final FirebaseFirestore firestore;

  TaskDatasourceImpl(this.firestore);

  @override
  Future<Either<Failure, List<TaskResponse>>> getAllTasks() async {
    try {
      final querySnapshot = await firestore.collection('tasks').get();
      final tasks = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return TaskResponse.fromJson(data..['id'] = doc.id);
      }).toList();

      return Right(tasks);
    } catch (e) {
      return const Left(ServerFailure(500));
    }
  }

  @override
  Future<Either<Failure, String>> addTask(AddTaskRequestModel request) async {
    try {
      final docRef = await firestore.collection('tasks').add(request.toJson());

      final updatedRequest = request.copyWith(id: docRef.id);
      await firestore.collection('tasks').doc(docRef.id).update(updatedRequest.toJson());


      return Right(docRef.id);
    } catch (e) {
      return const Left(ServerFailure(500));
    }
  }

  @override
  Future<Either<Failure, void>> editTask(String taskId, AddTaskRequestModel request) async {
    try {
      await firestore.collection('tasks').doc(taskId).update(request.toJson());
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(500));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure(500));
    }
  }
}
