part of 'autherization_bloc.dart';

abstract class AutherizationEvent extends Equatable {
  const AutherizationEvent();

  @override
  List<Object> get props => [];
}

class AutherizationStatusChanged extends AutherizationEvent {
  const AutherizationStatusChanged({required this.status});

  final AuthenticationStatus status;
}

class AutherizationLogoutRequested extends AutherizationEvent {}

class AccountStreamChanged extends AutherizationEvent {
  final AccountStreamStatus status;
  const AccountStreamChanged({required this.status});
}
