part of 'task_cubit.dart';


abstract class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  final List<TaskResponse> tasks;

  TaskLoaded(this.tasks);
}

final class TaskAdded extends TaskState {
  final String taskId;

  TaskAdded(this.taskId);
}

final class TaskEdited extends TaskState {}

final class TaskDeleted extends TaskState {}

final class TaskError extends TaskState {
  final Failure failure;

  TaskError(this.failure);
}
