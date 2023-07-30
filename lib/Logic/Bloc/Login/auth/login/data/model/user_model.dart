library user_model;

import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';

class User {
  final String userName;
  final String password;
  final String token;
  final String image;
  final AuthenticationStatus status;

  const User({
    required this.userName,
    required this.password,
    required this.token,
    required this.image,
    required this.status,
  });

  User.formJson({required Map<String, dynamic> json})
      : userName = json['userName'],
        password = json['password'],
        token = json['token'],
        image = json['image'],
        status = json['status'];
}
