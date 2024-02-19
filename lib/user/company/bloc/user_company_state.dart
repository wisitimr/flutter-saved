part of 'user_company_bloc.dart';

final class UserCompanyState extends Equatable {
  const UserCompanyState({
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

  UserCompanyState copyWith({
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
    return UserCompanyState(
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

final class UserCompanyLoading extends UserCompanyState {
  @override
  List<Object> get props => [];
}

final class UserCompanyError extends UserCompanyState {
  @override
  List<Object> get props => [];
}
