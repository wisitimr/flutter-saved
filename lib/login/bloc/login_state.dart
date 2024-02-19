part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.company = const Company.pure(),
    this.companies = const <CompanyModel>[],
    this.isLoggedIn = false,
    this.isLoading = false,
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final String message;
  final Username username;
  final Password password;
  final Company company;
  final List<CompanyModel> companies;
  final bool isLoggedIn;
  final bool isLoading;
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    String? message,
    Username? username,
    Password? password,
    Company? company,
    List<CompanyModel>? companies,
    bool? isLoggedIn,
    bool? isLoading,
    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      username: username ?? this.username,
      password: password ?? this.password,
      company: company ?? this.company,
      companies: companies ?? this.companies,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        companies,
        isLoggedIn,
        isLoading,
        isValid,
      ];
}
