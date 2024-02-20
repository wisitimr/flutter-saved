part of 'account_list_bloc.dart';

enum Status { loading, success, failure, deleted, confirmation }

extension StatusX on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isFailure => this == Status.failure;
  bool get isDeleted => this == Status.deleted;
  bool get isConfirmation => this == Status.confirmation;
}

@immutable
final class AccountState extends Equatable {
  const AccountState({
    this.status = Status.loading,
    this.message = '',
    this.accounts = const <AccountModel>[],
    this.filter = const <AccountModel>[],
    this.selectedRowId = '',
  });

  final Status status;
  final String message;
  final List<AccountModel> accounts;
  final List<AccountModel> filter;
  final String selectedRowId;

  AccountState copyWith({
    Status? status,
    String? message,
    List<AccountModel>? accounts,
    List<AccountModel>? filter,
    String? selectedRowId,
  }) {
    return AccountState(
      status: status ?? this.status,
      message: message ?? this.message,
      accounts: accounts ?? this.accounts,
      filter: filter ?? this.filter,
      selectedRowId: selectedRowId ?? this.selectedRowId,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        accounts,
        filter,
        selectedRowId,
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
