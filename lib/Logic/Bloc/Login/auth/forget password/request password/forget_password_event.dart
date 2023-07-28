part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

// text changed events
final class ForgetPasswordEmailChanged extends ForgetPasswordEvent {
  final String email;
  const ForgetPasswordEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

final class ForgetPasswordConfirmEmailChanged extends ForgetPasswordEvent {
  final String confirmEmail;
  const ForgetPasswordConfirmEmailChanged({required this.confirmEmail});

  @override
  List<Object> get props => [confirmEmail];
}

// unfocused events
final class ForgetPasswordEmailUnfocused extends ForgetPasswordEvent {}

final class ForgetPasswordConfirmEmailUnfocused extends ForgetPasswordEvent {}

// form submitted event
final class ForgetPasswordFormSubmitted extends ForgetPasswordEvent {}
