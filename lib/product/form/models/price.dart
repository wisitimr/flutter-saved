import 'package:formz/formz.dart';

enum PriceValidationError { empty }

class Price extends FormzInput<String, PriceValidationError> {
  const Price.pure() : super.pure('');
  const Price.dirty([super.value = '']) : super.dirty();

  @override
  PriceValidationError? validator(String value) {
    if (value.isEmpty) return PriceValidationError.empty;
    return null;
  }
}
