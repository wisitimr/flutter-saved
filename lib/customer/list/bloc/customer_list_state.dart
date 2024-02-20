part of 'customer_list_bloc.dart';

enum Status { loading, success, failure, deleted, confirmation }

extension StatusX on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isDeleted => this == Status.deleted;
  bool get isConfirmation => this == Status.confirmation;
}

@immutable
final class CustomerState extends Equatable {
  const CustomerState({
    this.status = Status.loading,
    this.message = '',
    this.customers = const <CustomerModel>[],
    this.filter = const <CustomerModel>[],
    this.selectedRowId = '',
  });

  final Status status;
  final String message;
  final List<CustomerModel> customers;
  final List<CustomerModel> filter;
  final String selectedRowId;

  CustomerState copyWith({
    Status? status,
    String? message,
    List<CustomerModel>? customers,
    List<CustomerModel>? filter,
    String? selectedRowId,
  }) {
    return CustomerState(
      status: status ?? this.status,
      message: message ?? this.message,
      customers: customers ?? this.customers,
      filter: filter ?? this.filter,
      selectedRowId: selectedRowId ?? this.selectedRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        customers,
        filter,
        selectedRowId,
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
