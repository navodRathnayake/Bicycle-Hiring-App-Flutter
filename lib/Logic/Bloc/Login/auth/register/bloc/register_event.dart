part of 'register_bloc.dart';

class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

// text changed events
class EmailChanged extends RegisterFormEvent {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterFormEvent {
  final String password;
  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends RegisterFormEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged({required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

// unfocused events
class EmailUnfocused extends RegisterFormEvent {}

class PasswordUnfocused extends RegisterFormEvent {}

class ConfirmPasswordUnfocused extends RegisterFormEvent {}

// form submitted event
class RegisterFormSubmitted extends RegisterFormEvent {}
