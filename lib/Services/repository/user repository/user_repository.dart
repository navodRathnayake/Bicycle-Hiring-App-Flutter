// import 'dart:async';

// import 'package:final_project/Logic/Bloc/Login/auth/login/data/model/user_model.dart';
// import 'package:final_project/Services/database/sqlite_helper.dart';
// import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';

// class UserRepository {
//   Future<User?> getUser() async {
//     var userData = await SqfliteHelper.instance.readUserData();
//     late AuthenticationStatus userStatus;
//     switch (userData['status'].toString()) {
//       case 'initial':
//         userStatus = AuthenticationStatus.initial;
//         break;
//       case 'login-nonVerifed':
//         userStatus = AuthenticationStatus.loginNonVerified;
//         break;
//       case 'login-verified':
//         userStatus = AuthenticationStatus.logingVerified;
//         break;
//       case 'logout':
//         userStatus = AuthenticationStatus.logout;
//         break;

//       default:
//         userStatus = AuthenticationStatus.logout;
//     }
//     return User(
//       userName: userData['userName'].toString(),
//       password: userData['password'].toString(),
//       token: userData['token'].toString(),
//       image: userData['image'].toString(),
//       status: userStatus,
//     );
//   }
// }
