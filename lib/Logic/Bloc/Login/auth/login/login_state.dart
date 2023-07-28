part of 'login_bloc.dart';

final class LoginFormState extends Equatable {
  final Email email;
  final Password password;
  final bool isValid;
  final FormzSubmissionStatus status;

  const LoginFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  LoginFormState copyWith(
      {Email? email,
      Password? password,
      bool? isValid,
      FormzSubmissionStatus? status}) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, password, isValid, status];
}
