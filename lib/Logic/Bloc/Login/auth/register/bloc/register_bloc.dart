import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/data/data%20provider/register_form_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/register/data/repository/register_form_repository.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../../models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  RegisterFormBloc() : super(const RegisterFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);

    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<ConfirmPasswordUnfocused>(_onConfirmPasswordUnfocused);

    on<RegisterFormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<RegisterFormState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([email, state.password, state.confirmPassword]),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<RegisterFormState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate([password, state.email, state.confirmPassword]),
      ),
    );
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<RegisterFormState> emit) {
    final confirmPassword = Password.dirty(event.confirmPassword);
    emit(state.copyWith(
      confirmPassword: confirmPassword.isValid
          ? confirmPassword
          : Password.pure(event.confirmPassword),
      isValid: Formz.validate([confirmPassword, state.password, state.email]),
    ));
  }

  void _onEmailUnfocused(
      EmailUnfocused event, Emitter<RegisterFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password, state.confirmPassword]),
    ));
  }

  void _onPasswordUnfocused(
      PasswordUnfocused event, Emitter<RegisterFormState> emit) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email, state.confirmPassword]),
    ));
  }

  void _onConfirmPasswordUnfocused(
      ConfirmPasswordUnfocused event, Emitter<RegisterFormState> emit) {
    final confirmPassword = Password.dirty(state.confirmPassword.value);
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate([confirmPassword, state.email, state.password]),
    ));
  }

  Future<void> _onFormSubmitted(
      RegisterFormSubmitted event, Emitter<RegisterFormState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = Password.dirty(state.confirmPassword.value);

    emit(state.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([email, password, confirmPassword]),
    ));

    if (state.isValid) {
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

        final result = await RegisterFormRepository(
            api: RegisterFormApi(reqBody: {
          'email': state.email.value.toString(),
          'password': state.password.value.toString(),
          'comfirmPassword': state.confirmPassword.value.toString(),
        })).getRegisterResponse();

        debugPrint(result.toString());

        if (result['result'] == 1) {
          SqfliteHelper.instance.updateMode(
            userName: state.email.value.toString(),
            password: state.password.value.toString(),
            token: result['body']['token'].toString(),
            image: 'null',
            status: 'initial',
          );

          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
          ));

          var localDB = await SqfliteHelper.instance.readUserData();
          debugPrint(localDB.toString());

          debugPrint('Successfuly login');

          emit(state.copyWith(
            status: FormzSubmissionStatus.canceled,
          ));

          // trigger login stream
        } else {
          debugPrint('Login Failure');
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
          ));

          await Future.delayed(const Duration(minutes: 5));

          emit(state.copyWith(
            status: FormzSubmissionStatus.canceled,
          ));
        }

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
