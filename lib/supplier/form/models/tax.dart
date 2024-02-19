import 'package:formz/formz.dart';

enum TaxValidationError { empty }

class Tax extends FormzInput<String, TaxValidationError> {
  const Tax.pure() : super.pure('');
  const Tax.dirty([super.value = '']) : super.dirty();

  @override
  TaxValidationError? validator(String value) {
    if (value.isEmpty) return TaxValidationError.empty;
    return null;
  }
}
