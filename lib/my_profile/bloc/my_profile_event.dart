part of 'my_profile_bloc.dart';

@immutable
sealed class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

final class MyProfileStarted extends MyProfileEvent {
  const MyProfileStarted();

  @override
  List<Object> get props => [];
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
  const MyProfileCompanySelected(this.id, this.name);

  final String id;
  final String name;

  @override
  List<Object> get props => [id, name];
}

final class MyProfileDeleteConfirm extends MyProfileEvent {
  const MyProfileDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class MyProfileDelete extends MyProfileEvent {
  const MyProfileDelete();

  @override
  List<Object> get props => [];
}

final class MyProfileSubmitConfirm extends MyProfileEvent {
  const MyProfileSubmitConfirm();

  @override
  List<Object> get props => [];
}

final class MyProfileSubmitted extends MyProfileEvent {
  const MyProfileSubmitted();

  @override
  List<Object> get props => [];
}
