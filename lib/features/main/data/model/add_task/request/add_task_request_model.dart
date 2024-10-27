class AddTaskRequestModel {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String status;
  final int finishedCount;

  AddTaskRequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.status,
    required this.finishedCount,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'fileUrl': fileUrl,
    'status': status,
    'finishedCount': finishedCount,
  };
}