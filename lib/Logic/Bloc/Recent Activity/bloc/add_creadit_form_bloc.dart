import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/user_account_get_api.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/data%20provider/user_patch_api.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/repository%20provider/transaction_data_post_repository.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/data/repository%20provider/user_patch_repository.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/amount.dart';
import 'package:final_project/Services/account%20repository/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../data/data provider/transaction_data_post_api.dart';
import '../data/repository provider/user_account_get_repository.dart';

part 'add_creadit_form_event.dart';
part 'add_creadit_form_state.dart';

class AddCreaditFormBloc
    extends Bloc<AddCreaditFormEvent, AddCreaditFormState> {
  final AccountStreamRepository accountStreamRepository;
  AddCreaditFormBloc({required this.accountStreamRepository})
      : super(const AddCreaditFormState()) {
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
      try {
        await Future.delayed(const Duration(milliseconds: 1200));

        emit(state.copyWith(
          status: FormzSubmissionStatus.inProgress,
        ));

        final points = Amount.dirty(state.amount.value.toString());

        debugPrint(amount.value.toString());

        var userCurrentPointsResponse =
            await UserAccountGetRepository(api: UserAccountGetApi())
                .getUserData();

        debugPrint(userCurrentPointsResponse.toString());

        if (userCurrentPointsResponse['result'] == 1) {
          double newPoints = double.parse(userCurrentPointsResponse['body']
                      ['users']['points']
                  .toString()) +
              double.parse(points.value.toString());

          debugPrint('New Added Points : $newPoints');

          var userPointsPatchResponse =
              await UserPatchRepository(api: UserPatchAPI())
                  .patchUser(points: newPoints.toString());

          debugPrint(userPointsPatchResponse.toString());

          if (userPointsPatchResponse['result'] == 1) {
            await Future.delayed(const Duration(milliseconds: 1200));

            await accountStreamRepository.streamIn();
            Future.delayed(const Duration(milliseconds: 1200));
            await accountStreamRepository.streamIdel();

            var transactionResponse = await TransactionDataPostRepository(
                    api: TransactionDataPostApi())
                .postTransactionData(amount: newPoints.toString());

            debugPrint(transactionResponse.toString());

            emit(state.copyWith(
              status: FormzSubmissionStatus.success,
            ));

            // await Future.delayed(const Duration(milliseconds: 1200));

            // emit(state.copyWith(
            //   status: FormzSubmissionStatus.initial,
            // ));
          } else {
            await Future.delayed(const Duration(milliseconds: 1200));

            emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
            ));
          }
        } else {
          await Future.delayed(const Duration(milliseconds: 1200));

          emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
          ));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
        ));
      }
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
