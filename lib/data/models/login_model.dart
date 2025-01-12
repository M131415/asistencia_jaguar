import 'package:asistencia_jaguar/data/models/user_list.dart';

class LoginModel {
  final String token;
  final String refreshToken;
  final UserList user;
  final String message;

  LoginModel({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      refreshToken: json['refresh_token'],
      user: UserList.fromJson(json['user']),
      message: json['message'],
    );
  }
  
}