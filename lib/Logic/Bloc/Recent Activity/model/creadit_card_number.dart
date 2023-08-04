library creadit_card_number;

import 'package:formz/formz.dart';

enum CreaditCardNumberValidationError { invalid }

class CreaditCardNumber
    extends FormzInput<String, CreaditCardNumberValidationError> {
  const CreaditCardNumber.pure([super.value = '']) : super.pure();
  const CreaditCardNumber.dirty([super.value = '']) : super.dirty();

  static final _creaditCardRegex = RegExp(
    r'^\d{4}-\d{4}-\d{4}-\d{4}$',
  );

  @override
  CreaditCardNumberValidationError? validator(String? value) {
    return _creaditCardRegex.hasMatch(value ?? '')
        ? null
        : CreaditCardNumberValidationError.invalid;
  }
}
