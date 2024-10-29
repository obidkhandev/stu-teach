import 'package:stu_teach/features/main/data/model/get_teacher_tasks/response/get_all_tasks_response.dart';

class StudentModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<UserCompletedTask> completedTasksIds;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.completedTasksIds,
  });

  // Factory constructor to create an instance from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      completedTasksIds: (json['completed_tasks'] as List<dynamic>?)
          ?.map((task) => UserCompletedTask.fromJson(task))
          .toList() ?? [],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'completed_tasks': completedTasksIds.map((task) => task.toJson()).toList(),
    };
  }

  // CopyWith method to create a new instance with updated fields
  StudentModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<UserCompletedTask>? completedTasksIds,
  }) {
    return StudentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      completedTasksIds: completedTasksIds ?? this.completedTasksIds,
    );
  }
}

class UserCompletedTask {
  final String fileUrl;
  final TaskResponse task;

  UserCompletedTask({
    required this.fileUrl,
    required this.task,
  });

  // Factory constructor to create an instance from JSON
  factory UserCompletedTask.fromJson(Map<String, dynamic> json) {
    return UserCompletedTask(
      fileUrl: json['fileUrl'],
      task: TaskResponse.fromJson(json['task']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fileUrl': fileUrl,
      'task': task.toJson(),
    };
  }
}
