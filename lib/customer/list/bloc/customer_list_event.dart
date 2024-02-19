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

final class CustomerSearchChanged extends CustomerEvent {
  const CustomerSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
