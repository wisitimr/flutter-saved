part of 'customer_list_bloc.dart';

@immutable
sealed class CustomerEvent extends Equatable {
  const CustomerEvent();
}

final class CustomerStarted extends CustomerEvent {
  const CustomerStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class CustomerPageSizeChanged extends CustomerEvent {
  const CustomerPageSizeChanged(this.pageSize);

  final int pageSize;

  @override
  List<Object> get props => [pageSize];
}
