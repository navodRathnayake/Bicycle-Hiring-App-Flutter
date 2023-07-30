part of 'login_bloc.dart';

class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

// text changed events
class EmailChanged extends LoginFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

// unfocused events
class EmailUnfocused extends LoginFormEvent {}

class PasswordUnfocused extends LoginFormEvent {}

// form submitted event
class LoginFormSubmitted extends LoginFormEvent {}
