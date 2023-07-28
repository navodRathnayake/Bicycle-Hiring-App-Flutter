import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/models/models.dart';
import 'package:formz/formz.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordRequestBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordRequestBloc() : super(const ForgetPasswordState()) {
    on<ForgetPasswordEmailChanged>(_onForgetPasswordEmailChanged);
    on<ForgetPasswordConfirmEmailChanged>(_onForgetPasswordConfirmEmailChanged);

    on<ForgetPasswordEmailUnfocused>(_onForgetPasswordEmailUnfocused);
    on<ForgetPasswordConfirmEmailUnfocused>(
        _onForgetPasswordConfirmEmailUnfocused);

    on<ForgetPasswordFormSubmitted>(_onForgetPasswordFormSubmitted);
  }

  void _onForgetPasswordEmailChanged(
      ForgetPasswordEmailChanged event, Emitter<ForgetPasswordState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email.isValid ? email : Email.pure(event.email),
        isValid: Formz.validate([email, state.confirmEmail])));
  }

  void _onForgetPasswordConfirmEmailChanged(
      ForgetPasswordConfirmEmailChanged event,
      Emitter<ForgetPasswordState> emit) {
    final confirmEmail = Email.dirty(event.confirmEmail);
    emit(state.copyWith(
        confirmEmail: confirmEmail.isValid
            ? confirmEmail
            : Email.pure(event.confirmEmail)));
  }

  void _onForgetPasswordEmailUnfocused(
      ForgetPasswordEmailUnfocused event, Emitter<ForgetPasswordState> emit) {
    final email = Email.dirty(state.email.value);
    emit(state.copyWith(
      email: email,
      confirmEmail: state.confirmEmail,
      isValid: Formz.validate([email, state.confirmEmail]),
    ));
  }

  void _onForgetPasswordConfirmEmailUnfocused(
      ForgetPasswordConfirmEmailUnfocused event,
      Emitter<ForgetPasswordState> emit) {
    final confirmEmail = Email.dirty(state.confirmEmail.value);
    emit(state.copyWith(
        email: state.email,
        confirmEmail: confirmEmail,
        isValid: Formz.validate([state.email, confirmEmail])));
  }

  Future<void> _onForgetPasswordFormSubmitted(ForgetPasswordFormSubmitted event,
      Emitter<ForgetPasswordState> emit) async {
    final email = Email.dirty(state.email.value);
    final confirmEmail = Email.dirty(state.confirmEmail.value);

    emit(state.copyWith(
      email: email,
      confirmEmail: confirmEmail,
      isValid: Formz.validate([email, confirmEmail]),
    ));

    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
  }
}
