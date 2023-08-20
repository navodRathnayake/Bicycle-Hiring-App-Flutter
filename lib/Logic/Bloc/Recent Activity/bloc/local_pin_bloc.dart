import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/models/number.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

part 'local_pin_event.dart';
part 'local_pin_state.dart';

class LocalPinBloc extends Bloc<LocalPinEvent, LocalPinState> {
  LocalPinBloc() : super(const LocalPinState()) {
    on<LocalPinEvent>((event, emit) {
      on<LocalPinOTP1Changed>(_onLocalPinOTP1Changed);
      on<LocalPinOTP2Changed>(_onLocalPinOTP2Changed);
      on<LocalPinOTP3Changed>(_onLocalPinOTP3Changed);
      on<LocalPinOTP4Changed>(_onLocalPinOTP4Changed);

      // on<LocalPinOTP1Unfocused>(_onLocalPinOTP1Unfocused);
      // on<LocalPinOTP2Unfocused>(_onLocalPinOTP2Unfocused);
      // on<LocalPinOTP3Unfocused>(_onLocalPinOTP3Unfocused);
      // on<LocalPinOTP4Unfocused>(_onLocalPinOTP4Unfocused);

      on<LocalPinOTPFormSubmitted>(_onLocalPinOTPFormSubmitted);
    });
  }
  _onLocalPinOTP1Changed(
      LocalPinOTP1Changed event, Emitter<LocalPinState> emit) {
    final otp1 = Number.dirty(event.otp1);
    emit(state.copyWith(
      otp1: otp1.isValid ? otp1 : Number.pure(event.otp1),
      isValid: Formz.validate([otp1, state.otp2, state.otp3, state.otp4]),
    ));
  }

  _onLocalPinOTP2Changed(
      LocalPinOTP2Changed event, Emitter<LocalPinState> emit) {
    final otp2 = Number.dirty(event.otp2);
    emit(state.copyWith(
      otp2: otp2.isValid ? otp2 : Number.pure(event.otp2),
      isValid: Formz.validate([state.otp1, otp2, state.otp3, state.otp4]),
    ));
  }

  _onLocalPinOTP3Changed(
      LocalPinOTP3Changed event, Emitter<LocalPinState> emit) {
    final otp3 = Number.dirty(event.otp3);
    emit(state.copyWith(
      otp3: otp3.isValid ? otp3 : Number.pure(event.otp3),
      isValid: Formz.validate([state.otp1, state.otp2, otp3, state.otp4]),
    ));
  }

  _onLocalPinOTP4Changed(
      LocalPinOTP4Changed event, Emitter<LocalPinState> emit) {
    final otp4 = Number.dirty(event.otp4);
    emit(state.copyWith(
      otp4: otp4.isValid ? otp4 : Number.pure(event.otp4),
      isValid: Formz.validate([state.otp1, state.otp2, state.otp3, otp4]),
    ));
  }

  // _onLocalPinOTP1Unfocused(
  //     LocalPinOTP1Unfocused event, Emitter<LocalPinState> emit) {
  //   final otp1 = Number.dirty(state.otp1.value);
  //   emit(state.copyWith(
  //     otp1: otp1,
  //     isValid: Formz.validate([otp1, state.otp2, state.otp3, state.otp4]),
  //   ));
  // }

  // _onLocalPinOTP2Unfocused(
  //     LocalPinOTP2Unfocused event, Emitter<LocalPinState> emit) {
  //   final otp2 = Number.dirty(state.otp2.value);
  //   emit(state.copyWith(
  //     otp2: otp2,
  //     isValid: Formz.validate([state.otp1, otp2, state.otp3, state.otp4]),
  //   ));
  // }

  // _onLocalPinOTP3Unfocused(
  //     LocalPinOTP3Unfocused event, Emitter<LocalPinState> emit) {
  //   final otp3 = Number.dirty(state.otp3.value);
  //   emit(state.copyWith(
  //     otp3: otp3,
  //     isValid: Formz.validate([state.otp1, state.otp2, otp3, state.otp4]),
  //   ));
  // }

  // _onLocalPinOTP4Unfocused(
  //     LocalPinOTP4Unfocused event, Emitter<LocalPinState> emit) {
  //   final otp4 = Number.dirty(state.otp4.value);
  //   emit(state.copyWith(
  //     otp4: otp4,
  //     isValid: Formz.validate([state.otp1, state.otp2, state.otp3, otp4]),
  //   ));
  // }

  Future<void> _onLocalPinOTPFormSubmitted(
      LocalPinOTPFormSubmitted event, Emitter<LocalPinState> emit) async {
    // final otp1 = Number.dirty(state.otp1.value);
    // final otp2 = Number.dirty(state.otp2.value);
    // final otp3 = Number.dirty(state.otp3.value);
    // final otp4 = Number.dirty(state.otp4.value);

    // emit(state.copyWith(
    //   otp1: otp1,
    //   otp2: otp2,
    //   otp3: otp3,
    //   otp4: otp4,
    //   isValid: Formz.validate([otp1, otp2, otp3, otp4]),
    // ));

    if (state.isValid) {
      try {
        // final String otp = state.otp1.value +
        //     state.otp2.value +
        //     state.otp3.value +
        //     state.otp4.value;
        // emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

        // var userData = await SqfliteHelper.instance.readUserData();
        // debugPrint(userData.toString());
        // debugPrint('OTP : $otp');

        // final result = await RegisterVerifyTokenRepository(
        //     api: RegisterVerifyTokenApi(
        //   reqBody: {
        //     'email': userData['userName'].toString(),
        //     'otp': otp.toString()
        //   },
        // )).getRegisterResponse();

        // debugPrint(result.toString());
        // debugPrint('userd id : ${result['userId']}');

        // if (result['result'] == 1) {
        //   SqfliteHelper.instance.updateMode(
        //       userName: userData['userName'].toString(),
        //       password: userData['password'].toString(),
        //       token: userData['token'].toString(),
        //       image: 'null',
        //       status: 'login-nonVerified',
        //       db_id: result['userId'].toString());

        //   debugPrint('\n---------------------------------------------------\n');
        //   var localDB = await SqfliteHelper.instance.readUserData();
        //   debugPrint(localDB.toString());
        //   debugPrint('\n---------------------------------------------------\n');

        //   emit(state.copyWith(
        //     status: FormzSubmissionStatus.success,
        //   ));

        //   debugPrint('\nUSER ID: ${result['userId'].toString()}');

        //   var dbstatus = await SqfliteHelper.instance.readUserData();
        //   debugPrint('DB Latest : $dbstatus');

        //   emit(state.copyWith(
        //     status: FormzSubmissionStatus.canceled,
        //   ));

        //   // trigger login stream
        //   debugPrint('registered Successfully');
        //   authenticationRepository.loading();
        //   await Future.delayed(const Duration(milliseconds: 1200));
        //   authenticationRepository.nonVerified();
        // } else {
        //   debugPrint('register Failure');
        //   emit(state.copyWith(
        //     status: FormzSubmissionStatus.failure,
        //   ));

        //   await Future.delayed(const Duration(minutes: 5));

        //   emit(state.copyWith(
        //     status: FormzSubmissionStatus.canceled,
        //   ));
        // }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        debugPrint('sdsadsadsdada -cdsdf sddd dqdwq');
        debugPrint(e.toString());
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
