import 'package:formz/formz.dart';

enum DetailValidationError { empty }

class Detail extends FormzInput<String, DetailValidationError> {
  const Detail.pure() : super.pure('');
  const Detail.dirty([super.value = '']) : super.dirty();

  @override
  DetailValidationError? validator(String value) {
    if (value.isEmpty) return DetailValidationError.empty;
    return null;
  }
}
