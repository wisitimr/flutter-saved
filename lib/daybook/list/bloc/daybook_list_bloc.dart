import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/core/daybook.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/daybook/list/models/models.dart';

part 'daybook_list_event.dart';
part 'daybook_list_state.dart';

class DaybookListBloc extends Bloc<DaybookListEvent, DaybookListState> {
  DaybookListBloc(AppProvider provider)
      : _provider = provider,
        super(DaybookListLoading()) {
    on<DaybookListStarted>(_onStarted);
    on<DaybookListYearSelected>(_onYearSelected);
    on<DaybookListSearchChanged>(_onSearchChanged);
    on<DaybookListDownload>(_onDownload);
    on<DaybookListDownloadFinancialStatement>(_onDownloadFinancialStatement);
    on<DaybookListDeleteConfirm>(_onConfirm);
    on<DaybookListDelete>(_onDelete);
  }

  final AppProvider _provider;
  final DaybookService _daybookService = DaybookService();

  Future<void> _onStarted(
    DaybookListStarted event,
    Emitter<DaybookListState> emit,
  ) async {
    emit(state.copyWith(status: DaybookListStatus.loading));
    try {
      Map<String, dynamic> param = {};
      DateTime now = DateTime.now();
      List<String> y = [];
      int yearSelected = now.year;
      for (var i = 0; i < 15; i++) {
        var newDate = DateTime(now.year - i);
        y.add(newDate.year.toString());
      }
      param['company'] = _provider.companyId;
      param['transactionDate.gte'] = "$yearSelected-01-01T00:00:00.000Z";
      param['transactionDate.lt'] = "${yearSelected + 1}-01-01T00:00:00.000Z";
      final res = await _daybookService.findAll(_provider, param);
      List<DaybookListModel> daybooks = [];
      if (res['statusCode'] == 200) {
        List data = res['data'];
        daybooks = data.map((item) => DaybookListModel.fromJson(item)).toList();
      }
      emit(
        state.copyWith(
          status: DaybookListStatus.success,
          daybooks: daybooks,
          filter: daybooks,
          isHistory: false,
          years: y,
          yearSelected: yearSelected.toString(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onYearSelected(
    DaybookListYearSelected event,
    Emitter<DaybookListState> emit,
  ) async {
    try {
      // DateTime now = DateTime.now();
      Map<String, dynamic> param = {};
      param['company'] = _provider.companyId;
      param['transactionDate.gte'] = "${event.year}-01-01T00:00:00.000Z";
      param['transactionDate.lt'] =
          "${int.parse(event.year) + 1}-01-01T00:00:00.000Z";
      final res = await _daybookService.findAll(_provider, param);
      List<DaybookListModel> daybooks = [];
      if (res['statusCode'] == 200) {
        List data = res['data'];
        daybooks = data.map((item) => DaybookListModel.fromJson(item)).toList();
      }
      emit(
        state.copyWith(
          status: DaybookListStatus.success,
          daybooks: daybooks,
          filter: daybooks,
          yearSelected: event.year,
          // isHistory: now.year > int.parse(event.year),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    DaybookListSearchChanged event,
    Emitter<DaybookListState> emit,
  ) {
    emit(state.copyWith(status: DaybookListStatus.loading));
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
        status: DaybookListStatus.success,
        daybooks: state.daybooks,
        filter: filter,
      ),
    );
  }

  Future<void> _onDownload(
    DaybookListDownload event,
    Emitter<DaybookListState> emit,
  ) async {
    // emit(state.copyWith(status: DaybookListStatus.loading));
    try {
      if (event.data.id.isNotEmpty) {
        String fileName = "${event.data.number}-";
        if (event.data.supplier != null) {
          fileName += (event.data.supplier?.name ?? '');
        } else if (event.data.customer != null) {
          fileName += (event.data.customer?.name ?? '');
        }
        fileName += '.xlsx';
        await _daybookService.downloadExcel(_provider, event.data.id, fileName);
        emit(
          state.copyWith(
            status: DaybookListStatus.downloaded,
          ),
        );
      } else {
        emit(state.copyWith(
          status: DaybookListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDownloadFinancialStatement(
    DaybookListDownloadFinancialStatement event,
    Emitter<DaybookListState> emit,
  ) async {
    // emit(state.copyWith(status: DaybookListStatus.loading));
    try {
      await _daybookService.downloadFinancialStatement(
          _provider, _provider.companyId, event.year, 'test.xlsx');
      emit(
        state.copyWith(
          status: DaybookListStatus.downloaded,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onConfirm(
    DaybookListDeleteConfirm event,
    Emitter<DaybookListState> emit,
  ) async {
    emit(state.copyWith(status: DaybookListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: DaybookListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    DaybookListDelete event,
    Emitter<DaybookListState> emit,
  ) async {
    emit(state.copyWith(status: DaybookListStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _daybookService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: DaybookListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: DaybookListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: DaybookListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DaybookListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
