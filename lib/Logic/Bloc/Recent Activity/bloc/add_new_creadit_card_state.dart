part of 'add_new_creadit_card_bloc.dart';

class AddNewCreaditCardState extends Equatable {
  final CreaditCardNumber cardNumber;
  final ExpiryDate expiryDate;
  final Number cvv;
  final HolderName holderName;
  final bool isValid;
  final FormzSubmissionStatus status;

  const AddNewCreaditCardState({
    this.cardNumber = const CreaditCardNumber.pure(),
    this.expiryDate = const ExpiryDate.pure(),
    this.cvv = const Number.pure(),
    this.holderName = const HolderName.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
  });

  AddNewCreaditCardState copyWith({
    CreaditCardNumber? cardNumber,
    ExpiryDate? expiryDate,
    Number? cvv,
    HolderName? holderName,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return AddNewCreaditCardState(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      holderName: holderName ?? this.holderName,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [cardNumber, expiryDate, cvv, holderName, isValid, status];
}
