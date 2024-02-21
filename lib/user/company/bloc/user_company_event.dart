part of 'user_company_bloc.dart';

@immutable
sealed class UserCompanyEvent extends Equatable {
  const UserCompanyEvent();

  @override
  List<Object> get props => [];
}

final class UserCompanyStarted extends UserCompanyEvent {
  const UserCompanyStarted(this.id);

  final String id;

  @override
  List<Object> get props => [];
}

final class UserCompanyIdChanged extends UserCompanyEvent {
  const UserCompanyIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class UserCompanyNameChanged extends UserCompanyEvent {
  const UserCompanyNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UserCompanyDescriptionChanged extends UserCompanyEvent {
  const UserCompanyDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class UserCompanyAddressChanged extends UserCompanyEvent {
  const UserCompanyAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class UserCompanyPhoneChanged extends UserCompanyEvent {
  const UserCompanyPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class UserCompanyContactChanged extends UserCompanyEvent {
  const UserCompanyContactChanged(this.contact);

  final String contact;

  @override
  List<Object> get props => [contact];
}

final class UserCompanySubmitConfirm extends UserCompanyEvent {
  const UserCompanySubmitConfirm();

  @override
  List<Object> get props => [];
}

final class UserCompanySubmitted extends UserCompanyEvent {
  const UserCompanySubmitted();
}
