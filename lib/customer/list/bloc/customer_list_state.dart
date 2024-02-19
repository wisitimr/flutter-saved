part of 'customer_list_bloc.dart';

enum Status { loading, success, failure }

@immutable
final class CustomerState extends Equatable {
  const CustomerState({
    this.status = Status.loading,
    this.message = '',
    this.customers = const <CustomerModel>[],
    this.filter = const <CustomerModel>[],
  });

  final Status status;
  final String message;
  final List<CustomerModel> customers;
  final List<CustomerModel> filter;

  CustomerState copyWith({
    Status? status,
    String? message,
    List<CustomerModel>? customers,
    List<CustomerModel>? filter,
  }) {
    return CustomerState(
      status: status ?? this.status,
      message: message ?? this.message,
      customers: customers ?? this.customers,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [status, message, customers, filter];
}

final class CustomerLoading extends CustomerState {
  @override
  List<Object> get props => [];
}

final class CustomerError extends CustomerState {
  @override
  List<Object> get props => [];
}
