part of 'report_ledger_account_list_bloc.dart';

enum ReportLedgerAccountListStatus {
  loading,
  success,
  failure,
  downloaded,
  dialogShow,
}

extension ReportLedgerAccountListStatusX on ReportLedgerAccountListStatus {
  bool get isLoading => this == ReportLedgerAccountListStatus.loading;
  bool get isSuccess => this == ReportLedgerAccountListStatus.success;
  bool get isDownloaded => this == ReportLedgerAccountListStatus.downloaded;
  bool get isFailure => this == ReportLedgerAccountListStatus.failure;
  bool get isShowDialog => this == ReportLedgerAccountListStatus.dialogShow;
}

@immutable
final class ReportLedgerAccountListState extends Equatable {
  const ReportLedgerAccountListState({
    this.status = ReportLedgerAccountListStatus.loading,
    this.message = '',
    this.ledgers = const <ReportLedgerAccountListModel>[],
    this.ledger = const ReportLedgerAccountListModel(
      code: '',
      name: '',
      accountDetail: <AccountDetail>[],
    ),
    this.ledgetFilter = const <ReportLedgerAccountListModel>[],
    this.selectedDeleteRowId = '',
    this.isHistory = false,
    this.yearList = const <int>[],
    this.year = 0,
    this.accounts = const [],
    this.count = 0,
    this.searchText = "",
  });

  final List<ReportLedgerAccountListModel> ledgers;
  final ReportLedgerAccountListModel ledger;
  final List<ReportLedgerAccountListModel> ledgetFilter;
  final ReportLedgerAccountListStatus status;
  final String message;
  final String selectedDeleteRowId;
  final bool isHistory;
  final List<int> yearList;
  final int year;
  final List accounts;
  final int count;
  final String searchText;

  ReportLedgerAccountListState copyWith({
    ReportLedgerAccountListStatus? status,
    String? message,
    List<ReportLedgerAccountListModel>? ledgers,
    ReportLedgerAccountListModel? ledger,
    List<ReportLedgerAccountListModel>? ledgetFilter,
    String? selectedDeleteRowId,
    bool? isHistory,
    List<int>? yearList,
    int? year,
    List? accounts,
    int? count,
    String? searchText,
  }) {
    return ReportLedgerAccountListState(
      status: status ?? this.status,
      message: message ?? this.message,
      ledgers: ledgers ?? this.ledgers,
      ledger: ledger ?? this.ledger,
      ledgetFilter: ledgetFilter ?? this.ledgetFilter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      isHistory: isHistory ?? this.isHistory,
      yearList: yearList ?? this.yearList,
      year: year ?? this.year,
      accounts: accounts ?? this.accounts,
      count: count ?? this.count,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        ledgers,
        ledger,
        ledgetFilter,
        selectedDeleteRowId,
        isHistory,
        yearList,
        year,
        accounts,
        count,
        searchText,
      ];
}

final class ReportLedgerAccountListLoading
    extends ReportLedgerAccountListState {
  @override
  List<Object> get props => [];
}

final class ReportLedgerAccountListError extends ReportLedgerAccountListState {
  @override
  List<Object> get props => [];
}
