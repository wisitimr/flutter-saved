import 'package:formz/formz.dart';

enum PaymentMethodValidationError { empty }

class PaymentMethod extends FormzInput<String, PaymentMethodValidationError> {
  const PaymentMethod.pure() : super.pure('');
  const PaymentMethod.dirty([super.value = '']) : super.dirty();

  @override
  PaymentMethodValidationError? validator(String value) {
    if (value.isEmpty) return PaymentMethodValidationError.empty;
    return null;
  }
}
