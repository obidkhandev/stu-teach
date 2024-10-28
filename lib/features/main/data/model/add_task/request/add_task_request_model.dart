class AddTaskRequestModel {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;
  final List<String> userIds;

  final int finishedCount;

  AddTaskRequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.tarif,
    required this.userIds,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'fileUrl': fileUrl,
        'finishedCount': finishedCount,
        'tarif': tarif,
    'userIds': userIds
      };

  AddTaskRequestModel copyWith({
    String? id,
    String? title,
    String? tarif,
    String? date,
    String? fileUrl,
    int? finishedCount,
    List<String>? userIds,
  }) {
    return AddTaskRequestModel(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
      title: title ?? this.title,
      tarif: tarif ?? this.tarif,
      date: date ?? this.date,
      fileUrl: fileUrl ?? this.fileUrl,
      finishedCount: finishedCount ?? this.finishedCount,
    );
  }
}
