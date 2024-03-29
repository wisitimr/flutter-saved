import 'package:equatable/equatable.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/core/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/report/ledger_account/models/models.dart';

part 'ledger_account_event.dart';
part 'ledger_account_state.dart';

class ReportLedgerAccountBloc
    extends Bloc<ReportLedgerAccountEvent, ReportLedgerAccountState> {
  ReportLedgerAccountBloc(AppProvider provider)
      : _provider = provider,
        super(ReportLedgerAccountLoading()) {
    on<ReportLedgerAccountStarted>(_onStarted);
    on<ReportLedgerAccountSearchChanged>(_onSearchChanged);
    on<ReportLedgerAccountYearSelected>(_onYearSelected);
    on<ReportLedgerAccountPreviewLedgerAccount>(_onPreviewLedgerAccount);
    on<ReportLedgerAccountDownload>(_onDownloadFinancialStatement);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();
  final ReportService _reportService = ReportService();

  Future<void> _onStarted(
    ReportLedgerAccountStarted event,
    Emitter<ReportLedgerAccountState> emit,
  ) async {
    emit(state.copyWith(status: ReportLedgerAccountStatus.loading));
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
      final ledgerRes = await _reportService.findLedgerAccount(
          _provider, company, yearSelected.toString());
      List<ReportLedgerAccountModel> ledgers = [];
      if (ledgerRes['statusCode'] == 200) {
        var data = ledgerRes['data'] != null ? ledgerRes['data'] as List : [];
        if (data.isNotEmpty) {
          ledgers = data
              .map((item) => ReportLedgerAccountModel.fromJson(item))
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
      emit(
        state.copyWith(
          status: ReportLedgerAccountStatus.success,
          ledgers: ledgers,
          ledgetFilter: ledgers,
          isHistory: false,
          yearList: y,
          year: yearSelected,
          accounts: accounts,
          count: daybookCount,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportLedgerAccountStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onYearSelected(
    ReportLedgerAccountYearSelected event,
    Emitter<ReportLedgerAccountState> emit,
  ) async {
    try {
      // DateTime now = DateTime.now();
      final company = _provider.companyId;
      List<ReportLedgerAccountModel> ledgers = [];
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
        final ledgerRes = await _reportService.findLedgerAccount(
            _provider, company, event.year.toString());
        if (ledgerRes['statusCode'] == 200) {
          var data = ledgerRes['data'] != null ? ledgerRes['data'] as List : [];
          if (data.isNotEmpty) {
            ledgers = data
                .map((item) => ReportLedgerAccountModel.fromJson(item))
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
      }
      emit(
        state.copyWith(
          status: ReportLedgerAccountStatus.success,
          ledgers: ledgers,
          ledgetFilter: ledgers,
          isHistory: false,
          year: event.year,
          count: daybookCount,
          accounts: accounts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportLedgerAccountStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    ReportLedgerAccountSearchChanged event,
    Emitter<ReportLedgerAccountState> emit,
  ) {
    emit(state.copyWith(status: ReportLedgerAccountStatus.loading));
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
        status: ReportLedgerAccountStatus.success,
        ledgers: state.ledgers,
        ledgetFilter: filter,
        searchText: event.text,
      ),
    );
  }

  void _onPreviewLedgerAccount(
    ReportLedgerAccountPreviewLedgerAccount event,
    Emitter<ReportLedgerAccountState> emit,
  ) {
    emit(state.copyWith(status: ReportLedgerAccountStatus.loading));
    emit(
      state.copyWith(
        status: ReportLedgerAccountStatus.ledgerDialog,
        ledger:
            state.ledgers.firstWhere((element) => element.code == event.code),
      ),
    );
  }

  Future<void> _onDownloadFinancialStatement(
    ReportLedgerAccountDownload event,
    Emitter<ReportLedgerAccountState> emit,
  ) async {
    // emit(state.copyWith(status: ReportLedgerAccountStatus.loading));
    try {
      await _reportService.downloadFinancialStatement(
          _provider, _provider.companyId, event.year.toString(), 'test.xlsx');
      emit(
        state.copyWith(
          status: ReportLedgerAccountStatus.downloaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportLedgerAccountStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
