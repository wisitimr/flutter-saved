part of 'account_list_bloc.dart';

@immutable
final class AccountState extends Equatable {
  const AccountState({
    this.accounts = const <AccountModel>[],
    this.pageSize = 10,
  });

  final List<AccountModel> accounts;
  final int pageSize;

  AccountState copyWith({
    int? pageSize,
  }) {
    return AccountState(
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [pageSize];
}

final class AccountLoading extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountError extends AccountState {
  @override
  List<Object> get props => [];
}
