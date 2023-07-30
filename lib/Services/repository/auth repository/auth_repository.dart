library auth_repository;

import 'dart:async';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

enum AuthenticationStatus {
  unknown,
  authenticatedVerified,
  authenticatedNonVerified,
  unauthenticated
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final user = await SqfliteHelper.instance.readUserData();

    debugPrint(user['status'].toString());

    switch (user['status']) {
      case 'initial':
        yield AuthenticationStatus.unauthenticated;
        break;
      case 'login-nonVerified':
        yield AuthenticationStatus.authenticatedNonVerified;
      case 'login-verified':
        yield AuthenticationStatus.authenticatedVerified;
      case 'logout':
        yield AuthenticationStatus.unauthenticated;
        break;
      default:
        yield AuthenticationStatus.unknown;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
