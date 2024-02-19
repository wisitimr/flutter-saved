import 'package:formz/formz.dart';

enum NumberValidationError { empty }

class Number extends FormzInput<String, NumberValidationError> {
  const Number.pure() : super.pure('');
  const Number.dirty([super.value = '']) : super.dirty();

  @override
  NumberValidationError? validator(String value) {
    if (value.isEmpty) return NumberValidationError.empty;
    return null;
  }
}
