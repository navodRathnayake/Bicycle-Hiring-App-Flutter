part of 'add_creadit_form_bloc.dart';

abstract class AddCreaditFormEvent extends Equatable {
  const AddCreaditFormEvent();

  @override
  List<Object> get props => [];
}

class AddCreaditFormDropDownMenuChangedEvent extends AddCreaditFormEvent {
  final String menuItemValue;
  const AddCreaditFormDropDownMenuChangedEvent({required this.menuItemValue});

  @override
  List<Object> get props => [menuItemValue];
}

class AddCreaditFormAmountChangedEvent extends AddCreaditFormEvent {
  final String amount;
  const AddCreaditFormAmountChangedEvent({required this.amount});

  @override
  List<Object> get props => [amount];
}

class AddCreaditFormClearEvent extends AddCreaditFormEvent {}

class AddCreaditFormSubmittedEvent extends AddCreaditFormEvent {
  final String points;
  const AddCreaditFormSubmittedEvent({required this.points});
}

class AddCreaditFormRollBackEvent extends AddCreaditFormEvent {}
