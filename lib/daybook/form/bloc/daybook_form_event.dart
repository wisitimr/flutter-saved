part of 'daybook_form_bloc.dart';

@immutable
sealed class DaybookFormEvent extends Equatable {
  const DaybookFormEvent();

  @override
  List<Object> get props => [];
}

final class DaybookFormStarted extends DaybookFormEvent {
  const DaybookFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class DaybookFormIdChanged extends DaybookFormEvent {
  const DaybookFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class DaybookFormNumberChanged extends DaybookFormEvent {
  const DaybookFormNumberChanged(this.number);

  final String number;

  @override
  List<Object> get props => [number];
}

final class DaybookFormInvoiceChanged extends DaybookFormEvent {
  const DaybookFormInvoiceChanged(this.invoice);

  final String invoice;

  @override
  List<Object> get props => [invoice];
}

final class DaybookFormDocumentChanged extends DaybookFormEvent {
  const DaybookFormDocumentChanged(this.document);

  final String document;

  @override
  List<Object> get props => [document];
}

final class DaybookFormTransactionDateChanged extends DaybookFormEvent {
  const DaybookFormTransactionDateChanged(this.transactionDate);

  final String transactionDate;

  @override
  List<Object> get props => [transactionDate];
}

final class DaybookFormCompanyChanged extends DaybookFormEvent {
  const DaybookFormCompanyChanged(this.company);

  final String company;

  @override
  List<Object> get props => [company];
}

final class DaybookFormSupplierChanged extends DaybookFormEvent {
  const DaybookFormSupplierChanged(this.supplier);

  final String supplier;

  @override
  List<Object> get props => [supplier];
}

final class DaybookFormCustomerChanged extends DaybookFormEvent {
  const DaybookFormCustomerChanged(this.customer);

  final String customer;

  @override
  List<Object> get props => [customer];
}

final class DaybookSubmitted extends DaybookFormEvent {
  const DaybookSubmitted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
