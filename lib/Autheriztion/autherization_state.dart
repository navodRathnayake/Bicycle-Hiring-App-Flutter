part of 'autherization_bloc.dart';

class AutherizationState extends Equatable {
  final AuthenticationStatus status;

  const AutherizationState._({this.status = AuthenticationStatus.initial});
  const AutherizationState.initial() : this._();
  const AutherizationState.loginNonVerified()
      : this._(status: AuthenticationStatus.loginNonVerified);
  const AutherizationState.loginVerified()
      : this._(status: AuthenticationStatus.logingVerified);
  const AutherizationState.logout()
      : this._(status: AuthenticationStatus.logout);
  const AutherizationState.loading()
      : this._(status: AuthenticationStatus.loading);

  @override
  List<Object?> get props => [status];
}
