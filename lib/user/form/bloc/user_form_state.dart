part of 'user_form_bloc.dart';

final class UserFormState extends Equatable {
  const UserFormState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
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

  final bool isLoading;
  final FormzSubmissionStatus status;
  final String message;
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
    bool? isLoading,
    FormzSubmissionStatus? status,
    String? message,
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
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: message ?? this.message,
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
        isLoading,
        status,
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
