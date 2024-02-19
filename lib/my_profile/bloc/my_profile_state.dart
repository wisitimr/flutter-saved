part of 'my_profile_bloc.dart';

final class MyProfileState extends Equatable {
  const MyProfileState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.imageUrl = '',
    this.id = const Id.pure(),
    this.username = const Username.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.role = const Role.pure(),
    this.companies = const <CompanyModel>[],
    this.companySelected = '',
    this.isValid = false,
  });

  final bool isLoading;
  final FormzSubmissionStatus status;
  final String message;
  final String imageUrl;
  final Id id;
  final Username username;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final Role role;
  final List<CompanyModel> companies;
  final String companySelected;
  final bool isValid;

  MyProfileState copyWith({
    bool? isLoading,
    FormzSubmissionStatus? status,
    String? message,
    String? imageUrl,
    Id? id,
    Username? username,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    Role? role,
    List<CompanyModel>? companies,
    String? companySelected,
    bool? isValid,
  }) {
    return MyProfileState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: message ?? this.message,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      role: role ?? this.role,
      companies: companies ?? this.companies,
      companySelected: companySelected ?? this.companySelected,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        status,
        imageUrl,
        id,
        username,
        firstName,
        lastName,
        email,
        role,
        companies,
        companySelected,
        isValid
      ];
}

final class MyProfileLoading extends MyProfileState {
  @override
  List<Object> get props => [];
}

final class MyProfileError extends MyProfileState {
  @override
  List<Object> get props => [];
}
