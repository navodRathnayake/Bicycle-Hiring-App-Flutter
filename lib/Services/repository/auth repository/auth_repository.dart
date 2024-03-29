library auth_repository;

import 'dart:async';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/data%20provider/login_form_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/repository/login_form_repository.dart';
import 'package:final_project/Logic/Bloc/Login/auth/logout/data/data%20provider/logout_request_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/logout/data/repository/logout_request_repository.dart';
import 'package:final_project/Services/account%20repository/account_repository.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';

enum AuthenticationStatus {
  initial,
  loginNonVerified,
  logingVerified,
  logout,
  loading,
  onService,
  onServiceInitial,
}

class AuthenticationRepository {
  final AccountStreamRepository accountStreamRepository;
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationRepository({required this.accountStreamRepository});

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
      case 'on-service':
        yield AuthenticationStatus.onService;
      case 'on-service-initial':
        yield AuthenticationStatus.onServiceInitial;
      default:
        yield AuthenticationStatus.initial;
    }
    yield* _controller.stream;
  }

  // _controller.add(AuthenticationStatus.loginNonVerified),
  Future<void> rollBack() async {
    _controller.add(AuthenticationStatus.loginNonVerified);
  }

  Future<AuthenticationStatus> getCurrentAuthenticationStatus() async {
    final user = await SqfliteHelper.instance.readUserData();
    late AuthenticationStatus currentStatus;
    switch (user['status']) {
      case 'initial':
        currentStatus = AuthenticationStatus.initial;
        break;
      case 'login-nonVerified':
        currentStatus = AuthenticationStatus.loginNonVerified;
        break;
      case 'login-verified':
        await accountStreamRepository.streamIn();
        currentStatus = AuthenticationStatus.logingVerified;
        await accountStreamRepository.streamIdel();
        break;
      case 'logout':
        currentStatus = AuthenticationStatus.logout;
        break;
      case 'on-service':
        await accountStreamRepository.streamIn();
        currentStatus = AuthenticationStatus.onService;
        await accountStreamRepository.streamIdel();
        break;
      default:
        currentStatus = AuthenticationStatus.initial;
        break;
    }
    return currentStatus;
  }

  Future<void> loading() async {
    await accountStreamRepository.streamIn();
    _controller.add(AuthenticationStatus.loading);
    await accountStreamRepository.streamIdel();
  }

  Future<void> verified() async {
    await accountStreamRepository.streamIn();
    _controller.add(AuthenticationStatus.logingVerified);
    await accountStreamRepository.streamIdel();
  }

  Future<void> nonVerified() async {
    _controller.add(AuthenticationStatus.loginNonVerified);
  }

  Future<void> onService() async {
    await accountStreamRepository.streamIn();
    _controller.add(AuthenticationStatus.onService);
    await accountStreamRepository.streamIdel();
  }

  Future<void> onServiceInitial() async {
    await accountStreamRepository.streamIn();
    _controller.add(AuthenticationStatus.onServiceInitial);
    await accountStreamRepository.streamIdel();
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('\n\n\nAuth loging\n\n\n');
      final result = await LoginFormRepository(
              api:
                  LoginFormApi(reqBody: {'email': email, 'password': password}))
          .getLoginResponse();

      debugPrint('ssdasdadsadasddadsdd');

      debugPrint(result['body']['status id'].toString());

      String userStatus = result['body']['status id'].toString();
      debugPrint(userStatus);

      if (userStatus.toString().contains('1') ||
          userStatus.toString().contains('2')) {
        // change login response body
        debugPrint('popopopop');
        debugPrint(result['body'].toString());

        SqfliteHelper.instance.updateMode(
            userName: email.toString(),
            password: password.toString(),
            token: result['body']['token'].toString(),
            image: 'null',
            status: result['body']['statusId'].toString() == '2'
                ? 'login-verified'
                : 'login-nonVerified',
            db_id: result['body']['userID'] // upgrade status form api response
            );

        var localDB = await SqfliteHelper.instance.readUserData();
        debugPrint(localDB.toString());

        debugPrint('Successfuly login');
        debugPrint(result['body'].toString());

        await accountStreamRepository.streamIn();

        if (result['body']['status id'] == '1') {
          _controller.add(AuthenticationStatus.loginNonVerified);
          debugPrint('AUTH STREAMER : loginNonVerified');
        } else if (result['body']['status id'] == '2') {
          _controller.add(AuthenticationStatus.logingVerified);
          debugPrint('AUTH STREAMER : loginVerified');
        } else {
          _controller.add(AuthenticationStatus.logout);
          debugPrint('AUTH STREAMER : logout');
        }

        await accountStreamRepository.streamIdel();

        // add routes here - navigator.pop()
      } else {
        debugPrint('login failure');
        await Future.delayed(const Duration(seconds: 1));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void logOut() async {
    try {
      final result = await LogoutRequestedRepository(api: LogoutRequestedApi())
          .getRegisterResponse();

      debugPrint(result.toString());

      if (result['result'] == 1) {
        SqfliteHelper.instance.updateLogout();

        debugPrint('\n---------------------------------------------------\n');
        var localDB = await SqfliteHelper.instance.readUserData();
        debugPrint(localDB.toString());
        debugPrint('\n---------------------------------------------------\n');

        _controller.add(AuthenticationStatus.logout);
      } else {
        debugPrint('logout Failure');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void dispose() => _controller.close();
}
