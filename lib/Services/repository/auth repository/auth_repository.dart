library auth_repository;

import 'dart:async';
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

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.loginNonVerified),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.loginNonVerified);
  }

  void dispose() => _controller.close();
}
