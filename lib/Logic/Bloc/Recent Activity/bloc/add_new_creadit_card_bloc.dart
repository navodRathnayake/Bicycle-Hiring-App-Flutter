import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/models/models.dart';
import 'package:final_project/Logic/Bloc/OCR/data/data%20provider/update_user_status_api.dart';
import 'package:final_project/Logic/Bloc/OCR/data/repository%20provider/update_user_status_repository.dart';
import 'package:final_project/Logic/Bloc/Profile/bloc/account_completion_bloc.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/creadit_card_holder_name.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/creadit_card_number.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/expiry_date.dart';
import 'package:final_project/Services/database/sqlite_helper.dart';
import 'package:final_project/Services/repository/auth%20repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'add_new_creadit_card_event.dart';
part 'add_new_creadit_card_state.dart';

class AddNewCreaditCardBloc
    extends Bloc<AddNewCreaditCardEvent, AddNewCreaditCardState> {
  final AuthenticationRepository authenticationRepository;
  final AccountCompletionBloc accountCompletionBloc;
  AddNewCreaditCardBloc(
      {required this.authenticationRepository,
      required this.accountCompletionBloc})
      : super(const AddNewCreaditCardState()) {
    on<AddNewCreaditCardNumberChanged>(_onAddNewCreaditCardNumberChanged);
    on<AddNewCreaditCardExpiryDateChanged>(
        _onAddNewCreaditCardExpiryDateChanged);
    on<AddNewCreaditCardCVVChanged>(_onAddNewCreaditCardCVVChanged);
    on<AddNewCreaditCardHolderNameChanged>(
        _onAddNewCreaditCardCardHolderChanged);

    on<AddNewCreaditCardFormSubmittedEvent>(_onAddNewCreaditCardFormSubmitted);
    on<AddNewCreaditCardFormRollBackEvent>(_onAddNewCreaditCardFormRollBack);
  }

  Future<void> _onAddNewCreaditCardNumberChanged(
    AddNewCreaditCardNumberChanged event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    final cardNumber = CreaditCardNumber.dirty(event.cardNumber);
    emit(state.copyWith(
        cardNumber: cardNumber.isValid
            ? cardNumber
            : CreaditCardNumber.pure(event.cardNumber),
        isValid: Formz.validate(
            [cardNumber, state.expiryDate, state.cvv, state.holderName])));
  }

  Future<void> _onAddNewCreaditCardExpiryDateChanged(
    AddNewCreaditCardExpiryDateChanged event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    final expiryDate = ExpiryDate.dirty(event.expiryDate);
    emit(state.copyWith(
      expiryDate:
          expiryDate.isValid ? expiryDate : ExpiryDate.pure(event.expiryDate),
      isValid: Formz.validate(
          [state.cardNumber, expiryDate, state.cvv, state.holderName]),
    ));
  }

  Future<void> _onAddNewCreaditCardCVVChanged(
    AddNewCreaditCardCVVChanged event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    final cvv = Number.dirty(event.cvv);
    emit(state.copyWith(
      cvv: cvv.isValid ? cvv : Number.pure(event.cvv),
      isValid: Formz.validate(
          [state.cardNumber, state.expiryDate, cvv, state.holderName]),
    ));
  }

  Future<void> _onAddNewCreaditCardCardHolderChanged(
    AddNewCreaditCardHolderNameChanged event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    final holderName = HolderName.dirty(event.holderName);
    emit(state.copyWith(
      holderName:
          holderName.isValid ? holderName : HolderName.pure(event.holderName),
      isValid: Formz.validate(
          [state.cardNumber, state.expiryDate, state.cvv, holderName]),
    ));
  }

  Future<void> _onAddNewCreaditCardFormSubmitted(
    AddNewCreaditCardFormSubmittedEvent event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    final cardNumber = CreaditCardNumber.dirty(state.cardNumber.value);
    final expiryDate = ExpiryDate.dirty(state.expiryDate.value);
    final cvv = Number.dirty(state.cvv.value);
    final holderName = HolderName.dirty(state.holderName.value);
    emit(state.copyWith(
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvv: cvv,
      holderName: holderName,
      isValid: Formz.validate([cardNumber, expiryDate, cvv, holderName]),
    ));

    if (state.isValid) {
      try {
        emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ));
        var cards = await SqfliteHelper.instance.readCardsData();
        debugPrint('CARDS : $cards');
        var response = await SqfliteHelper.instance.insertCardData(
          cardNumber: state.cardNumber.value.toString(),
          expiryDate: state.expiryDate.value.toString(),
          cvv: state.cvv.value.toString(),
          holderName: state.holderName.value.toString(),
        );

        debugPrint(response.toString());
        var readAgain = await SqfliteHelper.instance.readCardsData();
        debugPrint('CARDS : $readAgain');

        await Future.delayed(const Duration(milliseconds: 1200));

        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));

        accountCompletionBloc.add(const AccountCompletionStepEvent(
            currentTappedStep: 4,
            currentCompletionStep: 4,
            progressIndicatorValue: 100));

        var res =
            await authenticationRepository.getCurrentAuthenticationStatus();
        debugPrint(res.toString());

        final updateUserPatch =
            await UpdateUserStatusRepository(api: UpdateUserStatusApi())
                .getPatchUpdateRepository();
        debugPrint('USER STATUS UPDATE INTO 2');

        debugPrint(updateUserPatch.toString());

        if (res == AuthenticationStatus.loginNonVerified) {
          authenticationRepository.loading();
          await Future.delayed(const Duration(milliseconds: 1200));
          authenticationRepository.rollBack();
          await Future.delayed(const Duration(milliseconds: 1200));
          await SqfliteHelper.instance
              .updateAutherization(status: 'login-verified');
          authenticationRepository.verified();
        }
      } catch (e) {
        debugPrint(e.toString());
        await Future.delayed(const Duration(milliseconds: 1200));
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
        ));
        await Future.delayed(const Duration(milliseconds: 800));
      }
    }
  }

  Future<void> _onAddNewCreaditCardFormRollBack(
    AddNewCreaditCardFormRollBackEvent event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.initial,
    ));
  }
}
