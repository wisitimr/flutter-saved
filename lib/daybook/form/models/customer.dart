import 'package:formz/formz.dart';

enum CustomerValidationError { empty }

class Customer extends FormzInput<String, CustomerValidationError> {
  const Customer.pure() : super.pure('');
  const Customer.dirty([super.value = '']) : super.dirty();

  @override
  CustomerValidationError? validator(String value) {
    if (value.isEmpty) return CustomerValidationError.empty;
    return null;
  }
}
