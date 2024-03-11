import 'package:equatable/equatable.dart';
import 'package:findigitalservice/core/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/core/daybook.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/report/financial_statement/list/models/models.dart';

part 'report_financial_statement_list_event.dart';
part 'report_financial_statement_list_state.dart';

class FinancialStatementListBloc
    extends Bloc<FinancialStatementListEvent, FinancialStatementListState> {
  FinancialStatementListBloc(AppProvider provider)
      : _provider = provider,
        super(FinancialStatementListLoading()) {
    on<FinancialStatementListStarted>(_onStarted);
    on<FinancialStatementListYearSelected>(_onYearSelected);
    on<FinancialStatementListSearchChanged>(_onSearchChanged);
    on<FinancialStatementListDownload>(_onDownloadFinancialStatement);
    on<FinancialStatementListDeleteConfirm>(_onConfirm);
    on<FinancialStatementListDelete>(_onDelete);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();
  final ReportService _reportService = ReportService();

  Future<void> _onStarted(
    FinancialStatementListStarted event,
    Emitter<FinancialStatementListState> emit,
  ) async {
    emit(state.copyWith(status: FinancialStatementListStatus.loading));
    try {
      DateTime now = DateTime.now();
      Map<String, dynamic> param = {};
      List<int> y = [];
      int yearSelected = event.year;
      if (yearSelected == 0) {
        yearSelected = now.year;
      }
      for (var i = 0; i < 15; i++) {
        var newDate = DateTime(now.year - i);
        y.add(newDate.year);
      }
      param['company'] = _provider.companyId;
      param['transactionDate.gte'] = "$yearSelected-01-01T00:00:00.000Z";
      param['transactionDate.lt'] = "${yearSelected + 1}-01-01T00:00:00.000Z";
      final res = await _daybookService.findAll(_provider, param);
      List<FinancialStatementListModel> daybooks = [];
      if (res['statusCode'] == 200) {
        List data = res['data'];
        daybooks = data
            .map((item) => FinancialStatementListModel.fromJson(item))
            .toList();
      }
      emit(
        state.copyWith(
          status: FinancialStatementListStatus.success,
          daybooks: daybooks,
          filter: daybooks,
          isHistory: false,
          yearList: y,
          year: yearSelected,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onYearSelected(
    FinancialStatementListYearSelected event,
    Emitter<FinancialStatementListState> emit,
  ) async {
    try {
      // DateTime now = DateTime.now();
      Map<String, dynamic> param = {};
      param['company'] = _provider.companyId;
      param['transactionDate.gte'] = "${event.year}-01-01T00:00:00.000Z";
      param['transactionDate.lt'] = "${event.year + 1}-01-01T00:00:00.000Z";
      final res = await _daybookService.findAll(_provider, param);
      List<FinancialStatementListModel> daybooks = [];
      if (res['statusCode'] == 200) {
        List data = res['data'];
        daybooks = data
            .map((item) => FinancialStatementListModel.fromJson(item))
            .toList();
      }
      emit(
        state.copyWith(
          status: FinancialStatementListStatus.success,
          daybooks: daybooks,
          filter: daybooks,
          year: event.year,
          // isHistory: now.year > int.parse(event.year),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    FinancialStatementListSearchChanged event,
    Emitter<FinancialStatementListState> emit,
  ) {
    emit(state.copyWith(status: FinancialStatementListStatus.loading));
    var filter = event.text.isNotEmpty
        ? state.daybooks
            .where(
              (item) =>
                  item.number
                      .toLowerCase()
                      .contains(event.text.toLowerCase()) ||
                  item.invoice
                      .toLowerCase()
                      .contains(event.text.toLowerCase()) ||
                  item.document
                      .toLowerCase()
                      .contains(event.text.toLowerCase()),
            )
            .toList()
        : state.daybooks;

    emit(
      state.copyWith(
        status: FinancialStatementListStatus.success,
        daybooks: state.daybooks,
        filter: filter,
      ),
    );
  }

  Future<void> _onDownloadFinancialStatement(
    FinancialStatementListDownload event,
    Emitter<FinancialStatementListState> emit,
  ) async {
    // emit(state.copyWith(status: FinancialStatementListStatus.loading));
    try {
      await _reportService.downloadFinancialStatement(
          _provider, _provider.companyId, event.year.toString(), 'test.xlsx');
      emit(
        state.copyWith(
          status: FinancialStatementListStatus.downloaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onConfirm(
    FinancialStatementListDeleteConfirm event,
    Emitter<FinancialStatementListState> emit,
  ) async {
    emit(state.copyWith(status: FinancialStatementListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: FinancialStatementListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    FinancialStatementListDelete event,
    Emitter<FinancialStatementListState> emit,
  ) async {
    emit(state.copyWith(status: FinancialStatementListStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _daybookService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: FinancialStatementListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FinancialStatementListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: FinancialStatementListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: FinancialStatementListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
