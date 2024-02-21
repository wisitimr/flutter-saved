part of 'account_list_bloc.dart';

enum AccountListStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
}

extension AccountListStatusX on AccountListStatus {
  bool get isLoading => this == AccountListStatus.loading;
  bool get isSuccess => this == AccountListStatus.success;
  bool get isFailure => this == AccountListStatus.failure;
  bool get isDeleteConfirmation => this == AccountListStatus.deleteConfirmation;
  bool get isDeleted => this == AccountListStatus.deleted;
}

@immutable
final class AccountState extends Equatable {
  const AccountState({
    this.status = AccountListStatus.loading,
    this.message = '',
    this.accounts = const <AccountModel>[],
    this.filter = const <AccountModel>[],
    this.selectedDeleteRowId = '',
  });

  final AccountListStatus status;
  final String message;
  final List<AccountModel> accounts;
  final List<AccountModel> filter;
  final String selectedDeleteRowId;

  AccountState copyWith({
    AccountListStatus? status,
    String? message,
    List<AccountModel>? accounts,
    List<AccountModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return AccountState(
      status: status ?? this.status,
      message: message ?? this.message,
      accounts: accounts ?? this.accounts,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        accounts,
        filter,
        selectedDeleteRowId,
      ];
}

final class AccountLoading extends AccountState {
  @override
  List<Object> get props => [];
}

final class AccountError extends AccountState {
  @override
  List<Object> get props => [];
}
