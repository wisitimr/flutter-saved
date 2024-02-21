part of 'customer_form_bloc.dart';

enum CustomerFormStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension CustomerFormStatusX on CustomerFormStatus {
  bool get isLoading => this == CustomerFormStatus.loading;
  bool get isSuccess => this == CustomerFormStatus.success;
  bool get isFailure => this == CustomerFormStatus.failure;
  bool get isSubmitConfirmation =>
      this == CustomerFormStatus.submitConfirmation;
  bool get isSubmited => this == CustomerFormStatus.submited;
}

final class CustomerFormState extends Equatable {
  const CustomerFormState({
    this.status = CustomerFormStatus.loading,
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

  final CustomerFormStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Address address;
  final Tax tax;
  final Phone phone;
  final Contact contact;
  final bool isValid;

  CustomerFormState copyWith({
    CustomerFormStatus? status,
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
    return CustomerFormState(
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

final class CustomerFormLoading extends CustomerFormState {
  @override
  List<Object> get props => [];
}

final class CustomerFormError extends CustomerFormState {
  @override
  List<Object> get props => [];
}
