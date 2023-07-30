import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/data%20provider/login_form_api.dart';
import 'package:final_project/Logic/Bloc/Login/auth/login/data/repository/login_form_repository.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../../models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(const LoginFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);

    on<EmailUnfocused>(_onEmailUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);

    on<LoginFormSubmitted>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  void _onEmailUnfocused(EmailUnfocused event, Emitter<LoginFormState> emit) {
    final email = Email.dirty(state.email.value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordUnfocused(
      PasswordUnfocused event, Emitter<LoginFormState> emit) {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
      LoginFormSubmitted event, Emitter<LoginFormState> emit) async {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        email: email,
        password: password,
        isValid: Formz.validate([email, password]),
      ),
    );

    if (state.isValid) {
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        final result = await LoginFormRepository(
            api: LoginFormApi(reqBody: {
          'email': state.email.value,
          'password': state.password.value
        })).getLoginResponse();
        if (result['result'] == 1) {
          // change login response body

          SqfliteHelper.instance.updateMode(
            userName: state.email.value.toString(),
            password: state.password.value.toString(),
            token: result['body']['token'].toString(),
            image: 'null',
            status: result['body']['status id'] == 2
                ? 'login-verified'
                : 'login-nonVerified', // upgrade status form api response
          );

          emit(state.copyWith(
            status: FormzSubmissionStatus.success,
          ));

          var localDB = await SqfliteHelper.instance.readUserData();
          debugPrint(localDB.toString());

          debugPrint('Successfuly login');

          // add routes here - navigator.pop()
        } else {
          debugPrint('login failure');
          await Future.delayed(const Duration(seconds: 1));
          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
          ));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }
}
