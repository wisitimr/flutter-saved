part of 'product_list_bloc.dart';

enum ProductListStatus {
  loading,
  success,
  failure,
  deleted,
  deleteConfirmation
}

extension ProductListStatusX on ProductListStatus {
  bool get isLoading => this == ProductListStatus.loading;
  bool get isSuccess => this == ProductListStatus.success;
  bool get isFailure => this == ProductListStatus.failure;
  bool get isDeleted => this == ProductListStatus.deleted;
  bool get isDeleteConfirmation => this == ProductListStatus.deleteConfirmation;
}

@immutable
final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductListStatus.loading,
    this.message = '',
    this.products = const <ProductModel>[],
    this.filter = const <ProductModel>[],
    this.selectedDeleteRowId = '',
  });

  final ProductListStatus status;
  final String message;
  final List<ProductModel> products;
  final List<ProductModel> filter;
  final String selectedDeleteRowId;

  ProductState copyWith({
    ProductListStatus? status,
    String? message,
    List<ProductModel>? products,
    List<ProductModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return ProductState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        products,
        filter,
        selectedDeleteRowId,
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
