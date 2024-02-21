part of 'user_company_bloc.dart';

enum UserCompanyStatus {
  loading,
  success,
  failure,
  submitConfirmation,
  submited,
}

extension UserCompanyStatusX on UserCompanyStatus {
  bool get isLoading => this == UserCompanyStatus.loading;
  bool get isSuccess => this == UserCompanyStatus.success;
  bool get isFailure => this == UserCompanyStatus.failure;
  bool get isSubmitConfirmation => this == UserCompanyStatus.submitConfirmation;
  bool get isSubmited => this == UserCompanyStatus.submited;
}

final class UserCompanyState extends Equatable {
  const UserCompanyState({
    this.status = UserCompanyStatus.loading,
    this.message = '',
    this.id = const Id.pure(),
    this.name = const Name.pure(),
    this.description = const Description.pure(),
    this.address = const Address.pure(),
    this.phone = const Phone.pure(),
    this.contact = const Contact.pure(),
    this.isValid = false,
  });

  final UserCompanyStatus status;
  final String message;
  final Id id;
  final Name name;
  final Description description;
  final Address address;
  final Phone phone;
  final Contact contact;
  final bool isValid;

  UserCompanyState copyWith({
    UserCompanyStatus? status,
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

final class UserCompanyLoading extends UserCompanyState {
  @override
  List<Object> get props => [];
}

final class UserCompanyError extends UserCompanyState {
  @override
  List<Object> get props => [];
}
