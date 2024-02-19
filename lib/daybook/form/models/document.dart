import 'package:formz/formz.dart';

enum DocumentValidationError { empty }

class Document extends FormzInput<String, DocumentValidationError> {
  const Document.pure() : super.pure('');
  const Document.dirty([super.value = '']) : super.dirty();

  @override
  DocumentValidationError? validator(String value) {
    if (value.isEmpty) return DocumentValidationError.empty;
    return null;
  }
}
