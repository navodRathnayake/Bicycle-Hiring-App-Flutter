import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:final_project/Services/repository/user%20repository/user_repository.dart';

part 'autherization_event.dart';
part 'autherization_state.dart';

class AutherizationBloc extends Bloc<AutherizationEvent, AutherizationState> {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  AutherizationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AutherizationState.initial()) {
    on<AutherizationStatusChanged>(_onAuthenticationStatusChanged);
    on<AutherizationLogoutRequested>(_onAuthenticationLogoutRequested);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AutherizationStatusChanged(status: status)),
    );
  }

  Future<void> _onAuthenticationStatusChanged(
    AutherizationStatusChanged event,
    Emitter<AutherizationState> emit,
  ) async {
    // switch (event.status) {
    //   case AuthenticationStatus.:
    //     return emit(const AuthenticationState.unauthenticated());
    //   case AuthenticationStatus.authenticated:
    //     final user = await _tryGetUser();
    //     return emit(
    //       user != null
    //           ? AuthenticationState.authenticated(user)
    //           : const AuthenticationState.unauthenticated(),
    //     );
    //   case AuthenticationStatus.unknown:
    //     return emit(const AuthenticationState.unknown());
    // }
  }

  void _onAuthenticationLogoutRequested(
    AutherizationLogoutRequested event,
    Emitter<AutherizationState> emit,
  ) {
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
