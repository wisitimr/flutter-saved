import 'package:formz/formz.dart';

enum SupplierValidationError { empty }

class Supplier extends FormzInput<String, SupplierValidationError> {
  const Supplier.pure() : super.pure('');
  const Supplier.dirty([super.value = '']) : super.dirty();

  @override
  SupplierValidationError? validator(String value) {
    if (value.isEmpty) return SupplierValidationError.empty;
    return null;
  }
}
