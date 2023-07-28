part of 'register_bloc.dart';

sealed class RegisterFormEvent extends Equatable {
  const RegisterFormEvent();

  @override
  List<Object> get props => [];
}

// text changed events
final class EmailChanged extends RegisterFormEvent {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

final class PasswordChanged extends RegisterFormEvent {
  final String password;
  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

final class ConfirmPasswordChanged extends RegisterFormEvent {
  final String confirmPassword;
  const ConfirmPasswordChanged({required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

// unfocused events
final class EmailUnfocused extends RegisterFormEvent {}

final class PasswordUnfocused extends RegisterFormEvent {}

final class ConfirmPasswordUnfocused extends RegisterFormEvent {}

// form submitted event
final class RegisterFormSubmitted extends RegisterFormEvent {}
