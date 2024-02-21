part of 'supplier_list_bloc.dart';

@immutable
sealed class SupplierEvent extends Equatable {
  const SupplierEvent();
}

final class SupplierStarted extends SupplierEvent {
  const SupplierStarted();

  @override
  List<Object> get props => [];
}

final class SupplierSearchChanged extends SupplierEvent {
  const SupplierSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class SupplierConfirm extends SupplierEvent {
  const SupplierConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class SupplierDelete extends SupplierEvent {
  const SupplierDelete();

  @override
  List<Object> get props => [];
}
