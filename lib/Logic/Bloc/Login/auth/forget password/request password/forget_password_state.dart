part of 'forget_password_bloc.dart';

class ForgetPasswordState extends Equatable {
  final Email email;
  final Email confirmEmail;
  final bool isValid;
  final FormzSubmissionStatus status;

  const ForgetPasswordState({
    this.email = const Email.pure(),
    this.confirmEmail = const Email.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  ForgetPasswordState copyWith({
    Email? email,
    Email? confirmEmail,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ForgetPasswordState(
      email: email ?? this.email,
      confirmEmail: confirmEmail ?? this.confirmEmail,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, confirmEmail, isValid, status];
}
