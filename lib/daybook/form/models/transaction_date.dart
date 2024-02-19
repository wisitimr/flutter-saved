import 'package:formz/formz.dart';

enum TransactionDateValidationError { empty }

class TransactionDate
    extends FormzInput<String, TransactionDateValidationError> {
  const TransactionDate.pure() : super.pure('');
  const TransactionDate.dirty([super.value = '']) : super.dirty();

  @override
  TransactionDateValidationError? validator(String value) {
    if (value.isEmpty) return TransactionDateValidationError.empty;
    return null;
  }
}
