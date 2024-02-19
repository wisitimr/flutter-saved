part of 'daybook_form_bloc.dart';

final class DaybookFormState extends Equatable {
  const DaybookFormState({
    this.isLoading = true,
    this.msDocument = const <MsDocument>[],
    this.msSupplier = const <MsSupplier>[],
    this.msCustomer = const <MsCustomer>[],
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.id = const Id.pure(),
    this.number = const Number.pure(),
    this.invoice = const Invoice.pure(),
    this.document = const Document.pure(),
    this.documentType = '',
    this.transactionDate = const TransactionDate.pure(),
    this.company = const Company.pure(),
    this.supplier = const Supplier.pure(),
    this.customer = const Customer.pure(),
    this.daybookDetail = const <DaybookDetailListModel>[],
    this.isValid = false,
  });

  final bool isLoading;
  final List<MsDocument> msDocument;
  final List<MsSupplier> msSupplier;
  final List<MsCustomer> msCustomer;
  final FormzSubmissionStatus status;
  final String message;
  final Id id;
  final Number number;
  final Invoice invoice;
  final Document document;
  final String documentType;
  final TransactionDate transactionDate;
  final Company company;
  final Supplier supplier;
  final Customer customer;
  final List<DaybookDetailListModel> daybookDetail;
  final bool isValid;

  DaybookFormState copyWith({
    bool? isLoading,
    List<MsDocument>? msDocument,
    List<MsSupplier>? msSupplier,
    List<MsCustomer>? msCustomer,
    FormzSubmissionStatus? status,
    String? message,
    Id? id,
    Number? number,
    Invoice? invoice,
    Document? document,
    String? documentType,
    TransactionDate? transactionDate,
    Company? company,
    Supplier? supplier,
    Customer? customer,
    List<DaybookDetailListModel>? daybookDetail,
    bool? isValid,
  }) {
    return DaybookFormState(
      isLoading: isLoading ?? this.isLoading,
      msDocument: msDocument ?? this.msDocument,
      msSupplier: msSupplier ?? this.msSupplier,
      msCustomer: msCustomer ?? this.msCustomer,
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      number: number ?? this.number,
      invoice: invoice ?? this.invoice,
      document: document ?? this.document,
      documentType: documentType ?? this.documentType,
      transactionDate: transactionDate ?? this.transactionDate,
      company: company ?? this.company,
      supplier: supplier ?? this.supplier,
      customer: customer ?? this.customer,
      daybookDetail: daybookDetail ?? this.daybookDetail,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        status,
        id,
        number,
        invoice,
        document,
        documentType,
        transactionDate,
        company,
        supplier,
        customer,
        isValid
      ];
}

final class DaybookFormLoading extends DaybookFormState {
  @override
  List<Object> get props => [];
}

final class DaybookFormError extends DaybookFormState {
  @override
  List<Object> get props => [];
}
