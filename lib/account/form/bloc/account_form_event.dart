part of 'account_form_bloc.dart';

@immutable
sealed class AccountFormEvent extends Equatable {
  const AccountFormEvent();

  @override
  List<Object> get props => [];
}

final class AccountFormStarted extends AccountFormEvent {
  const AccountFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountFormIdChanged extends AccountFormEvent {
  const AccountFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class AccountFormCodeChanged extends AccountFormEvent {
  const AccountFormCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class AccountFormNameChanged extends AccountFormEvent {
  const AccountFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class AccountFormDescriptionChanged extends AccountFormEvent {
  const AccountFormDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class AccountFormTypeChanged extends AccountFormEvent {
  const AccountFormTypeChanged(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

final class AccountFormSubmitConfirm extends AccountFormEvent {
  const AccountFormSubmitConfirm();

  @override
  List<Object> get props => [];
}

final class AccountSubmitted extends AccountFormEvent {
  const AccountSubmitted();

  @override
  List<Object> get props => [];
}
