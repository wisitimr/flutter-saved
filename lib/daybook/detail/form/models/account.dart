import 'package:formz/formz.dart';

enum AccountValidationError { empty }

class Account extends FormzInput<String, AccountValidationError> {
  const Account.pure() : super.pure('');
  const Account.dirty([super.value = '']) : super.dirty();

  @override
  AccountValidationError? validator(String value) {
    if (value.isEmpty) return AccountValidationError.empty;
    return null;
  }
}
