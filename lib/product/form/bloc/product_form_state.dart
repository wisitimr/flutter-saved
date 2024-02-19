part of 'product_form_bloc.dart';

final class ProductFormState extends Equatable {
  const ProductFormState({
    this.isLoading = true,
    this.status = FormzSubmissionStatus.initial,
    this.message = '',
    this.id = const Id.pure(),
    this.code = const Code.pure(),
    this.name = const Name.pure(),
    this.detail = const Detail.pure(),
    this.price = const Price.pure(),
    this.isValid = false,
  });

  final bool isLoading;
  final FormzSubmissionStatus status;
  final String message;
  final Id id;
  final Code code;
  final Name name;
  final Detail detail;
  final Price price;
  final bool isValid;

  ProductFormState copyWith({
    bool? isLoading,
    FormzSubmissionStatus? status,
    String? message,
    Id? id,
    Code? code,
    Name? name,
    Detail? detail,
    Price? price,
    bool? isValid,
  }) {
    return ProductFormState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      price: price ?? this.price,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, status, id, code, name, detail, price, isValid];
}

final class ProductFormLoading extends ProductFormState {
  @override
  List<Object> get props => [];
}

final class ProductFormError extends ProductFormState {
  @override
  List<Object> get props => [];
}
