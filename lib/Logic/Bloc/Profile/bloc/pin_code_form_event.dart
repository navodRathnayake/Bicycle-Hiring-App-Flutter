part of 'pin_code_form_bloc.dart';

abstract class PinCodeFormEvent extends Equatable {
  const PinCodeFormEvent();

  @override
  List<Object> get props => [];
}

class PinCodePasswordChanged extends PinCodeFormEvent {
  final String password;
  const PinCodePasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class PinCodeOTP1Changed extends PinCodeFormEvent {
  final String otp1;
  const PinCodeOTP1Changed({required this.otp1});

  @override
  List<Object> get props => [otp1];
}

class PinCodeOTP2Changed extends PinCodeFormEvent {
  final String otp2;
  const PinCodeOTP2Changed({required this.otp2});

  @override
  List<Object> get props => [otp2];
}

class PinCodeOTP3Changed extends PinCodeFormEvent {
  final String otp3;
  const PinCodeOTP3Changed({required this.otp3});

  @override
  List<Object> get props => [otp3];
}

class PinCodeOTP4Changed extends PinCodeFormEvent {
  final String otp4;
  const PinCodeOTP4Changed({required this.otp4});

  @override
  List<Object> get props => [otp4];
}

class PinCodePasswordUnfocused extends PinCodeFormEvent {}

class PinCodeOTP1Unfocused extends PinCodeFormEvent {}

class PinCodeOTP2Unfocused extends PinCodeFormEvent {}

class PinCodeOTP3Unfocused extends PinCodeFormEvent {}

class PinCodeOTP4Unfocused extends PinCodeFormEvent {}

class PinCodeFormSubmitted extends PinCodeFormEvent {}

class PinCodeFormTryAgain extends PinCodeFormEvent {}
