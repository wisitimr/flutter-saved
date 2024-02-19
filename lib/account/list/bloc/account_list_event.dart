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

final class AccountPageSizeChanged extends AccountEvent {
  const AccountPageSizeChanged(this.pageSize);

  final int pageSize;

  @override
  List<Object> get props => [pageSize];
}
