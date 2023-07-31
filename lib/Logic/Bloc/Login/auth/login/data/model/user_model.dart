library user_model;

import 'package:equatable/equatable.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';

class User extends Equatable {
  final String userName;
  final String password;
  final String token;
  final String image;
  final AuthenticationStatus status;

  static var empty = User;

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

  @override
  List<Object?> get props => [userName, password, token, image, status];
}
