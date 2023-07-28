import 'package:formz/formz.dart';

enum NumberValidatorError { invalid }

final class Number extends FormzInput<String, NumberValidatorError> {
  const Number.pure([super.value = '']) : super.pure();
  const Number.dirty([super.value = '']) : super.dirty();

  static final _numberRegex = RegExp(r'^\d*\.?\d+$');

  @override
  NumberValidatorError? validator(String? value) {
    return _numberRegex.hasMatch(value ?? '')
        ? null
        : NumberValidatorError.invalid;
  }
}
