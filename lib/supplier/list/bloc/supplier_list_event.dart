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

final class SupplierPageSizeChanged extends SupplierEvent {
  const SupplierPageSizeChanged(this.pageSize);

  final int pageSize;

  @override
  List<Object> get props => [pageSize];
}
