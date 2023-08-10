part of 'add_creadit_form_bloc.dart';

enum DropDownMenuButtonStatus { initial, dirty }

class AddCreaditFormState extends Equatable {
  final Amount amount;
  final String cardNumber;
  final DropDownMenuButtonStatus menuStatus;
  final bool isValid;
  final FormzSubmissionStatus status;

  const AddCreaditFormState({
    this.amount = const Amount.pure(),
    this.cardNumber = '',
    this.isValid = false,
    this.menuStatus = DropDownMenuButtonStatus.initial,
    this.status = FormzSubmissionStatus.initial,
  });

  AddCreaditFormState copyWith({
    Amount? amount,
    String? cardNumber,
    DropDownMenuButtonStatus? menuStatus,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return AddCreaditFormState(
        amount: amount ?? this.amount,
        cardNumber: cardNumber ?? this.cardNumber,
        isValid: isValid ?? this.isValid,
        menuStatus: menuStatus ?? this.menuStatus,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [amount, cardNumber, isValid, menuStatus, status];
}
