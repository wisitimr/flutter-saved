part of 'daybook_form_bloc.dart';

enum DaybookFormStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
  submitConfirmation,
  submited,
}

extension DaybookFormStatusX on DaybookFormStatus {
  bool get isLoading => this == DaybookFormStatus.loading;
  bool get isSuccess => this == DaybookFormStatus.success;
  bool get isFailure => this == DaybookFormStatus.failure;
  bool get isDeleteConfirmation => this == DaybookFormStatus.deleteConfirmation;
  bool get isDeleted => this == DaybookFormStatus.deleted;
  bool get isSubmitConfirmation => this == DaybookFormStatus.submitConfirmation;
  bool get isSubmited => this == DaybookFormStatus.submited;
}

final class DaybookFormState extends Equatable {
  const DaybookFormState({
    this.msDocument = const <MsDocument>[],
    this.msSupplier = const <MsSupplier>[],
    this.msCustomer = const <MsCustomer>[],
    this.status = DaybookFormStatus.loading,
    this.message = '',
    this.selectedDeleteRowId = '',
    this.id = const Id.pure(),
    this.number = const Number.pure(),
    this.invoice = const Invoice.pure(),
    this.document = const Document.pure(),
    this.documentType = '',
    this.documentName = '',
    this.supplierName = '',
    this.customerName = '',
    this.transactionDate = const TransactionDate.pure(),
    this.company = const Company.pure(),
    this.supplier = const Supplier.pure(),
    this.customer = const Customer.pure(),
    this.daybookDetail = const <DaybookDetailListModel>[],
    this.isValid = false,
    this.isHistory = false,
  });

  final List<MsDocument> msDocument;
  final List<MsSupplier> msSupplier;
  final List<MsCustomer> msCustomer;
  final DaybookFormStatus status;
  final String message;
  final String selectedDeleteRowId;
  final Id id;
  final Number number;
  final Invoice invoice;
  final Document document;
  final String documentType;
  final String documentName;
  final String supplierName;
  final String customerName;
  final TransactionDate transactionDate;
  final Company company;
  final Supplier supplier;
  final Customer customer;
  final List<DaybookDetailListModel> daybookDetail;
  final bool isValid;
  final bool isHistory;

  DaybookFormState copyWith({
    List<MsDocument>? msDocument,
    List<MsSupplier>? msSupplier,
    List<MsCustomer>? msCustomer,
    DaybookFormStatus? status,
    String? message,
    String? selectedDeleteRowId,
    Id? id,
    Number? number,
    Invoice? invoice,
    Document? document,
    String? documentType,
    String? documentName,
    String? supplierName,
    String? customerName,
    TransactionDate? transactionDate,
    Company? company,
    Supplier? supplier,
    Customer? customer,
    List<DaybookDetailListModel>? daybookDetail,
    bool? isValid,
    bool? isHistory,
  }) {
    return DaybookFormState(
      msDocument: msDocument ?? this.msDocument,
      msSupplier: msSupplier ?? this.msSupplier,
      msCustomer: msCustomer ?? this.msCustomer,
      status: status ?? this.status,
      message: message ?? this.message,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      id: id ?? this.id,
      number: number ?? this.number,
      invoice: invoice ?? this.invoice,
      document: document ?? this.document,
      documentType: documentType ?? this.documentType,
      documentName: documentName ?? this.documentName,
      supplierName: supplierName ?? this.supplierName,
      customerName: customerName ?? this.customerName,
      transactionDate: transactionDate ?? this.transactionDate,
      company: company ?? this.company,
      supplier: supplier ?? this.supplier,
      customer: customer ?? this.customer,
      daybookDetail: daybookDetail ?? this.daybookDetail,
      isValid: isValid ?? this.isValid,
      isHistory: isHistory ?? this.isHistory,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        selectedDeleteRowId,
        id,
        number,
        invoice,
        document,
        documentType,
        documentName,
        supplierName,
        customerName,
        transactionDate,
        company,
        supplier,
        customer,
        isValid,
        isHistory
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
