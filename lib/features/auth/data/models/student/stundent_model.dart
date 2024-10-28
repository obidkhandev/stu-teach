class StudentModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final List<String> completedTasksIds;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.completedTasksIds = const [], // Default empty list for completed tasks
  });

  // Factory constructor to create an instance from JSON
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      completedTasksIds: List<String>.from(json['completedTasksIds'] ?? []),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'completedTasksIds': completedTasksIds,
    };
  }

  // CopyWith method to create a new instance with updated fields
  StudentModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<String>? completedTasksIds,
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
