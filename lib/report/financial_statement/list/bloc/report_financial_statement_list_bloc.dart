import 'package:equatable/equatable.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/core/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/report/financial_statement/list/models/models.dart';

part 'report_financial_statement_list_event.dart';
part 'report_financial_statement_list_state.dart';

class ReportFinancialStatementListBloc extends Bloc<
    ReportFinancialStatementListEvent, ReportFinancialStatementListState> {
  ReportFinancialStatementListBloc(AppProvider provider)
      : _provider = provider,
        super(ReportFinancialStatementListLoading()) {
    on<ReportFinancialStatementListStarted>(_onStarted);
    on<ReportFinancialStatementListYearSelected>(_onYearSelected);
    on<ReportFinancialStatementListPreviewLedgerAccount>(
        _onPreviewLedgerAccount);
    on<ReportFinancialStatementListPreviewAccountBalance>(
        _onPreviewAccountBalance);
    on<ReportFinancialStatementListSearchChanged>(_onSearchChanged);
    on<ReportFinancialStatementListAccountBalanceColumnSelected>(
        _onColumnSelected);
    on<ReportFinancialStatementListAccountBalanceColumnSelectedAll>(
        _onColumnSelectedAll);
    on<ReportFinancialStatementListAccountBalanceColumnSelectedDefault>(
        _onColumnSelectedDefault);
    on<ReportFinancialStatementListDownload>(_onDownloadFinancialStatement);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();
  final ReportService _reportService = ReportService();

  Future<void> _onStarted(
    ReportFinancialStatementListStarted event,
    Emitter<ReportFinancialStatementListState> emit,
  ) async {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    try {
      final company = _provider.companyId;
      DateTime now = DateTime.now();
      List accounts = [];
      List<int> y = [];
      int daybookCount = 0;
      int yearSelected = event.year;
      if (yearSelected == 0) {
        yearSelected = now.year;
      }
      for (var i = 0; i < 15; i++) {
        var newDate = DateTime(now.year - i);
        y.add(newDate.year);
      }
      if (company.isNotEmpty) {
        Map<String, dynamic> paramCount = {};
        paramCount['company'] = company;
        paramCount['transactionDate.gte'] =
            "${yearSelected.toString()}-01-01T00:00:00.000Z";
        paramCount['transactionDate.lt'] =
            "${yearSelected + 1}-01-01T00:00:00.000Z";

        final res = await _daybookService.count(_provider, paramCount);
        if (res['statusCode'] == 200) {
          daybookCount = res['data']['count'];
        }
      }
      final [ledgerRes, accountBalanceRes] = await Future.wait([
        _reportService.findLedgerAccount(
            _provider, company, yearSelected.toString()),
        _reportService.findAccountBalance(
            _provider, company, yearSelected.toString()),
      ]);
      List<ReportFinancialStatementListModel> ledgers = [];
      List<AccountBalance> accountBalances = [];
      if (ledgerRes['statusCode'] == 200) {
        var data = ledgerRes['data'] != null ? ledgerRes['data'] as List : [];
        if (data.isNotEmpty) {
          ledgers = data
              .map((item) => ReportFinancialStatementListModel.fromJson(item))
              .toList();

          double drBalance = 0;
          double crBalance = 0;
          for (var element in ledgers) {
            for (var element2 in element.accountDetail) {
              drBalance += element2.amountDr;
              crBalance += element2.amountCr;
            }
            Map<String, dynamic> acc = {};
            acc['code'] = element.code;
            acc['name'] = "${element.code} - ${element.name}";
            accounts.add(acc);
            element.accountDetail.add(
              const AccountDetail(
                month: '',
                date: 0,
                detail: '',
                number: '',
                amountDr: 0,
                amountCr: 0,
              ),
            );
            element.accountDetail.add(
              AccountDetail(
                month: '',
                date: 0,
                detail: 'รวม',
                number: '',
                amountDr: drBalance,
                amountCr: crBalance,
              ),
            );
          }
        }
      }
      if (accountBalanceRes['statusCode'] == 200) {
        var data = accountBalanceRes['data'] != null
            ? accountBalanceRes['data'] as List
            : [];
        if (data.isNotEmpty) {
          accountBalances =
              data.map((item) => AccountBalance.fromJson(item)).toList();
        }
      }
      List<int> columns = [];
      if (state.isForwardDrShow) {
        columns.add(0);
      }
      if (state.isForwardCrShow) {
        columns.add(1);
      }
      if (state.isJanDrShow) {
        columns.add(2);
      }
      if (state.isJanCrShow) {
        columns.add(3);
      }
      if (state.isFebDrShow) {
        columns.add(4);
      }
      if (state.isFebCrShow) {
        columns.add(5);
      }
      if (state.isMarDrShow) {
        columns.add(6);
      }
      if (state.isMarCrShow) {
        columns.add(7);
      }
      if (state.isAprDrShow) {
        columns.add(8);
      }
      if (state.isAprCrShow) {
        columns.add(9);
      }
      if (state.isMayDrShow) {
        columns.add(10);
      }
      if (state.isMayCrShow) {
        columns.add(11);
      }
      if (state.isJunDrShow) {
        columns.add(12);
      }
      if (state.isJunCrShow) {
        columns.add(13);
      }
      if (state.isJulDrShow) {
        columns.add(14);
      }
      if (state.isJulCrShow) {
        columns.add(15);
      }
      if (state.isAugDrShow) {
        columns.add(16);
      }
      if (state.isAugCrShow) {
        columns.add(17);
      }
      if (state.isSepDrShow) {
        columns.add(18);
      }
      if (state.isSepCrShow) {
        columns.add(19);
      }
      if (state.isOctDrShow) {
        columns.add(20);
      }
      if (state.isOctCrShow) {
        columns.add(21);
      }
      if (state.isNovDrShow) {
        columns.add(22);
      }
      if (state.isNovCrShow) {
        columns.add(23);
      }
      if (state.isDecDrShow) {
        columns.add(24);
      }
      if (state.isDecCrShow) {
        columns.add(25);
      }
      if (state.isTotalDrShow) {
        columns.add(26);
      }
      if (state.isTotalCrShow) {
        columns.add(27);
      }
      if (state.isBalanceShow) {
        columns.add(28);
      }
      emit(
        state.copyWith(
          status: ReportFinancialStatementListStatus.success,
          ledgers: ledgers,
          ledgetFilter: ledgers,
          isHistory: false,
          yearList: y,
          year: yearSelected,
          accounts: accounts,
          count: daybookCount,
          accountBalances: accountBalances,
          columnSelected: columns,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportFinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onYearSelected(
    ReportFinancialStatementListYearSelected event,
    Emitter<ReportFinancialStatementListState> emit,
  ) async {
    try {
      // DateTime now = DateTime.now();
      final company = _provider.companyId;
      List<ReportFinancialStatementListModel> ledgers = [];
      List<AccountBalance> accountBalances = [];
      List accounts = [];
      int daybookCount = 0;
      if (company.isNotEmpty) {
        Map<String, dynamic> paramCount = {};
        paramCount['company'] = company;
        paramCount['transactionDate.gte'] =
            "${event.year.toString()}-01-01T00:00:00.000Z";
        paramCount['transactionDate.lt'] =
            "${event.year + 1}-01-01T00:00:00.000Z";
        final count = await _daybookService.count(_provider, paramCount);
        if (count['statusCode'] == 200) {
          daybookCount = count['data']['count'];
        }
        final [ledgerRes, accountBalanceRes] = await Future.wait([
          _reportService.findLedgerAccount(
              _provider, company, event.year.toString()),
          _reportService.findAccountBalance(
              _provider, company, event.year.toString()),
        ]);
        if (ledgerRes['statusCode'] == 200) {
          var data = ledgerRes['data'] != null ? ledgerRes['data'] as List : [];
          if (data.isNotEmpty) {
            ledgers = data
                .map((item) => ReportFinancialStatementListModel.fromJson(item))
                .toList();

            for (var element in ledgers) {
              double drBalance = 0;
              double crBalance = 0;
              for (var element2 in element.accountDetail) {
                drBalance += element2.amountDr;
                crBalance += element2.amountCr;
              }
              Map<String, dynamic> acc = {};
              acc['code'] = element.code;
              acc['name'] = "${element.code} - ${element.name}";
              accounts.add(acc);
              element.accountDetail.add(
                const AccountDetail(
                  month: '',
                  date: 0,
                  detail: '',
                  number: '',
                  amountDr: 0,
                  amountCr: 0,
                ),
              );
              element.accountDetail.add(
                AccountDetail(
                  month: '',
                  date: 0,
                  detail: 'รวม',
                  number: '',
                  amountDr: drBalance,
                  amountCr: crBalance,
                ),
              );
            }
          }
        }
        if (accountBalanceRes['statusCode'] == 200) {
          var data = accountBalanceRes['data'] != null
              ? accountBalanceRes['data'] as List
              : [];
          if (data.isNotEmpty) {
            accountBalances =
                data.map((item) => AccountBalance.fromJson(item)).toList();
          }
        }
      }
      List<int> columns = [];
      if (state.isForwardDrShow) {
        columns.add(0);
      }
      if (state.isForwardCrShow) {
        columns.add(1);
      }
      if (state.isJanDrShow) {
        columns.add(2);
      }
      if (state.isJanCrShow) {
        columns.add(3);
      }
      if (state.isFebDrShow) {
        columns.add(4);
      }
      if (state.isFebCrShow) {
        columns.add(5);
      }
      if (state.isMarDrShow) {
        columns.add(6);
      }
      if (state.isMarCrShow) {
        columns.add(7);
      }
      if (state.isAprDrShow) {
        columns.add(8);
      }
      if (state.isAprCrShow) {
        columns.add(9);
      }
      if (state.isMayDrShow) {
        columns.add(10);
      }
      if (state.isMayCrShow) {
        columns.add(11);
      }
      if (state.isJunDrShow) {
        columns.add(12);
      }
      if (state.isJunCrShow) {
        columns.add(13);
      }
      if (state.isJulDrShow) {
        columns.add(14);
      }
      if (state.isJulCrShow) {
        columns.add(15);
      }
      if (state.isAugDrShow) {
        columns.add(16);
      }
      if (state.isAugCrShow) {
        columns.add(17);
      }
      if (state.isSepDrShow) {
        columns.add(18);
      }
      if (state.isSepCrShow) {
        columns.add(19);
      }
      if (state.isOctDrShow) {
        columns.add(20);
      }
      if (state.isOctCrShow) {
        columns.add(21);
      }
      if (state.isNovDrShow) {
        columns.add(22);
      }
      if (state.isNovCrShow) {
        columns.add(23);
      }
      if (state.isDecDrShow) {
        columns.add(24);
      }
      if (state.isDecCrShow) {
        columns.add(25);
      }
      if (state.isTotalDrShow) {
        columns.add(26);
      }
      if (state.isTotalCrShow) {
        columns.add(27);
      }
      if (state.isBalanceShow) {
        columns.add(28);
      }
      emit(
        state.copyWith(
          status: ReportFinancialStatementListStatus.success,
          ledgers: ledgers,
          ledgetFilter: ledgers,
          isHistory: false,
          year: event.year,
          count: daybookCount,
          accounts: accounts,
          accountBalances: accountBalances,
          columnSelected: columns,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportFinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    ReportFinancialStatementListSearchChanged event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    var filter = event.text.isNotEmpty
        ? state.ledgers
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.ledgers;

    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.success,
        ledgers: state.ledgers,
        ledgetFilter: filter,
        searchText: event.text,
      ),
    );
  }

  void _onColumnSelected(
    ReportFinancialStatementListAccountBalanceColumnSelected event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    bool isForwardDrShow = false;
    bool isForwardCrShow = false;
    bool isJanDrShow = false;
    bool isJanCrShow = false;
    bool isFebDrShow = false;
    bool isFebCrShow = false;
    bool isMarDrShow = false;
    bool isMarCrShow = false;
    bool isAprDrShow = false;
    bool isAprCrShow = false;
    bool isMayDrShow = false;
    bool isMayCrShow = false;
    bool isJunDrShow = false;
    bool isJunCrShow = false;
    bool isJulDrShow = false;
    bool isJulCrShow = false;
    bool isAugDrShow = false;
    bool isAugCrShow = false;
    bool isSepDrShow = false;
    bool isSepCrShow = false;
    bool isOctDrShow = false;
    bool isOctCrShow = false;
    bool isNovDrShow = false;
    bool isNovCrShow = false;
    bool isDecDrShow = false;
    bool isDecCrShow = false;
    bool isTotalDrShow = false;
    bool isTotalCrShow = false;
    bool isBalanceShow = false;
    for (var element in event.columns) {
      switch (element) {
        case 0:
          isForwardDrShow = !isForwardDrShow;
          break;
        case 1:
          isForwardCrShow = !isForwardCrShow;
          break;
        case 2:
          isJanDrShow = !isJanDrShow;
          break;
        case 3:
          isJanCrShow = !isJanCrShow;
          break;
        case 4:
          isFebDrShow = !isFebDrShow;
          break;
        case 5:
          isFebCrShow = !isFebCrShow;
          break;
        case 6:
          isMarDrShow = !isMarDrShow;
          break;
        case 7:
          isMarCrShow = !isMarCrShow;
          break;
        case 8:
          isAprDrShow = !isAprDrShow;
          break;
        case 9:
          isAprCrShow = !isAprCrShow;
          break;
        case 10:
          isMayDrShow = !isMayDrShow;
          break;
        case 11:
          isMayCrShow = !isMayCrShow;
          break;
        case 12:
          isJunDrShow = !isJunDrShow;
          break;
        case 13:
          isJunCrShow = !isJunCrShow;
          break;
        case 14:
          isJulDrShow = !isJulDrShow;
          break;
        case 15:
          isJulCrShow = !isJulCrShow;
          break;
        case 16:
          isAugDrShow = !isAugDrShow;
          break;
        case 17:
          isAugCrShow = !isAugCrShow;
          break;
        case 18:
          isSepDrShow = !isSepDrShow;
          break;
        case 19:
          isSepCrShow = !isSepCrShow;
          break;
        case 20:
          isOctDrShow = !isOctDrShow;
          break;
        case 21:
          isOctCrShow = !isOctCrShow;
          break;
        case 22:
          isNovDrShow = !isNovDrShow;
          break;
        case 23:
          isNovCrShow = !isNovCrShow;
          break;
        case 24:
          isDecDrShow = !isDecDrShow;
          break;
        case 25:
          isDecCrShow = !isDecCrShow;
          break;
        case 26:
          isTotalDrShow = !isTotalDrShow;
          break;
        case 27:
          isTotalCrShow = !isTotalCrShow;
          break;
        case 28:
          isBalanceShow = !isBalanceShow;
          break;
      }
    }
    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.success,
        columnSelected: event.columns,
        isForwardDrShow: isForwardDrShow,
        isForwardCrShow: isForwardCrShow,
        isJanDrShow: isJanDrShow,
        isJanCrShow: isJanCrShow,
        isFebDrShow: isFebDrShow,
        isFebCrShow: isFebCrShow,
        isMarDrShow: isMarDrShow,
        isMarCrShow: isMarCrShow,
        isAprDrShow: isAprDrShow,
        isAprCrShow: isAprCrShow,
        isMayDrShow: isMayDrShow,
        isMayCrShow: isMayCrShow,
        isJunDrShow: isJunDrShow,
        isJunCrShow: isJunCrShow,
        isJulDrShow: isJulDrShow,
        isJulCrShow: isJulCrShow,
        isAugDrShow: isAugDrShow,
        isAugCrShow: isAugCrShow,
        isSepDrShow: isSepDrShow,
        isSepCrShow: isSepCrShow,
        isOctDrShow: isOctDrShow,
        isOctCrShow: isOctCrShow,
        isNovDrShow: isNovDrShow,
        isNovCrShow: isNovCrShow,
        isDecDrShow: isDecDrShow,
        isDecCrShow: isDecCrShow,
        isTotalDrShow: isTotalDrShow,
        isTotalCrShow: isTotalCrShow,
        isBalanceShow: isBalanceShow,
      ),
    );
  }

  void _onColumnSelectedAll(
    ReportFinancialStatementListAccountBalanceColumnSelectedAll event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    bool isForwardDrShow = false;
    bool isForwardCrShow = false;
    bool isJanDrShow = false;
    bool isJanCrShow = false;
    bool isFebDrShow = false;
    bool isFebCrShow = false;
    bool isMarDrShow = false;
    bool isMarCrShow = false;
    bool isAprDrShow = false;
    bool isAprCrShow = false;
    bool isMayDrShow = false;
    bool isMayCrShow = false;
    bool isJunDrShow = false;
    bool isJunCrShow = false;
    bool isJulDrShow = false;
    bool isJulCrShow = false;
    bool isAugDrShow = false;
    bool isAugCrShow = false;
    bool isSepDrShow = false;
    bool isSepCrShow = false;
    bool isOctDrShow = false;
    bool isOctCrShow = false;
    bool isNovDrShow = false;
    bool isNovCrShow = false;
    bool isDecDrShow = false;
    bool isDecCrShow = false;
    bool isTotalDrShow = false;
    bool isTotalCrShow = false;
    bool isBalanceShow = false;
    List columns = [];
    if (event.isSelectAll) {
      for (var i = 0; i <= 28; i++) {
        columns.add(i);
      }
      isForwardDrShow = true;
      isForwardCrShow = true;
      isJanDrShow = true;
      isJanCrShow = true;
      isFebDrShow = true;
      isFebCrShow = true;
      isMarDrShow = true;
      isMarCrShow = true;
      isAprDrShow = true;
      isAprCrShow = true;
      isMayDrShow = true;
      isMayCrShow = true;
      isJunDrShow = true;
      isJunCrShow = true;
      isJulDrShow = true;
      isJulCrShow = true;
      isAugDrShow = true;
      isAugCrShow = true;
      isSepDrShow = true;
      isSepCrShow = true;
      isOctDrShow = true;
      isOctCrShow = true;
      isNovDrShow = true;
      isNovCrShow = true;
      isDecDrShow = true;
      isDecCrShow = true;
      isTotalDrShow = true;
      isTotalCrShow = true;
      isBalanceShow = true;
    } else {
      isForwardDrShow = false;
      isForwardCrShow = false;
      isJanDrShow = false;
      isJanCrShow = false;
      isFebDrShow = false;
      isFebCrShow = false;
      isMarDrShow = false;
      isMarCrShow = false;
      isAprDrShow = false;
      isAprCrShow = false;
      isMayDrShow = false;
      isMayCrShow = false;
      isJunDrShow = false;
      isJunCrShow = false;
      isJulDrShow = false;
      isJulCrShow = false;
      isAugDrShow = false;
      isAugCrShow = false;
      isSepDrShow = false;
      isSepCrShow = false;
      isOctDrShow = false;
      isOctCrShow = false;
      isNovDrShow = false;
      isNovCrShow = false;
      isDecDrShow = false;
      isDecCrShow = false;
      isTotalDrShow = false;
      isTotalCrShow = false;
      isBalanceShow = false;
    }
    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.success,
        isSelectAll: event.isSelectAll,
        columnSelected: columns,
        isForwardDrShow: isForwardDrShow,
        isForwardCrShow: isForwardCrShow,
        isJanDrShow: isJanDrShow,
        isJanCrShow: isJanCrShow,
        isFebDrShow: isFebDrShow,
        isFebCrShow: isFebCrShow,
        isMarDrShow: isMarDrShow,
        isMarCrShow: isMarCrShow,
        isAprDrShow: isAprDrShow,
        isAprCrShow: isAprCrShow,
        isMayDrShow: isMayDrShow,
        isMayCrShow: isMayCrShow,
        isJunDrShow: isJunDrShow,
        isJunCrShow: isJunCrShow,
        isJulDrShow: isJulDrShow,
        isJulCrShow: isJulCrShow,
        isAugDrShow: isAugDrShow,
        isAugCrShow: isAugCrShow,
        isSepDrShow: isSepDrShow,
        isSepCrShow: isSepCrShow,
        isOctDrShow: isOctDrShow,
        isOctCrShow: isOctCrShow,
        isNovDrShow: isNovDrShow,
        isNovCrShow: isNovCrShow,
        isDecDrShow: isDecDrShow,
        isDecCrShow: isDecCrShow,
        isTotalDrShow: isTotalDrShow,
        isTotalCrShow: isTotalCrShow,
        isBalanceShow: isBalanceShow,
      ),
    );
  }

  void _onColumnSelectedDefault(
    ReportFinancialStatementListAccountBalanceColumnSelectedDefault event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.success,
        isSelectAll: false,
        columnSelected: [0, 1, 26, 27, 28],
        isForwardDrShow: true,
        isForwardCrShow: true,
        isJanDrShow: false,
        isJanCrShow: false,
        isFebDrShow: false,
        isFebCrShow: false,
        isMarDrShow: false,
        isMarCrShow: false,
        isAprDrShow: false,
        isAprCrShow: false,
        isMayDrShow: false,
        isMayCrShow: false,
        isJunDrShow: false,
        isJunCrShow: false,
        isJulDrShow: false,
        isJulCrShow: false,
        isAugDrShow: false,
        isAugCrShow: false,
        isSepDrShow: false,
        isSepCrShow: false,
        isOctDrShow: false,
        isOctCrShow: false,
        isNovDrShow: false,
        isNovCrShow: false,
        isDecDrShow: false,
        isDecCrShow: false,
        isTotalDrShow: true,
        isTotalCrShow: true,
        isBalanceShow: true,
      ),
    );
  }

  void _onPreviewLedgerAccount(
    ReportFinancialStatementListPreviewLedgerAccount event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.ledgerDialog,
        ledger:
            state.ledgers.firstWhere((element) => element.code == event.code),
      ),
    );
  }

  void _onPreviewAccountBalance(
    ReportFinancialStatementListPreviewAccountBalance event,
    Emitter<ReportFinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    // var a = state.accountBalances
    //     .firstWhere((element) => element.accountGroup == event.accountGroup);
    // print(a.accountGroup);
    emit(
      state.copyWith(
        status: ReportFinancialStatementListStatus.accountBalanceDialog,
        accountBalance: state.accountBalances.firstWhere(
            (element) => element.accountGroup == event.accountGroup),
      ),
    );
  }

  Future<void> _onDownloadFinancialStatement(
    ReportFinancialStatementListDownload event,
    Emitter<ReportFinancialStatementListState> emit,
  ) async {
    // emit(state.copyWith(status: ReportFinancialStatementListStatus.loading));
    try {
      await _reportService.downloadFinancialStatement(
          _provider, _provider.companyId, event.year.toString(), 'test.xlsx');
      emit(
        state.copyWith(
          status: ReportFinancialStatementListStatus.downloaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportFinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
