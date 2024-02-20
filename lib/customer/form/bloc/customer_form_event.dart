part of 'customer_form_bloc.dart';

@immutable
sealed class CustomerFormEvent extends Equatable {
  const CustomerFormEvent();

  @override
  List<Object> get props => [];
}

final class CustomerFormStarted extends CustomerFormEvent {
  const CustomerFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class CustomerFormIdChanged extends CustomerFormEvent {
  const CustomerFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class CustomerFormCodeChanged extends CustomerFormEvent {
  const CustomerFormCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class CustomerFormNameChanged extends CustomerFormEvent {
  const CustomerFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class CustomerFormAddressChanged extends CustomerFormEvent {
  const CustomerFormAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class CustomerFormTaxChanged extends CustomerFormEvent {
  const CustomerFormTaxChanged(this.tax);

  final String tax;

  @override
  List<Object> get props => [tax];
}

final class CustomerFormPhoneChanged extends CustomerFormEvent {
  const CustomerFormPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class CustomerFormContactChanged extends CustomerFormEvent {
  const CustomerFormContactChanged(this.contact);

  final String contact;

  @override
  List<Object> get props => [contact];
}

final class CustomerSubmitted extends CustomerFormEvent {
  const CustomerSubmitted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
