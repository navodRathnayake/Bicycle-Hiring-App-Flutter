part of 'login_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

// text changed events
final class EmailChanged extends LoginFormEvent {
  const EmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends LoginFormEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

// unfocused events
final class EmailUnfocused extends LoginFormEvent {}

final class PasswordUnfocused extends LoginFormEvent {}

// form submitted event
final class LoginFormSubmitted extends LoginFormEvent {}
