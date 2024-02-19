import 'package:formz/formz.dart';

enum TypeValidationError { empty }

class Type extends FormzInput<String, TypeValidationError> {
  const Type.pure() : super.pure('');
  const Type.dirty([super.value = '']) : super.dirty();

  @override
  TypeValidationError? validator(String value) {
    if (value.isEmpty) return TypeValidationError.empty;
    return null;
  }
}
