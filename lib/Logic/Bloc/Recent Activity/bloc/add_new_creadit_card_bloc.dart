import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/Logic/Bloc/Login/models/models.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/creadit_card_holder_name.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/creadit_card_number.dart';
import 'package:final_project/Logic/Bloc/Recent%20Activity/model/expiry_date.dart';
import 'package:formz/formz.dart';

part 'add_new_creadit_card_event.dart';
part 'add_new_creadit_card_state.dart';

class AddNewCreaditCardBloc
    extends Bloc<AddNewCreaditCardEvent, AddNewCreaditCardState> {
  AddNewCreaditCardBloc() : super(const AddNewCreaditCardState()) {
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
  ) async {}

  Future<void> _onAddNewCreaditCardFormRollBack(
    AddNewCreaditCardFormRollBackEvent event,
    Emitter<AddNewCreaditCardState> emit,
  ) async {}
}
