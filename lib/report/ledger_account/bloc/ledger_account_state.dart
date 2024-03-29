part of 'ledger_account_bloc.dart';

enum ReportLedgerAccountStatus {
  loading,
  success,
  failure,
  downloaded,
  ledgerDialog,
}

extension ReportLedgerAccountStatusX on ReportLedgerAccountStatus {
  bool get isLoading => this == ReportLedgerAccountStatus.loading;
  bool get isSuccess => this == ReportLedgerAccountStatus.success;
  bool get isDownloaded => this == ReportLedgerAccountStatus.downloaded;
  bool get isFailure => this == ReportLedgerAccountStatus.failure;
  bool get isShowLedgerDialog => this == ReportLedgerAccountStatus.ledgerDialog;
}

@immutable
final class ReportLedgerAccountState extends Equatable {
  const ReportLedgerAccountState({
    this.status = ReportLedgerAccountStatus.loading,
    this.message = '',
    this.ledgers = const <ReportLedgerAccountModel>[],
    this.ledger = const ReportLedgerAccountModel(
      code: '',
      name: '',
      accountDetail: <AccountDetail>[],
    ),
    this.ledgetFilter = const <ReportLedgerAccountModel>[],
    this.selectedDeleteRowId = '',
    this.isHistory = false,
    this.yearList = const <int>[],
    this.year = 0,
    this.accounts = const [],
    this.count = 0,
    this.searchText = "",
  });

  final List<ReportLedgerAccountModel> ledgers;
  final ReportLedgerAccountModel ledger;
  final List<ReportLedgerAccountModel> ledgetFilter;
  final ReportLedgerAccountStatus status;
  final String message;
  final String selectedDeleteRowId;
  final bool isHistory;
  final List<int> yearList;
  final int year;
  final List accounts;
  final int count;
  final String searchText;

  ReportLedgerAccountState copyWith({
    ReportLedgerAccountStatus? status,
    String? message,
    List<ReportLedgerAccountModel>? ledgers,
    ReportLedgerAccountModel? ledger,
    List<ReportLedgerAccountModel>? ledgetFilter,
    String? selectedDeleteRowId,
    bool? isHistory,
    List<int>? yearList,
    int? year,
    List? accounts,
    int? count,
    String? searchText,
    bool? isForwardDrShow,
    bool? isForwardCrShow,
    bool? isJanDrShow,
    bool? isJanCrShow,
    bool? isFebDrShow,
    bool? isFebCrShow,
    bool? isMarDrShow,
    bool? isMarCrShow,
    bool? isAprDrShow,
    bool? isAprCrShow,
    bool? isMayDrShow,
    bool? isMayCrShow,
    bool? isJunDrShow,
    bool? isJunCrShow,
    bool? isJulDrShow,
    bool? isJulCrShow,
    bool? isAugDrShow,
    bool? isAugCrShow,
    bool? isSepDrShow,
    bool? isSepCrShow,
    bool? isOctDrShow,
    bool? isOctCrShow,
    bool? isNovDrShow,
    bool? isNovCrShow,
    bool? isDecDrShow,
    bool? isDecCrShow,
    bool? isTotalDrShow,
    bool? isTotalCrShow,
    bool? isBalanceShow,
    bool? isSelectAll,
  }) {
    return ReportLedgerAccountState(
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

final class ReportLedgerAccountLoading extends ReportLedgerAccountState {
  @override
  List<Object> get props => [];
}

final class ReportLedgerAccountError extends ReportLedgerAccountState {
  @override
  List<Object> get props => [];
}
