part of 'supplier_list_bloc.dart';

enum SupplierStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
}

extension SupplierStatusX on SupplierStatus {
  bool get isLoading => this == SupplierStatus.loading;
  bool get isSuccess => this == SupplierStatus.success;
  bool get isFailure => this == SupplierStatus.failure;
  bool get isDeleteConfirmation => this == SupplierStatus.deleteConfirmation;
  bool get isDeleted => this == SupplierStatus.deleted;
}

@immutable
final class SupplierState extends Equatable {
  const SupplierState({
    this.status = SupplierStatus.loading,
    this.message = '',
    this.suppliers = const <SupplierModel>[],
    this.filter = const <SupplierModel>[],
    this.selectedDeleteRowId = '',
  });

  final SupplierStatus status;
  final String message;
  final List<SupplierModel> suppliers;
  final List<SupplierModel> filter;
  final String selectedDeleteRowId;

  SupplierState copyWith({
    SupplierStatus? status,
    String? message,
    List<SupplierModel>? suppliers,
    List<SupplierModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return SupplierState(
      status: status ?? this.status,
      message: message ?? this.message,
      suppliers: suppliers ?? this.suppliers,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        suppliers,
        filter,
        selectedDeleteRowId,
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
