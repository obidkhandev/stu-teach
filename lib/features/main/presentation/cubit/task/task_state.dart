part of 'task_cubit.dart';


abstract class TeacherTaskState {}

final class TeacherTaskInitial extends TeacherTaskState {}

final class TeacherTaskLoading extends TeacherTaskState {}

final class TeacherTaskLoaded extends TeacherTaskState {
  final List<TaskResponse> tasks;

  TeacherTaskLoaded(this.tasks);
}

final class TeacherTaskAdded extends TeacherTaskState {
  final String taskId;

  TeacherTaskAdded(this.taskId);
}

final class TeacherTaskEdited extends TeacherTaskState {}

final class TeacherTaskDeleted extends TeacherTaskState {}

final class TeacherTaskError extends TeacherTaskState {
  final Failure failure;

  TeacherTaskError(this.failure);
}
