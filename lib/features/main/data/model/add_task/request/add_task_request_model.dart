class AddTaskRequestModel {
  final String id;
  final String title;
  final String date;
  final String fileUrl;
  final String tarif;

  final int finishedCount;

  AddTaskRequestModel({
    required this.id,
    required this.title,
    required this.date,
    required this.fileUrl,
    required this.finishedCount,
    required this.tarif,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date,
        'fileUrl': fileUrl,
        'finishedCount': finishedCount,
        'tarif': tarif
      };

  AddTaskRequestModel copyWith({
    String? id,
    String? title,
    String? tarif,
    String? date,
    String? fileUrl,
    int? finishedCount,
  }) {
    return AddTaskRequestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      tarif: tarif ?? this.tarif,
      date: date ?? this.date,
      fileUrl: fileUrl ?? this.fileUrl,
      finishedCount: finishedCount ?? this.finishedCount,
    );
  }
}
