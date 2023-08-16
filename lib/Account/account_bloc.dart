import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/model/user_model.dart';
import 'package:final_project/Services/account%20repository/account_repository.dart';
import 'package:final_project/Services/data/data%20provider/user_get_api.dart';
import 'package:final_project/Services/data/repository%20provider/user_get_repository.dart';
import 'package:flutter/foundation.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountStreamRepository _accountStreamRepository;
  late StreamSubscription<AccountStreamStatus> _accountStreamSubscription;

  @override
  Future<void> close() {
    _accountStreamSubscription.cancel();
    return super.close();
  }

  AccountBloc({
    required AccountStreamRepository accountStreamRepository,
  })  : _accountStreamRepository = accountStreamRepository,
        super(const AccountState()) {
    on<AccountStreamChanged>(_onAccountStreamChanged);
    _accountStreamSubscription = _accountStreamRepository.status.listen(
      (status) {
        debugPrint('Stream has registerd');
        add(AccountStreamChanged(status: status));
      },
    );
  }

  Future<void> _onAccountStreamChanged(
    AccountStreamChanged event,
    Emitter<AccountState> emit,
  ) async {
    debugPrint('sasasas');
    final User user = await _getUser();
    debugPrint(user.toString());

    switch (event.status) {
      case AccountStreamStatus.streamIdel:
        emit(AccountState(user: user));
        debugPrint('BLOC : IDEL');
        break;
      case AccountStreamStatus.streamIn:
        final User user = await _getUser();
        debugPrint(user.toString());
        emit(AccountState(user: user));

        debugPrint('BLOC : STREAM IN');
      case AccountStreamStatus.streamOut:
        emit(AccountState(user: user));
        debugPrint('BLOC : STREAM OUT');
      default:
        emit(AccountState(user: user));
        debugPrint('BLOC : USER USER');
    }
  }

  Future<User> _getUser() async {
    debugPrint('uyfffhfk,j');
    try {
      final response =
          await UserGetRepository(api: UserGetApi()).getUserResponse();
      debugPrint(response.toString());

      if (response['result'] == 1) {
        User user = const User(
          userName: '',
          password: '',
          image: '',
          nic: '',
          points: 0,
          bloodGroup: '',
          email: '',
        );
        debugPrint('User has Updated!');
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
}
