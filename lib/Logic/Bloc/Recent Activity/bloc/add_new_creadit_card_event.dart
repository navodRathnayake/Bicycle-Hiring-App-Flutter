part of 'add_new_creadit_card_bloc.dart';

abstract class AddNewCreaditCardEvent extends Equatable {
  const AddNewCreaditCardEvent();

  @override
  List<Object> get props => [];
}

class AddNewCreaditCardNumberChanged extends AddNewCreaditCardEvent {
  final String cardNumber;
  const AddNewCreaditCardNumberChanged({required this.cardNumber});

  @override
  List<Object> get props => [cardNumber];
}

class AddNewCreaditCardExpiryDateChanged extends AddNewCreaditCardEvent {
  final String expiryDate;
  const AddNewCreaditCardExpiryDateChanged({required this.expiryDate});

  @override
  List<Object> get props => [expiryDate];
}

class AddNewCreaditCardCVVChanged extends AddNewCreaditCardEvent {
  final String cvv;
  const AddNewCreaditCardCVVChanged({required this.cvv});

  @override
  List<Object> get props => [cvv];
}

class AddNewCreaditCardHolderNameChanged extends AddNewCreaditCardEvent {
  final String holderName;
  const AddNewCreaditCardHolderNameChanged({required this.holderName});

  @override
  List<Object> get props => [holderName];
}

class AddNewCreaditCardFormSubmittedEvent extends AddNewCreaditCardEvent {}

class AddNewCreaditCardFormRollBackEvent extends AddNewCreaditCardEvent {}
