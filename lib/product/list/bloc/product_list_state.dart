part of 'product_list_bloc.dart';

enum Status { loading, success, failure }

@immutable
final class ProductState extends Equatable {
  const ProductState({
    this.status = Status.loading,
    this.message = '',
    this.products = const <ProductModel>[],
    this.filter = const <ProductModel>[],
  });

  final Status status;
  final String message;
  final List<ProductModel> products;
  final List<ProductModel> filter;

  ProductState copyWith({
    Status? status,
    String? message,
    List<ProductModel>? products,
    List<ProductModel>? filter,
  }) {
    return ProductState(
      status: status ?? this.status,
      message: message ?? this.message,
      products: products ?? this.products,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [status, message, products, filter];
}

final class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
