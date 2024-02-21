part of 'company_bloc.dart';

@immutable
sealed class CompanyEvent extends Equatable {
  const CompanyEvent();

  @override
  List<Object> get props => [];
}

final class CompanyStarted extends CompanyEvent {
  const CompanyStarted(this.id);

  final String id;

  @override
  List<Object> get props => [];
}

final class CompanyIdChanged extends CompanyEvent {
  const CompanyIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class CompanyNameChanged extends CompanyEvent {
  const CompanyNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class CompanyDescriptionChanged extends CompanyEvent {
  const CompanyDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class CompanyAddressChanged extends CompanyEvent {
  const CompanyAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class CompanyPhoneChanged extends CompanyEvent {
  const CompanyPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class CompanyContactChanged extends CompanyEvent {
  const CompanyContactChanged(this.contact);

  final String contact;

  @override
  List<Object> get props => [contact];
}

final class CompanySubmitConfirm extends CompanyEvent {
  const CompanySubmitConfirm();

  @override
  List<Object> get props => [];
}

final class CompanySubmitted extends CompanyEvent {
  const CompanySubmitted();
}
