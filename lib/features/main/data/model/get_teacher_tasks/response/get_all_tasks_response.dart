import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';

class TaskResponse {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;
  final String urlType;
  final int finishedCount;
  final List<String> userIds;
  final List<StudentModel> completedStudents;

  TaskResponse({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.userIds,
    required this.tarif,
    required this.urlType,
    required this.completedStudents,
  });

  // Factory constructor to create an instance from JSON
  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      fileUrl: json['fileUrl'] as String,
      finishedCount: json['finishedCount'] as int,
      userIds: List<String>.from(json['userIds'] as List),
      tarif: json['tarif'] as String,
      urlType: json['fileType'] as String,
      completedStudents: (json['completedStudents'] as List<dynamic>?)
          ?.map((student) => StudentModel.fromJson(student))
          .toList() ??
          [],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'fileUrl': fileUrl,
      'finishedCount': finishedCount,
      'userIds': userIds,
      'tarif': tarif,
      'fileType': urlType,
      'completedStudents': completedStudents.map((student) => student.toJson()).toList(),
    };
  }

  // CopyWith method to create a new instance with updated fields
  TaskResponse copyWith({
    String? id,
    String? title,
    String? date,
    String? fileUrl,
    String? tarif,
    String? urlType,
    int? finishedCount,
    List<String>? userIds,
    List<String>? receivedUrl,
    List<StudentModel>? completedStudents,
  }) {
    return TaskResponse(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      fileUrl: fileUrl ?? this.fileUrl,
      tarif: tarif ?? this.tarif,
      urlType: urlType ?? this.urlType,
      finishedCount: finishedCount ?? this.finishedCount,
      userIds: userIds ?? this.userIds,
      completedStudents: completedStudents ?? this.completedStudents,
    );
  }
}
