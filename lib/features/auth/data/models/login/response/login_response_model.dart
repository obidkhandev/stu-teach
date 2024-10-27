class LoginResponseModel {
  final String message;
  final String userId;

  LoginResponseModel({required this.message,required this.userId});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'] ?? '',
      userId: json['userId'] ?? '',
    );
  }
}