part of 'account_list_bloc.dart';

@immutable
sealed class AccountEvent extends Equatable {
  const AccountEvent();
}

final class AccountStarted extends AccountEvent {
  const AccountStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}

final class AccountSearchChanged extends AccountEvent {
  const AccountSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}
