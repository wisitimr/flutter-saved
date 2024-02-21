part of 'customer_list_bloc.dart';

enum CustomerListStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
}

extension CustomerListStatusX on CustomerListStatus {
  bool get isLoading => this == CustomerListStatus.loading;
  bool get isSuccess => this == CustomerListStatus.success;
  bool get isFailure => this == CustomerListStatus.failure;
  bool get isDeleteConfirmation =>
      this == CustomerListStatus.deleteConfirmation;
  bool get isDeleted => this == CustomerListStatus.deleted;
}

@immutable
final class CustomerState extends Equatable {
  const CustomerState({
    this.status = CustomerListStatus.loading,
    this.message = '',
    this.customers = const <CustomerModel>[],
    this.filter = const <CustomerModel>[],
    this.selectedDeleteRowId = '',
  });

  final CustomerListStatus status;
  final String message;
  final List<CustomerModel> customers;
  final List<CustomerModel> filter;
  final String selectedDeleteRowId;

  CustomerState copyWith({
    CustomerListStatus? status,
    String? message,
    List<CustomerModel>? customers,
    List<CustomerModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return CustomerState(
      status: status ?? this.status,
      message: message ?? this.message,
      customers: customers ?? this.customers,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        customers,
        filter,
        selectedDeleteRowId,
      ];
}

final class CustomerLoading extends CustomerState {
  @override
  List<Object> get props => [];
}

final class CustomerError extends CustomerState {
  @override
  List<Object> get props => [];
}
