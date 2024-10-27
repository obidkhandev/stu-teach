class TaskResponse{
  final String id;
  final String title;
  final String date;
  final String fileUrl;

  final int finishedCount;

  TaskResponse({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
  });


  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      fileUrl: json['fileUrl'] as String,
      finishedCount: json['finishedCount'] as int,
    );
  }

}