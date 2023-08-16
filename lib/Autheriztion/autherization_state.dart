part of 'autherization_bloc.dart';

class AutherizationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AutherizationState({required this.status, required this.user});
  const AutherizationState._(
      {this.status = AuthenticationStatus.initial, this.user = User.empty});
  const AutherizationState.initial() : this._();
  const AutherizationState.loginNonVerified()
      : this._(status: AuthenticationStatus.loginNonVerified);
  const AutherizationState.loginVerified({required User user})
      : this._(status: AuthenticationStatus.logingVerified, user: user);
  const AutherizationState.logout()
      : this._(status: AuthenticationStatus.logout);
  const AutherizationState.loading()
      : this._(status: AuthenticationStatus.loading);

  AutherizationState copyWith({
    AuthenticationStatus? status,
    User? user,
  }) {
    return AutherizationState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
