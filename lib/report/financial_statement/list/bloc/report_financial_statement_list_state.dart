part of 'report_financial_statement_list_bloc.dart';

enum FinancialStatementListStatus {
  loading,
  success,
  failure,
  downloaded,
  deleteConfirmation,
  deleted,
}

extension FinancialStatementListStatusX on FinancialStatementListStatus {
  bool get isLoading => this == FinancialStatementListStatus.loading;
  bool get isSuccess => this == FinancialStatementListStatus.success;
  bool get isDownloaded => this == FinancialStatementListStatus.downloaded;
  bool get isFailure => this == FinancialStatementListStatus.failure;
  bool get isDeleteConfirmation =>
      this == FinancialStatementListStatus.deleteConfirmation;
  bool get isDeleted => this == FinancialStatementListStatus.deleted;
}

@immutable
final class FinancialStatementListState extends Equatable {
  const FinancialStatementListState({
    this.status = FinancialStatementListStatus.loading,
    this.message = '',
    this.daybooks = const <FinancialStatementListModel>[],
    this.filter = const <FinancialStatementListModel>[],
    this.selectedDeleteRowId = '',
    this.isHistory = false,
    this.yearList = const <int>[],
    this.year = 0,
  });

  final List<FinancialStatementListModel> daybooks;
  final List<FinancialStatementListModel> filter;
  final FinancialStatementListStatus status;
  final String message;
  final String selectedDeleteRowId;
  final bool isHistory;
  final List<int> yearList;
  final int year;

  FinancialStatementListState copyWith({
    FinancialStatementListStatus? status,
    String? message,
    List<FinancialStatementListModel>? daybooks,
    List<FinancialStatementListModel>? filter,
    String? selectedDeleteRowId,
    bool? isHistory,
    List<int>? yearList,
    int? year,
  }) {
    return FinancialStatementListState(
      status: status ?? this.status,
      message: message ?? this.message,
      daybooks: daybooks ?? this.daybooks,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      isHistory: isHistory ?? this.isHistory,
      yearList: yearList ?? this.yearList,
      year: year ?? this.year,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        daybooks,
        filter,
        selectedDeleteRowId,
        isHistory,
        yearList,
        year,
      ];
}

final class FinancialStatementListLoading extends FinancialStatementListState {
  @override
  List<Object> get props => [];
}

final class FinancialStatementListError extends FinancialStatementListState {
  @override
  List<Object> get props => [];
}
