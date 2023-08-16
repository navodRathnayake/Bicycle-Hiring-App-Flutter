library user_model;

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String userName;
  final String password;
  final String image;
  final String nic;
  final String bloodGroup;
  final int points;

  static const empty = User(
    userName: '',
    password: '',
    image: '',
    nic: '',
    email: '',
    bloodGroup: '',
    points: 0,
  );

  const User({
    required this.email,
    required this.userName,
    required this.password,
    required this.image,
    required this.nic,
    required this.points,
    required this.bloodGroup,
  });

  // User.formJson({required Map<String, dynamic> json})
  //     : userName = json['userName'],
  //       password = json['password'],
  //       token = json['token'],
  //       image = json['image'];

  @override
  List<Object?> get props => [userName, password, image, nic, points];
}
