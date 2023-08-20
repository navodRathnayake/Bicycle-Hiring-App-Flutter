import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_verify_token_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/data/repository/register_verify_token_repository.dart';
import 'package:final_project/Logic/Bloc/Login/models/number.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

part 'confirm_otp_event.dart';
part 'secure_secure_confirm_otp_state.dart';

class SecureConfirmOTPBloc
    extends Bloc<SecureConfirmOTPEvent, SecureConfirmOTPState> {
  SecureConfirmOTPBloc() : super(const SecureConfirmOTPState()) {
    on<SecureConfirmOTP1Changed>(_onConfirmOTP1Changed);
    on<SecureConfirmOTP2Changed>(_onConfirmOTP2Changed);
    on<SecureConfirmOTP3Changed>(_onConfirmOTP3Changed);
    on<SecureConfirmOTP4Changed>(_onConfirmOTP4Changed);

    on<SecureConfirmOTP1Unfocused>(_onConfirmOTP1Unfocused);
    on<SecureConfirmOTP2Unfocused>(_onCOnfirmOTP2Unfocused);
    on<SecureConfirmOTP3Unfocused>(_onConfirmOTP3Unfocused);
    on<SecureConfirmOTP4Unfocused>(_onConfirmOTP4Unfocused);

    on<SecureSubmitInitial>(_onSecureOTPInitial);
    on<SecureSubmitFailure>(_onSecureOTPFailure);
    on<SecureConfirmOTPFormSubmitted>(_onConfirmOTPFormSubmitted);
  }

  _onConfirmOTP1Changed(SecureConfirmOTP1Changed event,
      Emitter<SecureConfirmOTPState> emit) async {
    final otp1 = Number.dirty(event.otp1);
    emit(state.copyWith(
      otp1: otp1.isValid ? otp1 : Number.pure(event.otp1),
      isValid: Formz.validate([otp1, state.otp2, state.otp3, state.otp4]),
    ));
  }

  _onConfirmOTP2Changed(
      SecureConfirmOTP2Changed event, Emitter<SecureConfirmOTPState> emit) {
    final otp2 = Number.dirty(event.otp2);
    emit(state.copyWith(
      otp2: otp2.isValid ? otp2 : Number.pure(event.otp2),
      isValid: Formz.validate([state.otp1, otp2, state.otp3, state.otp4]),
    ));
  }

  _onConfirmOTP3Changed(
      SecureConfirmOTP3Changed event, Emitter<SecureConfirmOTPState> emit) {
    final otp3 = Number.dirty(event.otp3);
    emit(state.copyWith(
      otp3: otp3.isValid ? otp3 : Number.pure(event.otp3),
      isValid: Formz.validate([state.otp1, state.otp2, otp3, state.otp4]),
    ));
  }

  _onConfirmOTP4Changed(
      SecureConfirmOTP4Changed event, Emitter<SecureConfirmOTPState> emit) {
    final otp4 = Number.dirty(event.otp4);
    emit(state.copyWith(
      otp4: otp4.isValid ? otp4 : Number.pure(event.otp4),
      isValid: Formz.validate([state.otp1, state.otp2, state.otp3, otp4]),
    ));
  }

  _onConfirmOTP1Unfocused(
      SecureConfirmOTP1Unfocused event, Emitter<SecureConfirmOTPState> emit) {
    final otp1 = Number.dirty(state.otp1.value);
    emit(state.copyWith(
      otp1: otp1,
      isValid: Formz.validate([otp1, state.otp2, state.otp3, state.otp4]),
    ));
  }

  _onCOnfirmOTP2Unfocused(
      SecureConfirmOTP2Unfocused event, Emitter<SecureConfirmOTPState> emit) {
    final otp2 = Number.dirty(state.otp2.value);
    emit(state.copyWith(
      otp2: otp2,
      isValid: Formz.validate([state.otp1, otp2, state.otp3, state.otp4]),
    ));
  }

  _onConfirmOTP3Unfocused(
      SecureConfirmOTP3Unfocused event, Emitter<SecureConfirmOTPState> emit) {
    final otp3 = Number.dirty(state.otp3.value);
    emit(state.copyWith(
      otp3: otp3,
      isValid: Formz.validate([state.otp1, state.otp2, otp3, state.otp4]),
    ));
  }

  _onConfirmOTP4Unfocused(
      SecureConfirmOTP4Unfocused event, Emitter<SecureConfirmOTPState> emit) {
    final otp4 = Number.dirty(state.otp4.value);
    emit(state.copyWith(
      otp4: otp4,
      isValid: Formz.validate([state.otp1, state.otp2, state.otp3, otp4]),
    ));
  }

  Future<void> _onSecureOTPFailure(
    SecureSubmitFailure event,
    Emitter<SecureConfirmOTPState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.failure,
    ));
  }

  Future<void> _onSecureOTPInitial(
    SecureSubmitInitial event,
    Emitter<SecureConfirmOTPState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> _onConfirmOTPFormSubmitted(SecureConfirmOTPFormSubmitted event,
      Emitter<SecureConfirmOTPState> emit) async {
    final otp1 = Number.dirty(state.otp1.value);
    final otp2 = Number.dirty(state.otp2.value);
    final otp3 = Number.dirty(state.otp3.value);
    final otp4 = Number.dirty(state.otp4.value);

    emit(state.copyWith(
      otp1: otp1,
      otp2: otp2,
      otp3: otp3,
      otp4: otp4,
      isValid: Formz.validate([otp1, otp2, otp3, otp4]),
    ));

    if (state.isValid) {
      emit(state.copyWith(
        isVerified: true,
      ));

      debugPrint('dsdsdsds');
      // try {
      //   final String otp = state.otp1.value +
      //       state.otp2.value +
      //       state.otp3.value +
      //       state.otp4.value;
      //   emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      //   var userData = await SqfliteHelper.instance.readUserData();
      //   debugPrint(userData.toString());
      //   debugPrint('OTP : $otp');

      //   final result = await RegisterVerifyTokenRepository(
      //       api: RegisterVerifyTokenApi(
      //     reqBody: {
      //       'email': userData['userName'].toString(),
      //       'otp': otp.toString()
      //     },
      //   )).getRegisterResponse();

      //   debugPrint(result.toString());
      //   debugPrint('userd id : ${result['userId']}');

      //   if (result['result'] == 1) {
      //     SqfliteHelper.instance.updateMode(
      //         userName: userData['userName'].toString(),
      //         password: userData['password'].toString(),
      //         token: userData['token'].toString(),
      //         image: 'null',
      //         status: 'login-nonVerified',
      //         db_id: result['userId'].toString());

      //     debugPrint('\n---------------------------------------------------\n');
      //     var localDB = await SqfliteHelper.instance.readUserData();
      //     debugPrint(localDB.toString());
      //     debugPrint('\n---------------------------------------------------\n');

      //     emit(state.copyWith(
      //       status: FormzSubmissionStatus.success,
      //     ));

      //     debugPrint('\nUSER ID: ${result['userId'].toString()}');

      //     var dbstatus = await SqfliteHelper.instance.readUserData();
      //     debugPrint('DB Latest : $dbstatus');

      //     emit(state.copyWith(
      //       status: FormzSubmissionStatus.canceled,
      //     ));

      //     // // trigger login stream
      //     // debugPrint('registered Successfully');
      //     // authenticationRepository.loading();
      //     // await Future.delayed(const Duration(milliseconds: 1200));
      //     // authenticationRepository.nonVerified();
      //   } else {
      //     debugPrint('register Failure');
      //     emit(state.copyWith(
      //       status: FormzSubmissionStatus.failure,
      //     ));

      //     await Future.delayed(const Duration(minutes: 5));

      //     emit(state.copyWith(
      //       status: FormzSubmissionStatus.canceled,
      //     ));
      //   }

      //   emit(state.copyWith(status: FormzSubmissionStatus.success));
      // } catch (e) {
      //   debugPrint(e.toString());
      //   emit(state.copyWith(status: FormzSubmissionStatus.failure));
      // }
    }
  }
}
