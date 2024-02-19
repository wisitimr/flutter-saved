import 'package:formz/formz.dart';

enum InvoiceValidationError { empty }

class Invoice extends FormzInput<String, InvoiceValidationError> {
  const Invoice.pure() : super.pure('');
  const Invoice.dirty([super.value = '']) : super.dirty();

  @override
  InvoiceValidationError? validator(String value) {
    if (value.isEmpty) return InvoiceValidationError.empty;
    return null;
  }
}
