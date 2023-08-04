library card_holder_name;

import 'package:formz/formz.dart';

enum CreaditCardHolderNameValidationError { invalid }

class HolderName
    extends FormzInput<String, CreaditCardHolderNameValidationError> {
  const HolderName.pure([super.value = '']) : super.pure();
  const HolderName.dirty([super.value = '']) : super.dirty();

  static final _holderNameRegex = RegExp(
    r'^[A-Z][a-z]+(\s[A-Z][a-z]+)+$',
  );

  @override
  CreaditCardHolderNameValidationError? validator(String? value) {
    return _holderNameRegex.hasMatch(value ?? '')
        ? null
        : CreaditCardHolderNameValidationError.invalid;
  }
}
