import 'package:formz/formz.dart';

enum RoleValidationError { empty }

class Role extends FormzInput<String, RoleValidationError> {
  const Role.pure() : super.pure('');
  const Role.dirty([super.value = '']) : super.dirty();

  @override
  RoleValidationError? validator(String value) {
    if (value.isEmpty) return RoleValidationError.empty;
    return null;
  }
}
