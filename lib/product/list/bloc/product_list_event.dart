part of 'product_list_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

final class ProductStarted extends ProductEvent {
  const ProductStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class ProductPageSizeChanged extends ProductEvent {
  const ProductPageSizeChanged(this.pageSize);

  final int pageSize;

  @override
  List<Object> get props => [pageSize];
}
