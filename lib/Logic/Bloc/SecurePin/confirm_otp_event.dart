part of 'secure_confirm_otp_bloc.dart';

class SecureConfirmOTPEvent extends Equatable {
  const SecureConfirmOTPEvent();

  @override
  List<Object> get props => [];
}

// text changed
class SecureConfirmOTP1Changed extends SecureConfirmOTPEvent {
  final String otp1;
  const SecureConfirmOTP1Changed({required this.otp1});

  @override
  List<Object> get props => [otp1];
}

class SecureConfirmOTP2Changed extends SecureConfirmOTPEvent {
  final String otp2;
  const SecureConfirmOTP2Changed({required this.otp2});

  @override
  List<Object> get props => [otp2];
}

class SecureConfirmOTP3Changed extends SecureConfirmOTPEvent {
  final String otp3;
  const SecureConfirmOTP3Changed({required this.otp3});

  @override
  List<Object> get props => [otp3];
}

class SecureConfirmOTP4Changed extends SecureConfirmOTPEvent {
  final String otp4;
  const SecureConfirmOTP4Changed({required this.otp4});

  @override
  List<Object> get props => [otp4];
}

// unfocused events
class SecureConfirmOTP1Unfocused extends SecureConfirmOTPEvent {}

class SecureConfirmOTP2Unfocused extends SecureConfirmOTPEvent {}

class SecureConfirmOTP3Unfocused extends SecureConfirmOTPEvent {}

class SecureConfirmOTP4Unfocused extends SecureConfirmOTPEvent {}

// form submitted event
class SecureConfirmOTPFormSubmitted extends SecureConfirmOTPEvent {}

class SecureSubmitFailure extends SecureConfirmOTPEvent {}

class SecureSubmitInitial extends SecureConfirmOTPEvent {}
