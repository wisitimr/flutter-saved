part of 'customer_list_bloc.dart';

@immutable
sealed class CustomerEvent extends Equatable {
  const CustomerEvent();
}

final class CustomerStarted extends CustomerEvent {
  const CustomerStarted();

  @override
  List<Object> get props => [];
}

final class CustomerSearchChanged extends CustomerEvent {
  const CustomerSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class CustomerConfirm extends CustomerEvent {
  const CustomerConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class CustomerDelete extends CustomerEvent {
  const CustomerDelete(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
