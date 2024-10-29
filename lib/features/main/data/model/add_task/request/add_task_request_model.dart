import 'package:stu_teach/features/auth/data/models/student/stundent_model.dart';

class AddTaskRequestModel {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;
  final List<String> userIds;
  final String fileType;
  final int finishedCount;
  final List<StudentModel> completedStudents;

  AddTaskRequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.tarif,
    required this.userIds,
    required this.fileType,
    required this.completedStudents,
  });

  // Convert instance to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'fileUrl': fileUrl,
    'finishedCount': finishedCount,
    'tarif': tarif,
    'userIds': userIds,
    'fileType': fileType,
    'completedStudents': completedStudents.map((student) => student.toJson()).toList(),
  };

  // CopyWith method to create a new instance with updated fields
  AddTaskRequestModel copyWith({
    String? id,
    String? title,
    String? tarif,
    String? date,
    String? fileUrl,
    String? fileType,
    int? finishedCount,
    List<String>? userIds,
    String? receivedUrl,
    List<StudentModel>? completedStudents,
  }) {
    return AddTaskRequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tarif: tarif ?? this.tarif,
      date: date ?? this.date,
      fileUrl: fileUrl ?? this.fileUrl,
      fileType: fileType ?? this.fileType,
      finishedCount: finishedCount ?? this.finishedCount,
      userIds: userIds ?? this.userIds,
      completedStudents: completedStudents ?? this.completedStudents,
    );
  }
}
