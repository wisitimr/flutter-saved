import 'package:formz/formz.dart';

enum CompanyValidationError { empty }

class Company extends FormzInput<String, CompanyValidationError> {
  const Company.pure() : super.pure('');
  const Company.dirty([super.value = '']) : super.dirty();

  @override
  CompanyValidationError? validator(String value) {
    if (value.isEmpty) return CompanyValidationError.empty;
    return null;
  }
}
