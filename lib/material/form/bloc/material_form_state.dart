part of 'material_form_bloc.dart';

final class MaterialFormState extends Equatable {
  const MaterialFormState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.id = const Id.pure(),
    this.code = const Code.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.isValid = false,
  });

  final bool isLoading;
  final FormzSubmissionStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Description description;
  final bool isValid;

  MaterialFormState copyWith({
    bool? isLoading,
    FormzSubmissionStatus? status,
    String? message,
    Id? id,
    Code? code,
    Name? name,
    Description? description,
    Type? type,
    bool? isValid,
  }) {
    return MaterialFormState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, status, id, code, name, description, isValid];
}

final class MaterialFormLoading extends MaterialFormState {
  @override
  List<Object> get props => [];
}

final class MaterialFormError extends MaterialFormState {
  @override
  List<Object> get props => [];
}
