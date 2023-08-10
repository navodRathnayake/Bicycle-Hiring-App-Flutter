library amount;

import 'package:final_project/Logic/Bloc/Login/models/number.dart';
import 'package:formz/formz.dart';

class Amount extends FormzInput<String, NumberValidatorError> {
  const Amount.pure([super.value = '']) : super.pure();
  const Amount.dirty([super.value = '']) : super.dirty();

  static final _amountRegex =
      RegExp(r'(?<!\.)(?:1(?!00(?!\.?\d))|[2-9])[0-9]\d+(?:\.\d{1,2})?');

  @override
  NumberValidatorError? validator(String? value) {
    return _amountRegex.hasMatch(value ?? '')
        ? null
        : NumberValidatorError.invalid;
  }
}
