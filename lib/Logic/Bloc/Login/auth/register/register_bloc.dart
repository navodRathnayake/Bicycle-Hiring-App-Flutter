import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/models.dart';

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
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
