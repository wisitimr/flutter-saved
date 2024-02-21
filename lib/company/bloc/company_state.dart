part of 'company_bloc.dart';

enum CompanyStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension CompanyStatusX on CompanyStatus {
  bool get isLoading => this == CompanyStatus.loading;
  bool get isSuccess => this == CompanyStatus.success;
  bool get isFailure => this == CompanyStatus.failure;
  bool get isSubmitConfirmation => this == CompanyStatus.submitConfirmation;
  bool get isSubmited => this == CompanyStatus.submited;
}

final class CompanyState extends Equatable {
  const CompanyState({
    this.status = CompanyStatus.loading,
    this.message = '',
    this.id = const Id.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.address = const Address.pure(),
    this.phone = const Phone.pure(),
    this.contact = const Contact.pure(),
    this.isValid = false,
  });

  final CompanyStatus status;
  final String message;
  final Id id;
  final Name name;
  final Description description;
  final Address address;
  final Phone phone;
  final Contact contact;
  final bool isValid;

  CompanyState copyWith({
    CompanyStatus? status,
    String? message,
    Id? id,
    Name? name,
    Description? description,
    Address? address,
    Phone? phone,
    Contact? contact,
    bool? isValid,
  }) {
    return CompanyState(
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      contact: contact ?? this.contact,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [status, id, name, description, address, phone, contact, isValid];
}

final class CompanyLoading extends CompanyState {
  @override
  List<Object> get props => [];
}

final class CompanyError extends CompanyState {
  @override
  List<Object> get props => [];
}
