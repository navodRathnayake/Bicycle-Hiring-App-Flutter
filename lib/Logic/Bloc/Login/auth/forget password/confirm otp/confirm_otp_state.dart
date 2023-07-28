part of 'confirm_otp_bloc.dart';

final class ConfirmOTPState extends Equatable {
  final Number otp1;
  final Number otp2;
  final Number otp3;
  final Number otp4;
  final bool isValid;
  final FormzSubmissionStatus status;

  const ConfirmOTPState({
    this.otp1 = const Number.pure(),
    this.otp2 = const Number.pure(),
    this.otp3 = const Number.pure(),
    this.otp4 = const Number.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  ConfirmOTPState copyWith({
    Number? otp1,
    Number? otp2,
    Number? otp3,
    Number? otp4,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return ConfirmOTPState(
      otp1: otp1 ?? this.otp1,
      otp2: otp2 ?? this.otp2,
      otp3: otp3 ?? this.otp3,
      otp4: otp4 ?? this.otp4,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [otp1, otp2, otp3, otp4, isValid, status];
}
