import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/models/models.dart';
import 'package:final_project/Logic/Bloc/Login/models/password.dart';
import 'package:formz/formz.dart';

part 'pin_code_form_event.dart';
part 'pin_code_form_state.dart';

class PinCodeFormBloc extends Bloc<PinCodeFormEvent, PinCodeFormState> {
  PinCodeFormBloc() : super(const PinCodeFormState()) {
    on<PinCodePasswordChanged>(_onPinCodePasswordChanged);
    on<PinCodeOTP1Changed>(_onPinCodeOTP1Changed);
    on<PinCodeOTP2Changed>(_onPinCodeOTP2Changed);
    on<PinCodeOTP3Changed>(_onPinCodeOTP3Changed);
    on<PinCodeOTP4Changed>(_onPinCodeOTP4Changed);

    on<PinCodePasswordUnfocused>(_onPinCodePasswordUnfocused);
    on<PinCodeOTP1Unfocused>(_onPinCodeOTP1Unfocused);
    on<PinCodeOTP2Unfocused>(_onPinCodeOTP2Unfocused);
    on<PinCodeOTP3Unfocused>(_onPinCodeOTP3Unfocused);
    on<PinCodeOTP4Unfocused>(_onPinCodeOTP4Unfocused);

    on<PinCodeFormSubmitted>(_onPinCodeFormSubmitted);
  }

  Future<void> _onPinCodePasswordChanged(
    PinCodePasswordChanged event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate(
            [password, state.otp1, state.otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP1Changed(
    PinCodeOTP1Changed event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp1 = Number.dirty(event.otp1);
    emit(state.copyWith(
        otp1: otp1.isValid ? otp1 : Number.pure(event.otp1),
        isValid: Formz.validate(
            [state.password, otp1, state.otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP2Changed(
    PinCodeOTP2Changed event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp2 = Number.dirty(event.otp2);
    emit(state.copyWith(
        otp2: otp2.isValid ? otp2 : Number.pure(event.otp2),
        isValid: Formz.validate(
            [state.password, state.otp1, otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP3Changed(
    PinCodeOTP3Changed event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp3 = Number.dirty(event.otp3);
    emit(state.copyWith(
        otp3: otp3.isValid ? otp3 : Number.pure(event.otp3),
        isValid: Formz.validate(
            [state.password, state.otp1, state.otp2, otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP4Changed(
    PinCodeOTP4Changed event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp4 = Number.dirty(event.otp4);
    emit(state.copyWith(
        otp4: otp4.isValid ? otp4 : Number.pure(event.otp4),
        isValid: Formz.validate(
            [state.password, state.otp1, state.otp2, state.otp3, otp4])));
  }

  Future<void> _onPinCodePasswordUnfocused(
    PinCodePasswordUnfocused event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate(
            [password, state.otp1, state.otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP1Unfocused(
    PinCodeOTP1Unfocused event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp1 = Number.dirty(state.otp1.value);
    emit(state.copyWith(
        otp1: otp1,
        isValid: Formz.validate(
            [state.password, otp1, state.otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP2Unfocused(
    PinCodeOTP2Unfocused event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp2 = Number.dirty(state.otp2.value);
    emit(state.copyWith(
        otp2: otp2,
        isValid: Formz.validate(
            [state.password, state.otp1, otp2, state.otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP3Unfocused(
    PinCodeOTP3Unfocused event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp3 = Number.dirty(state.otp3.value);
    emit(state.copyWith(
        otp3: otp3,
        isValid: Formz.validate(
            [state.password, state.otp1, state.otp2, otp3, state.otp4])));
  }

  Future<void> _onPinCodeOTP4Unfocused(
    PinCodeOTP4Unfocused event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final otp4 = Number.dirty(state.otp4.value);
    emit(state.copyWith(
        otp4: otp4,
        isValid: Formz.validate(
            [state.password, state.otp1, state.otp2, state.otp3, otp4])));
  }

  Future<void> _onPinCodeFormSubmitted(
    PinCodeFormSubmitted event,
    Emitter<PinCodeFormState> emit,
  ) async {
    final password = Password.dirty(state.password.value);
    final otp1 = Number.dirty(state.otp1.value);
    final otp2 = Number.dirty(state.otp2.value);
    final otp3 = Number.dirty(state.otp3.value);
    final otp4 = Number.dirty(state.otp4.value);

    emit(state.copyWith(
        password: password,
        otp1: otp1,
        otp2: otp2,
        otp3: otp3,
        otp4: otp4,
        isValid: Formz.validate([password, otp1, otp2, otp3, otp4])));

    if (state.isValid) {}
  }
}
