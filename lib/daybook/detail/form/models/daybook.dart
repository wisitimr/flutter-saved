import 'package:formz/formz.dart';

enum DaybookValidationError { empty }

class Daybook extends FormzInput<String, DaybookValidationError> {
  const Daybook.pure() : super.pure('');
  const Daybook.dirty([super.value = '']) : super.dirty();

  @override
  DaybookValidationError? validator(String value) {
    if (value.isEmpty) return DaybookValidationError.empty;
    return null;
  }
}
