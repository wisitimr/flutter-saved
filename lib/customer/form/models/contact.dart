import 'package:formz/formz.dart';

enum ContactValidationError { empty }

class Contact extends FormzInput<String, ContactValidationError> {
  const Contact.pure() : super.pure('');
  const Contact.dirty([super.value = '']) : super.dirty();

  @override
  ContactValidationError? validator(String value) {
    if (value.isEmpty) return ContactValidationError.empty;
    return null;
  }
}
