part of 'forget_password_bloc.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

// text changed events
class ForgetPasswordEmailChanged extends ForgetPasswordEvent {
  final String email;
  const ForgetPasswordEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class ForgetPasswordConfirmEmailChanged extends ForgetPasswordEvent {
  final String confirmEmail;
  const ForgetPasswordConfirmEmailChanged({required this.confirmEmail});

  @override
  List<Object> get props => [confirmEmail];
}

// unfocused events
class ForgetPasswordEmailUnfocused extends ForgetPasswordEvent {}

class ForgetPasswordConfirmEmailUnfocused extends ForgetPasswordEvent {}

// form submitted event
class ForgetPasswordFormSubmitted extends ForgetPasswordEvent {}
