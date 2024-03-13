part of 'report_financial_statement_list_bloc.dart';

enum ReportFinancialStatementListStatus {
  loading,
  success,
  failure,
  downloaded,
  ledgerDialog,
  accountBlanceDialog,
}

extension ReportFinancialStatementListStatusX
    on ReportFinancialStatementListStatus {
  bool get isLoading => this == ReportFinancialStatementListStatus.loading;
  bool get isSuccess => this == ReportFinancialStatementListStatus.success;
  bool get isDownloaded =>
      this == ReportFinancialStatementListStatus.downloaded;
  bool get isFailure => this == ReportFinancialStatementListStatus.failure;
  bool get isShowLedgerDialog =>
      this == ReportFinancialStatementListStatus.ledgerDialog;
  bool get isShowAccountBlance =>
      this == ReportFinancialStatementListStatus.accountBlanceDialog;
}

@immutable
final class ReportFinancialStatementListState extends Equatable {
  const ReportFinancialStatementListState({
    this.status = ReportFinancialStatementListStatus.loading,
    this.message = '',
    this.ledgers = const <ReportFinancialStatementListModel>[],
    this.ledger = const ReportFinancialStatementListModel(
      code: '',
      name: '',
      accountDetail: <AccountDetail>[],
    ),
    this.ledgetFilter = const <ReportFinancialStatementListModel>[],
    this.accountBalances = const <AccountBalance>[],
    this.accountBalance = const AccountBalance(
      accountGroup: '',
      sumForwardDr: 0,
      sumForwardCr: 0,
      sumJanDr: 0,
      sumJanCr: 0,
      sumFebDr: 0,
      sumFebCr: 0,
      sumMarDr: 0,
      sumMarCr: 0,
      sumAprDr: 0,
      sumAprCr: 0,
      sumMayDr: 0,
      sumMayCr: 0,
      sumJunDr: 0,
      sumJunCr: 0,
      sumJulDr: 0,
      sumJulCr: 0,
      sumAugDr: 0,
      sumAugCr: 0,
      sumSepDr: 0,
      sumSepCr: 0,
      sumOctDr: 0,
      sumOctCr: 0,
      sumNovDr: 0,
      sumNovCr: 0,
      sumDecDr: 0,
      sumDecCr: 0,
      sumTotalDr: 0,
      sumTotalCr: 0,
      sumBalance: 0,
      child: <ChildAccountBalance>[],
    ),
    this.selectedDeleteRowId = '',
    this.isHistory = false,
    this.yearList = const <int>[],
    this.year = 0,
    this.accounts = const [],
    this.count = 0,
    this.searchText = "",
    this.columnSelected = const [],
    this.isForwardDrShow = true,
    this.isForwardCrShow = true,
    this.isJanDrShow = false,
    this.isJanCrShow = false,
    this.isFebDrShow = false,
    this.isFebCrShow = false,
    this.isMarDrShow = false,
    this.isMarCrShow = false,
    this.isAprDrShow = false,
    this.isAprCrShow = false,
    this.isMayDrShow = false,
    this.isMayCrShow = false,
    this.isJunDrShow = false,
    this.isJunCrShow = false,
    this.isJulDrShow = false,
    this.isJulCrShow = false,
    this.isAugDrShow = false,
    this.isAugCrShow = false,
    this.isSepDrShow = false,
    this.isSepCrShow = false,
    this.isOctDrShow = false,
    this.isOctCrShow = false,
    this.isNovDrShow = false,
    this.isNovCrShow = false,
    this.isDecDrShow = false,
    this.isDecCrShow = false,
    this.isTotalDrShow = true,
    this.isTotalCrShow = true,
    this.isBalanceShow = true,
  });

  final List<ReportFinancialStatementListModel> ledgers;
  final ReportFinancialStatementListModel ledger;
  final List<ReportFinancialStatementListModel> ledgetFilter;
  final List<AccountBalance> accountBalances;
  final AccountBalance accountBalance;
  final ReportFinancialStatementListStatus status;
  final String message;
  final String selectedDeleteRowId;
  final bool isHistory;
  final List<int> yearList;
  final int year;
  final List accounts;
  final int count;
  final String searchText;
  final List columnSelected;
  final bool isForwardDrShow;
  final bool isForwardCrShow;
  final bool isJanDrShow;
  final bool isJanCrShow;
  final bool isFebDrShow;
  final bool isFebCrShow;
  final bool isMarDrShow;
  final bool isMarCrShow;
  final bool isAprDrShow;
  final bool isAprCrShow;
  final bool isMayDrShow;
  final bool isMayCrShow;
  final bool isJunDrShow;
  final bool isJunCrShow;
  final bool isJulDrShow;
  final bool isJulCrShow;
  final bool isAugDrShow;
  final bool isAugCrShow;
  final bool isSepDrShow;
  final bool isSepCrShow;
  final bool isOctDrShow;
  final bool isOctCrShow;
  final bool isNovDrShow;
  final bool isNovCrShow;
  final bool isDecDrShow;
  final bool isDecCrShow;
  final bool isTotalDrShow;
  final bool isTotalCrShow;
  final bool isBalanceShow;

  ReportFinancialStatementListState copyWith({
    ReportFinancialStatementListStatus? status,
    String? message,
    List<ReportFinancialStatementListModel>? ledgers,
    ReportFinancialStatementListModel? ledger,
    List<ReportFinancialStatementListModel>? ledgetFilter,
    List<AccountBalance>? accountBalances,
    AccountBalance? accountBalance,
    String? selectedDeleteRowId,
    bool? isHistory,
    List<int>? yearList,
    int? year,
    List? accounts,
    int? count,
    String? searchText,
    List? columnSelected,
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
  }) {
    return ReportFinancialStatementListState(
      status: status ?? this.status,
      message: message ?? this.message,
      ledgers: ledgers ?? this.ledgers,
      ledger: ledger ?? this.ledger,
      ledgetFilter: ledgetFilter ?? this.ledgetFilter,
      accountBalances: accountBalances ?? this.accountBalances,
      accountBalance: accountBalance ?? this.accountBalance,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
      isHistory: isHistory ?? this.isHistory,
      yearList: yearList ?? this.yearList,
      year: year ?? this.year,
      accounts: accounts ?? this.accounts,
      count: count ?? this.count,
      searchText: searchText ?? this.searchText,
      columnSelected: columnSelected ?? this.columnSelected,
      isForwardDrShow: isForwardDrShow ?? this.isForwardDrShow,
      isForwardCrShow: isForwardCrShow ?? this.isForwardCrShow,
      isJanDrShow: isJanDrShow ?? this.isJanDrShow,
      isJanCrShow: isJanCrShow ?? this.isJanCrShow,
      isFebDrShow: isFebDrShow ?? this.isFebDrShow,
      isFebCrShow: isFebCrShow ?? this.isFebCrShow,
      isMarDrShow: isMarDrShow ?? this.isMarDrShow,
      isMarCrShow: isMarCrShow ?? this.isMarCrShow,
      isAprDrShow: isAprDrShow ?? this.isAprDrShow,
      isAprCrShow: isAprCrShow ?? this.isAprCrShow,
      isMayDrShow: isMayDrShow ?? this.isMayDrShow,
      isMayCrShow: isMayCrShow ?? this.isMayCrShow,
      isJunDrShow: isJunDrShow ?? this.isJunDrShow,
      isJunCrShow: isJunCrShow ?? this.isJunCrShow,
      isJulDrShow: isJulDrShow ?? this.isJulDrShow,
      isJulCrShow: isJulCrShow ?? this.isJulCrShow,
      isAugDrShow: isAugDrShow ?? this.isAugDrShow,
      isAugCrShow: isAugCrShow ?? this.isAugCrShow,
      isSepDrShow: isSepDrShow ?? this.isSepDrShow,
      isSepCrShow: isSepCrShow ?? this.isSepCrShow,
      isOctDrShow: isOctDrShow ?? this.isOctDrShow,
      isOctCrShow: isOctCrShow ?? this.isOctCrShow,
      isNovDrShow: isNovDrShow ?? this.isNovDrShow,
      isNovCrShow: isNovCrShow ?? this.isNovCrShow,
      isDecDrShow: isDecDrShow ?? this.isDecDrShow,
      isDecCrShow: isDecCrShow ?? this.isDecCrShow,
      isTotalDrShow: isTotalDrShow ?? this.isTotalDrShow,
      isTotalCrShow: isTotalCrShow ?? this.isTotalCrShow,
      isBalanceShow: isBalanceShow ?? this.isBalanceShow,
    );
  }

  @override
  List<Object> get props => [
        message,
        status,
        ledgers,
        ledger,
        ledgetFilter,
        accountBalances,
        accountBalance,
        selectedDeleteRowId,
        isHistory,
        yearList,
        year,
        accounts,
        count,
        searchText,
        columnSelected,
        isForwardDrShow,
        isForwardCrShow,
        isJanDrShow,
        isJanCrShow,
        isFebDrShow,
        isFebCrShow,
        isMarDrShow,
        isMarCrShow,
        isAprDrShow,
        isAprCrShow,
        isMayDrShow,
        isMayCrShow,
        isJunDrShow,
        isJunCrShow,
        isJulDrShow,
        isJulCrShow,
        isAugDrShow,
        isAugCrShow,
        isSepDrShow,
        isSepCrShow,
        isOctDrShow,
        isOctCrShow,
        isNovDrShow,
        isNovCrShow,
        isDecDrShow,
        isDecCrShow,
        isTotalDrShow,
        isTotalCrShow,
        isBalanceShow,
      ];
}

final class ReportFinancialStatementListLoading
    extends ReportFinancialStatementListState {
  @override
  List<Object> get props => [];
}

final class ReportFinancialStatementListError
    extends ReportFinancialStatementListState {
  @override
  List<Object> get props => [];
}
