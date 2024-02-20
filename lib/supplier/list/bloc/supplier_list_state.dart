part of 'supplier_list_bloc.dart';

enum Status { loading, success, failure, deleted, confirmation }

extension StatusX on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isDeleted => this == Status.deleted;
  bool get isConfirmation => this == Status.confirmation;
}

@immutable
final class SupplierState extends Equatable {
  const SupplierState({
    this.status = Status.loading,
    this.message = '',
    this.suppliers = const <SupplierModel>[],
    this.filter = const <SupplierModel>[],
    this.selectedRowId = '',
  });

  final Status status;
  final String message;
  final List<SupplierModel> suppliers;
  final List<SupplierModel> filter;
  final String selectedRowId;

  SupplierState copyWith({
    Status? status,
    String? message,
    List<SupplierModel>? suppliers,
    List<SupplierModel>? filter,
    String? selectedRowId,
  }) {
    return SupplierState(
      status: status ?? this.status,
      message: message ?? this.message,
      suppliers: suppliers ?? this.suppliers,
      filter: filter ?? this.filter,
      selectedRowId: selectedRowId ?? this.selectedRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        suppliers,
        filter,
        selectedRowId,
      ];
}

final class SupplierLoading extends SupplierState {
  @override
  List<Object> get props => [];
}

final class SupplierError extends SupplierState {
  @override
  List<Object> get props => [];
}
