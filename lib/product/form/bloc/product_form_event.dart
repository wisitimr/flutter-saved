part of 'product_form_bloc.dart';

@immutable
sealed class ProductFormEvent extends Equatable {
  const ProductFormEvent();

  @override
  List<Object> get props => [];
}

final class ProductFormStarted extends ProductFormEvent {
  const ProductFormStarted(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class ProductFormIdChanged extends ProductFormEvent {
  const ProductFormIdChanged(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class ProductFormCodeChanged extends ProductFormEvent {
  const ProductFormCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class ProductFormNameChanged extends ProductFormEvent {
  const ProductFormNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class ProductFormDescriptionChanged extends ProductFormEvent {
  const ProductFormDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class ProductFormPriceChanged extends ProductFormEvent {
  const ProductFormPriceChanged(this.price);

  final String price;

  @override
  List<Object> get props => [price];
}

final class ProductSubmitted extends ProductFormEvent {
  const ProductSubmitted();

  @override
  List<Object> get props => [];
}
