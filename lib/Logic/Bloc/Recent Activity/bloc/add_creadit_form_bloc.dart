import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/amount.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'add_creadit_form_event.dart';
part 'add_creadit_form_state.dart';

class AddCreaditFormBloc
    extends Bloc<AddCreaditFormEvent, AddCreaditFormState> {
  AddCreaditFormBloc() : super(const AddCreaditFormState()) {
    on<AddCreaditFormDropDownMenuChangedEvent>(
        _onAddCreaditCardDropDownButtonChanged);
    on<AddCreaditFormAmountChangedEvent>(_onAddCreaditFormAmountChanged);

    on<AddCreaditFormSubmittedEvent>(_onAddCreaditFormSubmittedEvent);
    on<AddCreaditFormClearEvent>(_onAddCreaditFormClearEvent);
    on<AddCreaditFormRollBackEvent>(_onAddCreaditFormRollBack);
  }

  Future<void> _onAddCreaditFormAmountChanged(
    AddCreaditFormAmountChangedEvent event,
    Emitter<AddCreaditFormState> emit,
  ) async {
    final amount = Amount.dirty(event.amount);
    emit(state.copyWith(
      amount: amount.isValid ? amount : Amount.pure(event.amount),
      isValid: Formz.validate([amount]),
    ));
  }

  Future<void> _onAddCreaditCardDropDownButtonChanged(
    AddCreaditFormDropDownMenuChangedEvent event,
    Emitter<AddCreaditFormState> emit,
  ) async {
    final menuStatus =
        state.menuStatus == DropDownMenuButtonStatus.dirty ? true : false;
    emit(state.copyWith(
      cardNumber: event.menuItemValue,
      menuStatus: DropDownMenuButtonStatus.dirty,
      isValid: Formz.validate([state.amount]) && menuStatus,
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> _onAddCreaditFormSubmittedEvent(
    AddCreaditFormSubmittedEvent event,
    Emitter<AddCreaditFormState> emit,
  ) async {
    final amount = Amount.dirty(state.amount.value);
    final menuStatus =
        state.menuStatus == DropDownMenuButtonStatus.dirty ? true : false;
    emit(state.copyWith(
      amount: amount,
      isValid: Formz.validate([amount]) && menuStatus,
      cardNumber: state.cardNumber,
      menuStatus: state.menuStatus,
    ));

    debugPrint('Submitted clicked');
    debugPrint(state.status.toString());
    debugPrint(state.isValid.toString());

    if (state.isValid) {
      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ));

      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));

      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));

      await Future.delayed(const Duration(milliseconds: 1200));

      emit(state.copyWith(
        status: FormzSubmissionStatus.initial,
      ));
    }
  }

  Future<void> _onAddCreaditFormClearEvent(
    AddCreaditFormClearEvent event,
    Emitter<AddCreaditFormState> emit,
  ) async {
    emit(state.copyWith(
      amount: const Amount.pure(),
      cardNumber: '',
      isValid: false,
      menuStatus: DropDownMenuButtonStatus.initial,
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> _onAddCreaditFormRollBack(AddCreaditFormRollBackEvent event,
      Emitter<AddCreaditFormState> emit) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.initial,
    ));
  }
}
