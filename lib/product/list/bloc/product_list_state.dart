part of 'product_list_bloc.dart';

enum Status { loading, success, failure, deleted, confirmation }

extension StatusX on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isDeleted => this == Status.deleted;
  bool get isConfirmation => this == Status.confirmation;
}

@immutable
final class ProductState extends Equatable {
  const ProductState({
    this.status = Status.loading,
    this.message = '',
    this.products = const <ProductModel>[],
    this.filter = const <ProductModel>[],
    this.selectedRowId = '',
  });

  final Status status;
  final String message;
  final List<ProductModel> products;
  final List<ProductModel> filter;
  final String selectedRowId;

  ProductState copyWith({
    Status? status,
    String? message,
    List<ProductModel>? products,
    List<ProductModel>? filter,
    String? selectedRowId,
  }) {
    return ProductState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      filter: filter ?? this.filter,
      selectedRowId: selectedRowId ?? this.selectedRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        products,
        filter,
        selectedRowId,
      ];
}

final class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
