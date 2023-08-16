import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/model/user_model.dart';
import 'package:final_project/Services/account%20repository/account_repository.dart';
import 'package:final_project/Services/data/data%20provider/user_get_api.dart';
import 'package:final_project/Services/data/repository%20provider/user_get_repository.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'autherization_event.dart';
part 'autherization_state.dart';

class AutherizationBloc extends Bloc<AutherizationEvent, AutherizationState> {
  final AuthenticationRepository _authenticationRepository;
  final AccountStreamRepository accountStreamRepository;
  // final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  late StreamSubscription<AccountStreamStatus> _accountStreamSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  AutherizationBloc({
    required AuthenticationRepository authenticationRepository,
    required this.accountStreamRepository,
    // required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        // _userRepository = userRepository,
        super(const AutherizationState.initial()) {
    on<AutherizationStatusChanged>(_onAuthenticationStatusChanged);
    on<AutherizationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AccountStreamChanged>(_onAccountStreamChanged);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AutherizationStatusChanged(status: status)),
    );

    _accountStreamSubscription =
        accountStreamRepository.status.listen((status) {
      return add(AccountStreamChanged(status: status));
    });
  }

  Future<void> _onAccountStreamChanged(
    AccountStreamChanged event,
    Emitter<AutherizationState> emit,
  ) async {
    debugPrint('sasasas');
    final User user = await _getUser();
    debugPrint(user.toString());

    switch (event.status) {
      case AccountStreamStatus.streamIdel:
        state.copyWith(user: user);
        debugPrint('BLOC : IDEL');
        break;
      case AccountStreamStatus.streamIn:
        state.copyWith(user: user);
        debugPrint(user.toString());
        debugPrint('BLOC : STREAM IN');
      case AccountStreamStatus.streamOut:
        state.copyWith(user: user);
        debugPrint('BLOC : STREAM OUT');
      default:
        state.copyWith(user: user);
        debugPrint('BLOC : USER USER');
    }
  }

  Future<User> _getUser() async {
    debugPrint('uyfffhfk,j');
    try {
      final response =
          await UserGetRepository(api: UserGetApi()).getUserResponse();
      debugPrint(response.toString());

      debugPrint(
          'USER NAME : ${response['body']['users']['firstName']!.toString()}');
      int points = response['body']['users']['points'] == null
          ? 0
          : int.parse(response['body']['users']['points']!.toString());

      if (response['result'] == 1) {
        User user = User(
          userName: response['body']['users']['firstName']!.toString(),
          password: response['body']['users']['password']!.toString(),
          email: response['body']['users']['email']!.toString(),
          image: '',
          nic: response['body']['users']['nic']!.toString(),
          bloodGroup: response['body']['users']['bloodGroup']!.toString(),
          points: points,
        );
        debugPrint('User has Updated!');
        debugPrint('USER MODEL : ${user.toString()}');
        debugPrint('USER EMAIL : ${user.email}');
        debugPrint('USER POINTS : ${user.points}');
        debugPrint('USER NIC : ${user.nic}');
        return user;
      } else {
        debugPrint('user cant updated!');
        return User.empty;
      }
    } catch (e) {
      debugPrint('user got error');
      debugPrint(e.toString());
      return User.empty;
    }
  }

  Future<void> _onAuthenticationStatusChanged(
    AutherizationStatusChanged event,
    Emitter<AutherizationState> emit,
  ) async {
    final User user = await _getUser();
    switch (event.status) {
      case AuthenticationStatus.initial:
        return emit(const AutherizationState.initial());
      case AuthenticationStatus.loginNonVerified:
        accountStreamRepository.streamIn();
        return emit(const AutherizationState.loginNonVerified());
      case AuthenticationStatus.logingVerified:
        accountStreamRepository.streamIn();
        return emit(AutherizationState.loginVerified(user: user));
      case AuthenticationStatus.logout:
        return emit(const AutherizationState.logout());
      case AuthenticationStatus.loading:
        accountStreamRepository.streamOut();
        return emit(const AutherizationState.loading());
    }
  }

  void _onAuthenticationLogoutRequested(
    AutherizationLogoutRequested event,
    Emitter<AutherizationState> emit,
  ) async {
    _authenticationRepository.loading();
    await Future.delayed(const Duration(milliseconds: 1200));
    _authenticationRepository.logOut();
  }

  // Future<User?> _tryGetUser() async {
  //   try {
  //     final user = await _userRepository.getUser();
  //     return user;
  //   } catch (_) {
  //     return null;
  //   }
  // }
}
