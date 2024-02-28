part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.isValid = false,
    this.isPasswordVisible = false,
    this.isRetypePasswordVisible = false,
  });

  final FormzSubmissionStatus status;
  final String message;
  final Username username;
  final Email email;
  final Password password;
  final FirstName firstName;
  final LastName lastName;
  final bool isValid;
  final bool isPasswordVisible;
  final bool isRetypePasswordVisible;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    String? message,
    Username? username,
    Email? email,
    Password? password,
    FirstName? firstName,
    LastName? lastName,
    bool? isValid,
    bool? isPasswordVisible,
    bool? isRetypePasswordVisible,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isValid: isValid ?? this.isValid,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRetypePasswordVisible:
          isRetypePasswordVisible ?? this.isRetypePasswordVisible,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        email,
        password,
        firstName,
        lastName,
        isValid,
        isPasswordVisible,
        isRetypePasswordVisible,
      ];
}
