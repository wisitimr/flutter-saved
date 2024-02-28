part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginCompanySelected extends LoginEvent {
  const LoginCompanySelected(this.provider, this.company);

  final AppProvider provider;
  final String company;

  @override
  List<Object> get props => [provider, company];
}

final class LoginConfirm extends LoginEvent {
  const LoginConfirm();
}

final class LoginCancel extends LoginEvent {
  const LoginCancel();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
