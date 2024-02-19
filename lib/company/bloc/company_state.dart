part of 'company_bloc.dart';

final class CompanyState extends Equatable {
  const CompanyState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.id = const Id.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.address = const Address.pure(),
    this.phone = const Phone.pure(),
    this.contact = const Contact.pure(),
    this.isValid = false,
  });

  final bool isLoading;
  final FormzSubmissionStatus status;
  final String message;
  final Id id;
  final Name name;
  final Description description;
  final Address address;
  final Phone phone;
  final Contact contact;
  final bool isValid;

  CompanyState copyWith({
    bool? isLoading,
    FormzSubmissionStatus? status,
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
      isLoading: isLoading ?? this.isLoading,
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
  List<Object> get props => [
        isLoading,
        status,
        id,
        name,
        description,
        address,
        phone,
        contact,
        isValid
      ];
}

final class CompanyLoading extends CompanyState {
  @override
  List<Object> get props => [];
}

final class CompanyError extends CompanyState {
  @override
  List<Object> get props => [];
}
