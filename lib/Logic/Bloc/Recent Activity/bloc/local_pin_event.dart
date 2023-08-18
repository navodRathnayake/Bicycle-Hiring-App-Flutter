part of 'local_pin_bloc.dart';

class LocalPinEvent extends Equatable {
  const LocalPinEvent();

  @override
  List<Object> get props => [];
}

// text changed
class LocalPinOTP1Changed extends LocalPinEvent {
  final String otp1;
  const LocalPinOTP1Changed({required this.otp1});

  @override
  List<Object> get props => [otp1];
}

class LocalPinOTP2Changed extends LocalPinEvent {
  final String otp2;
  const LocalPinOTP2Changed({required this.otp2});

  @override
  List<Object> get props => [otp2];
}

class LocalPinOTP3Changed extends LocalPinEvent {
  final String otp3;
  const LocalPinOTP3Changed({required this.otp3});

  @override
  List<Object> get props => [otp3];
}

class LocalPinOTP4Changed extends LocalPinEvent {
  final String otp4;
  const LocalPinOTP4Changed({required this.otp4});

  @override
  List<Object> get props => [otp4];
}

// unfocused events
class LocalPinOTP1Unfocused extends LocalPinEvent {}

class LocalPinOTP2Unfocused extends LocalPinEvent {}

class LocalPinOTP3Unfocused extends LocalPinEvent {}

class LocalPinOTP4Unfocused extends LocalPinEvent {}

// form submitted event
class LocalPinOTPFormSubmitted extends LocalPinEvent {}
