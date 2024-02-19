part of 'account_list_bloc.dart';

enum Status { loading, success, failure }

@immutable
final class AccountState extends Equatable {
  const AccountState({
    this.status = Status.loading,
    this.message = '',
    this.accounts = const <AccountModel>[],
    this.filter = const <AccountModel>[],
  });

  final Status status;
  final String message;
  final List<AccountModel> accounts;
  final List<AccountModel> filter;

  AccountState copyWith({
    Status? status,
    String? message,
    List<AccountModel>? accounts,
    List<AccountModel>? filter,
  }) {
    return AccountState(
      status: status ?? this.status,
      message: message ?? this.message,
      accounts: accounts ?? this.accounts,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [message, status, accounts, filter];
}

final class AccountLoading extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountError extends AccountState {
  @override
  List<Object> get props => [];
}
