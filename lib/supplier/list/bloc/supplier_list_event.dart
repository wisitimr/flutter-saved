part of 'supplier_list_bloc.dart';

@immutable
sealed class SupplierEvent extends Equatable {
  const SupplierEvent();
}

final class SupplierStarted extends SupplierEvent {
  const SupplierStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class SupplierSearchChanged extends SupplierEvent {
  const SupplierSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
