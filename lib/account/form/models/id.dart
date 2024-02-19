import 'package:formz/formz.dart';

enum IdValidationError { empty }

class Id extends FormzInput<String, IdValidationError> {
  const Id.pure() : super.pure('');
  const Id.dirty([super.value = '']) : super.dirty();

  @override
  IdValidationError? validator(String value) {
    if (value.isEmpty) return IdValidationError.empty;
    return null;
  }
}
