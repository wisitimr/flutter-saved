part of 'supplier_form_bloc.dart';

final class SupplierFormState extends Equatable {
  const SupplierFormState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
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

  final bool isLoading;
  final FormzSubmissionStatus status;
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
    bool? isLoading,
    FormzSubmissionStatus? status,
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
      isLoading: isLoading ?? this.isLoading,
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
        isLoading,
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
