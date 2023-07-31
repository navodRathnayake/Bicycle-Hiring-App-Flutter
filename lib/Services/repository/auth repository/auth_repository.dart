library auth_repository;

import 'dart:async';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/data%20provider/login_form_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/repository/login_form_repository.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

enum AuthenticationStatus { initial, loginNonVerified, logingVerified, logout }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final user = await SqfliteHelper.instance.readUserData();

    debugPrint(user['status'].toString());

    switch (user['status']) {
      case 'initial':
        yield AuthenticationStatus.initial;
        break;
      case 'login-nonVerified':
        yield AuthenticationStatus.loginNonVerified;
      case 'login-verified':
        yield AuthenticationStatus.logingVerified;
      case 'logout':
        yield AuthenticationStatus.logout;
        break;
      default:
        yield AuthenticationStatus.initial;
    }
    yield* _controller.stream;
  }

  // _controller.add(AuthenticationStatus.loginNonVerified),

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await LoginFormRepository(
              api:
                  LoginFormApi(reqBody: {'email': email, 'password': password}))
          .getLoginResponse();

      if (result['result'] == 1) {
        // change login response body

        SqfliteHelper.instance.updateMode(
          userName: email.toString(),
          password: password.toString(),
          token: result['body']['token'].toString(),
          image: 'null',
          status: result['body']['status id'] == 2
              ? 'login-verified'
              : 'login-nonVerified', // upgrade status form api response
        );

        var localDB = await SqfliteHelper.instance.readUserData();
        debugPrint(localDB.toString());

        debugPrint('Successfuly login');

        if (result['body']['status id'] == 1) {
          _controller.add(AuthenticationStatus.loginNonVerified);
        } else if (result['body']['status id'] == 2) {
          _controller.add(AuthenticationStatus.logingVerified);
        } else {
          _controller.add(AuthenticationStatus.logout);
        }

        // add routes here - navigator.pop()
      } else {
        debugPrint('login failure');
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.loginNonVerified);
  }

  void dispose() => _controller.close();
}
