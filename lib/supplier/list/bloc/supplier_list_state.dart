part of 'supplier_list_bloc.dart';

enum Status { loading, success, failure }

@immutable
final class SupplierState extends Equatable {
  const SupplierState({
    this.status = Status.loading,
    this.message = '',
    this.suppliers = const <SupplierModel>[],
    this.filter = const <SupplierModel>[],
  });

  final Status status;
  final String message;
  final List<SupplierModel> suppliers;
  final List<SupplierModel> filter;

  SupplierState copyWith({
    Status? status,
    String? message,
    List<SupplierModel>? suppliers,
    List<SupplierModel>? filter,
  }) {
    return SupplierState(
      status: status ?? this.status,
      message: message ?? this.message,
      suppliers: suppliers ?? this.suppliers,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [status, message, suppliers, filter];
}

final class SupplierLoading extends SupplierState {
  @override
  List<Object> get props => [];
}

final class SupplierError extends SupplierState {
  @override
  List<Object> get props => [];
}
