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

final class ProductSearchChanged extends ProductEvent {
  const ProductSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
