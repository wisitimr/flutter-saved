part of 'account_form_bloc.dart';

enum AccountFormStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension AccountFormStatusX on AccountFormStatus {
  bool get isLoading => this == AccountFormStatus.loading;
  bool get isSuccess => this == AccountFormStatus.success;
  bool get isFailure => this == AccountFormStatus.failure;
  bool get isSubmitConfirmation => this == AccountFormStatus.submitConfirmation;
  bool get isSubmited => this == AccountFormStatus.submited;
}

final class AccountFormState extends Equatable {
  const AccountFormState({
    this.status = AccountFormStatus.loading,
    this.message = '',
    this.id = const Id.pure(),
    this.code = const Code.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.type = const Type.pure(),
    this.isValid = false,
  });

  final AccountFormStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Description description;
  final Type type;
  final bool isValid;

  AccountFormState copyWith({
    AccountFormStatus? status,
    String? message,
    Id? id,
    Code? code,
    Name? name,
    Description? description,
    Type? type,
    bool? isValid,
  }) {
    return AccountFormState(
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
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
        type,
        isValid,
      ];
}

final class AccountFormLoading extends AccountFormState {
  @override
  List<Object> get props => [];
}

final class AccountFormError extends AccountFormState {
  @override
  List<Object> get props => [];
}
