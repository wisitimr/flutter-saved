part of 'user_form_bloc.dart';

@immutable
sealed class UserFormEvent extends Equatable {
  const UserFormEvent();

  @override
  List<Object> get props => [];
}

final class UserFormStarted extends UserFormEvent {
  const UserFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class UserFormIdChanged extends UserFormEvent {
  const UserFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class UserFormUsernameChanged extends UserFormEvent {
  const UserFormUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class UserFormFirstNameChanged extends UserFormEvent {
  const UserFormFirstNameChanged(this.firstName);

  final String firstName;

  @override
  List<Object> get props => [firstName];
}

final class UserFormLastNameChanged extends UserFormEvent {
  const UserFormLastNameChanged(this.lastName);

  final String lastName;

  @override
  List<Object> get props => [lastName];
}

final class UserFormEmailChanged extends UserFormEvent {
  const UserFormEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class UserFormRoleChanged extends UserFormEvent {
  const UserFormRoleChanged(this.role);

  final String role;

  @override
  List<Object> get props => [role];
}

final class UserFormDeleteConfirm extends UserFormEvent {
  const UserFormDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class UserFormDelete extends UserFormEvent {
  const UserFormDelete();

  @override
  List<Object> get props => [];
}

final class UserFormSubmitConfirm extends UserFormEvent {
  const UserFormSubmitConfirm();

  @override
  List<Object> get props => [];
}

final class UserSubmitted extends UserFormEvent {
  const UserSubmitted();

  @override
  List<Object> get props => [];
}
