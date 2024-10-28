class AuthResponseModel {
  final String message;
  final String userId;

  AuthResponseModel({required this.message,required this.userId});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json['message'] ?? '',
      userId: json['userId'] ?? '',
    );
  }
}