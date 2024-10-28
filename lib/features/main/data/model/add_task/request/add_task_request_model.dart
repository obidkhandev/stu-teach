class AddTaskRequestModel {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;
  final List<String> userIds;
  final String fileType;

  final int finishedCount;

  AddTaskRequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.tarif,
    required this.userIds,
    required this.fileType,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'fileUrl': fileUrl,
        'finishedCount': finishedCount,
        'tarif': tarif,
    'userIds': userIds,
    'fileType': fileType
      };

  AddTaskRequestModel copyWith({
    String? id,
    String? title,
    String? tarif,
    String? date,
    String? fileUrl,
    String? fileType,
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
      finishedCount: finishedCount ?? this.finishedCount, fileType: fileType ?? this.fileType,
    );
  }
}
