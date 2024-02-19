part of 'product_list_bloc.dart';

@immutable
final class ProductState extends Equatable {
  const ProductState({
    this.products = const <ProductModel>[],
    this.pageSize = 10,
  });

  final List<ProductModel> products;
  final int pageSize;

  ProductState copyWith({
    int? pageSize,
  }) {
    return ProductState(
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [pageSize];
}

final class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductError extends ProductState {
  @override
  List<Object> get props => [];
}
