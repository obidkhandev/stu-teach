class TaskResponse {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;
  final String urlType;


  final int finishedCount;
  final List<String> userIds;

  TaskResponse({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.userIds,
    required this.tarif,
    required this.urlType,
  });

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
    );
  }
}
