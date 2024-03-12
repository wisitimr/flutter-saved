import 'package:equatable/equatable.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/core/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/report/ledger_account/list/models/models.dart';

part 'report_ledger_account_list_event.dart';
part 'report_ledger_account_list_state.dart';

class ReportLedgerAccountListBloc
    extends Bloc<ReportLedgerAccountListEvent, ReportLedgerAccountListState> {
  ReportLedgerAccountListBloc(AppProvider provider)
      : _provider = provider,
        super(ReportLedgerAccountListLoading()) {
    on<ReportLedgerAccountListStarted>(_onStarted);
    on<ReportLedgerAccountListYearSelected>(_onYearSelected);
    on<ReportLedgerAccountListPreviewLedgerAccount>(_onPreviewLedgerAccount);
    on<ReportLedgerAccountListSearchChanged>(_onSearchChanged);
    on<ReportLedgerAccountListDownload>(_onDownloadFinancialStatement);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();
  final ReportService _reportService = ReportService();

  Future<void> _onStarted(
    ReportLedgerAccountListStarted event,
    Emitter<ReportLedgerAccountListState> emit,
  ) async {
    emit(state.copyWith(status: ReportLedgerAccountListStatus.loading));
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
      final res = await _reportService.findLedgerAccount(
          _provider, company, yearSelected.toString());
      List<ReportLedgerAccountListModel> ledgers = [];
      if (res['statusCode'] == 200) {
        var data = res['data'] != null ? res['data'] as List : [];
        if (data.isNotEmpty) {
          ledgers = data
              .map((item) => ReportLedgerAccountListModel.fromJson(item))
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
          status: ReportLedgerAccountListStatus.success,
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
        status: ReportLedgerAccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onYearSelected(
    ReportLedgerAccountListYearSelected event,
    Emitter<ReportLedgerAccountListState> emit,
  ) async {
    try {
      // DateTime now = DateTime.now();
      final company = _provider.companyId;
      List<ReportLedgerAccountListModel> ledgers = [];
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
      }
      final res = await _reportService.findLedgerAccount(
          _provider, company, event.year.toString());
      if (res['statusCode'] == 200) {
        var data = res['data'] != null ? res['data'] as List : [];
        if (data.isNotEmpty) {
          ledgers = data
              .map((item) => ReportLedgerAccountListModel.fromJson(item))
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
          status: ReportLedgerAccountListStatus.success,
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
        status: ReportLedgerAccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    ReportLedgerAccountListSearchChanged event,
    Emitter<ReportLedgerAccountListState> emit,
  ) {
    emit(state.copyWith(status: ReportLedgerAccountListStatus.loading));
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
        status: ReportLedgerAccountListStatus.success,
        ledgers: state.ledgers,
        ledgetFilter: filter,
        searchText: event.text,
      ),
    );
  }

  void _onPreviewLedgerAccount(
    ReportLedgerAccountListPreviewLedgerAccount event,
    Emitter<ReportLedgerAccountListState> emit,
  ) {
    emit(state.copyWith(status: ReportLedgerAccountListStatus.loading));
    emit(
      state.copyWith(
        status: ReportLedgerAccountListStatus.dialogShow,
        ledger:
            state.ledgers.firstWhere((element) => element.code == event.code),
      ),
    );
  }

  Future<void> _onDownloadFinancialStatement(
    ReportLedgerAccountListDownload event,
    Emitter<ReportLedgerAccountListState> emit,
  ) async {
    emit(state.copyWith(status: ReportLedgerAccountListStatus.loading));
    try {
      await _reportService.downloadFinancialStatement(
          _provider, _provider.companyId, event.year.toString(), 'test.xlsx');
      emit(
        state.copyWith(
          status: ReportLedgerAccountListStatus.downloaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ReportLedgerAccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
