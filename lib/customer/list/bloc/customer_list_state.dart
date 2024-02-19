part of 'customer_list_bloc.dart';

@immutable
final class CustomerState extends Equatable {
  const CustomerState({
    this.customers = const <CustomerModel>[],
    this.pageSize = 10,
  });

  final List<CustomerModel> customers;
  final int pageSize;

  CustomerState copyWith({
    int? pageSize,
  }) {
    return CustomerState(
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [pageSize];
}

final class CustomerLoading extends CustomerState {
  @override
  List<Object> get props => [];
}

final class CustomerError extends CustomerState {
  @override
  List<Object> get props => [];
}
