part of 'material_form_bloc.dart';

enum MaterialFormStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension MaterialFormStatusX on MaterialFormStatus {
  bool get isLoading => this == MaterialFormStatus.loading;
  bool get isSuccess => this == MaterialFormStatus.success;
  bool get isFailure => this == MaterialFormStatus.failure;
  bool get isSubmitConfirmation =>
      this == MaterialFormStatus.submitConfirmation;
  bool get isSubmited => this == MaterialFormStatus.submited;
}

final class MaterialFormState extends Equatable {
  const MaterialFormState({
    this.status = MaterialFormStatus.loading,
    this.message = '',
    this.id = const Id.pure(),
    this.code = const Code.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.isValid = false,
  });

  final MaterialFormStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Description description;
  final bool isValid;

  MaterialFormState copyWith({
    MaterialFormStatus? status,
    String? message,
    Id? id,
    Code? code,
    Name? name,
    Description? description,
    Type? type,
    bool? isValid,
  }) {
    return MaterialFormState(
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
  List<Object> get props => [
        status,
        id,
        code,
        name,
        description,
        isValid,
      ];
}

final class MaterialFormLoading extends MaterialFormState {
  @override
  List<Object> get props => [];
}

final class MaterialFormError extends MaterialFormState {
  @override
  List<Object> get props => [];
}
