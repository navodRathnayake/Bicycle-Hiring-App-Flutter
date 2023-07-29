part of 'confirm_otp_bloc.dart';

class ConfirmOTPEvent extends Equatable {
  const ConfirmOTPEvent();

  @override
  List<Object> get props => [];
}

// text changed
class ConfirmOTP1Changed extends ConfirmOTPEvent {
  final String otp1;
  const ConfirmOTP1Changed({required this.otp1});

  @override
  List<Object> get props => [otp1];
}

class ConfirmOTP2Changed extends ConfirmOTPEvent {
  final String otp2;
  const ConfirmOTP2Changed({required this.otp2});

  @override
  List<Object> get props => [otp2];
}

class ConfirmOTP3Changed extends ConfirmOTPEvent {
  final String otp3;
  const ConfirmOTP3Changed({required this.otp3});

  @override
  List<Object> get props => [otp3];
}

class ConfirmOTP4Changed extends ConfirmOTPEvent {
  final String otp4;
  const ConfirmOTP4Changed({required this.otp4});

  @override
  List<Object> get props => [otp4];
}

// unfocused events
class ConfirmOTP1Unfocused extends ConfirmOTPEvent {}

class ConfirmOTP2Unfocused extends ConfirmOTPEvent {}

class ConfirmOTP3Unfocused extends ConfirmOTPEvent {}

class ConfirmOTP4Unfocused extends ConfirmOTPEvent {}

// form submitted event
class ConfirmOTPFormSubmitted extends ConfirmOTPEvent {}
