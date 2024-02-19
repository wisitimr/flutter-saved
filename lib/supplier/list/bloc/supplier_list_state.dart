part of 'supplier_list_bloc.dart';

@immutable
final class SupplierState extends Equatable {
  const SupplierState({
    this.suppliers = const <SupplierModel>[],
    this.pageSize = 10,
  });

  final List<SupplierModel> suppliers;
  final int pageSize;

  SupplierState copyWith({
    int? pageSize,
  }) {
    return SupplierState(
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [pageSize];
}

final class SupplierLoading extends SupplierState {
  @override
  List<Object> get props => [];
}

final class SupplierError extends SupplierState {
  @override
  List<Object> get props => [];
}
