part of 'user_form_bloc.dart';

enum UserFormStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
  submitConfirmation,
  submited,
}

extension UserFormStatusX on UserFormStatus {
  bool get isLoading => this == UserFormStatus.loading;
  bool get isSuccess => this == UserFormStatus.success;
  bool get isFailure => this == UserFormStatus.failure;
  bool get isDeleteConfirmation => this == UserFormStatus.deleteConfirmation;
  bool get isDeleted => this == UserFormStatus.deleted;
  bool get isSubmitConfirmation => this == UserFormStatus.submitConfirmation;
  bool get isSubmited => this == UserFormStatus.submited;
}

final class UserFormState extends Equatable {
  const UserFormState({
    this.status = UserFormStatus.loading,
    this.message = '',
    this.selectedDeleteRowId = '',
    this.id = const Id.pure(),
    this.username = const Username.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.role = const Role.pure(),
    this.companies = const <CompanyModel>[],
    this.roles = const <String>[],
    this.isValid = false,
  });

  final UserFormStatus status;
  final String message;
  final String selectedDeleteRowId;
  final Id id;
  final Username username;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Role role;
  final List<CompanyModel> companies;
  final List<String> roles;
  final bool isValid;

  UserFormState copyWith({
    UserFormStatus? status,
    String? message,
    String? selectedDeleteRowId,
    Id? id,
    Username? username,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Role? role,
    List<CompanyModel>? companies,
    List<String>? roles,
    bool? isValid,
  }) {
    return UserFormState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      companies: companies ?? this.companies,
      roles: roles ?? this.roles,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        selectedDeleteRowId,
        id,
        username,
        firstName,
        lastName,
        email,
        role,
        companies,
        roles,
        isValid
      ];
}

final class UserFormLoading extends UserFormState {
  @override
  List<Object> get props => [];
}

final class UserFormError extends UserFormState {
  @override
  List<Object> get props => [];
}
