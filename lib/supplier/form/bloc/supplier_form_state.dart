part of 'supplier_form_bloc.dart';

enum SupplierFormStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension SupplierFormStatusX on SupplierFormStatus {
  bool get isLoading => this == SupplierFormStatus.loading;
  bool get isSuccess => this == SupplierFormStatus.success;
  bool get isFailure => this == SupplierFormStatus.failure;
  bool get isSubmitConfirmation =>
      this == SupplierFormStatus.submitConfirmation;
  bool get isSubmited => this == SupplierFormStatus.submited;
}

final class SupplierFormState extends Equatable {
  const SupplierFormState({
    this.status = SupplierFormStatus.loading,
    this.message = '',
    this.id = const Id.pure(),
    this.code = const Code.pure(),
    this.name = const Name.pure(),
    this.address = const Address.pure(),
    this.tax = const Tax.pure(),
    this.phone = const Phone.pure(),
    this.contact = const Contact.pure(),
    this.isValid = false,
  });

  final SupplierFormStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Address address;
  final Tax tax;
  final Phone phone;
  final Contact contact;
  final bool isValid;

  SupplierFormState copyWith({
    SupplierFormStatus? status,
    String? message,
    Id? id,
    Code? code,
    Name? name,
    Address? address,
    Tax? tax,
    Phone? phone,
    Contact? contact,
    bool? isValid,
  }) {
    return SupplierFormState(
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      address: address ?? this.address,
      tax: tax ?? this.tax,
      phone: phone ?? this.phone,
      contact: contact ?? this.contact,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [
        status,
        id,
        code,
        name,
        address,
        tax,
        phone,
        contact,
        isValid,
      ];
}

final class SupplierFormLoading extends SupplierFormState {
  @override
  List<Object> get props => [];
}

final class SupplierFormError extends SupplierFormState {
  @override
  List<Object> get props => [];
}
