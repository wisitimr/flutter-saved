part of 'my_profile_bloc.dart';

@immutable
sealed class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

final class MyProfileStarted extends MyProfileEvent {
  const MyProfileStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class MyProfileUsernameChanged extends MyProfileEvent {
  const MyProfileUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class MyProfileFirstNameChanged extends MyProfileEvent {
  const MyProfileFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class MyProfileLastNameChanged extends MyProfileEvent {
  const MyProfileLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class MyProfileEmailChanged extends MyProfileEvent {
  const MyProfileEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class MyProfileAccountChanged extends MyProfileEvent {
  const MyProfileAccountChanged(this.account);

  final String account;

  @override
  List<Object> get props => [account];
}

final class MyProfileCompanySelected extends MyProfileEvent {
  const MyProfileCompanySelected(
      this.provider, this.companyId, this.companyName);

  final AppProvider provider;
  final String companyId;
  final String companyName;

  @override
  List<Object> get props => [companyId, companyName];
}

final class MyProfileSubmitted extends MyProfileEvent {
  const MyProfileSubmitted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
