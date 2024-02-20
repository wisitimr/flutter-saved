part of 'supplier_form_bloc.dart';

@immutable
sealed class SupplierFormEvent extends Equatable {
  const SupplierFormEvent();

  @override
  List<Object> get props => [];
}

final class SupplierFormStarted extends SupplierFormEvent {
  const SupplierFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class SupplierFormIdChanged extends SupplierFormEvent {
  const SupplierFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class SupplierFormCodeChanged extends SupplierFormEvent {
  const SupplierFormCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class SupplierFormNameChanged extends SupplierFormEvent {
  const SupplierFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class SupplierFormAddressChanged extends SupplierFormEvent {
  const SupplierFormAddressChanged(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}

final class SupplierFormTaxChanged extends SupplierFormEvent {
  const SupplierFormTaxChanged(this.tax);

  final String tax;

  @override
  List<Object> get props => [tax];
}

final class SupplierFormPhoneChanged extends SupplierFormEvent {
  const SupplierFormPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class SupplierFormContactChanged extends SupplierFormEvent {
  const SupplierFormContactChanged(this.contact);

  final String contact;

  @override
  List<Object> get props => [contact];
}

final class SupplierSubmitted extends SupplierFormEvent {
  const SupplierSubmitted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
