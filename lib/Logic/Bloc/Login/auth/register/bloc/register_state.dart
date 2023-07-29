part of 'register_bloc.dart';

class RegisterFormState extends Equatable {
  final Email email;
  final Password password;
  final Password confirmPassword;
  final bool isValid;
  final FormzSubmissionStatus status;

  const RegisterFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const Password.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  RegisterFormState copyWith({
    Email? email,
    Password? password,
    Password? confirmPassword,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, confirmPassword, status, isValid];
}
