library expiry_date;

import 'package:formz/formz.dart';

enum ExpiryDateValidationError { invalid }

class ExpiryDate extends FormzInput<String, ExpiryDateValidationError> {
  const ExpiryDate.pure([super.value = '']) : super.pure();
  const ExpiryDate.dirty([super.value = '']) : super.dirty();

  static final _expiryRegex = RegExp(
    r'^\d{2}-\d{2}$',
  );

  @override
  ExpiryDateValidationError? validator(String? value) {
    return _expiryRegex.hasMatch(value ?? '')
        ? null
        : ExpiryDateValidationError.invalid;
  }
}
