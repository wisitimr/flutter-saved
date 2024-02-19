import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/core/document.dart';
import 'package:saved/core/daybook.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/daybook/list/models/models.dart';

part 'daybook_list_event.dart';
part 'daybook_list_state.dart';

class DaybookListBloc extends Bloc<DaybookListEvent, DaybookListState> {
  DaybookListBloc() : super(DaybookListLoading()) {
    on<DaybookListStarted>(_onStarted);
  }

  final DayBookService _daybookService = DayBookService();
  final DocumentService _documentService = DocumentService();

  Future<void> _onStarted(
      DaybookListStarted event, Emitter<DaybookListState> emit) async {
    emit(DaybookListLoading());
    try {
      Map<String, dynamic> param = {};
      final AppProvider provider = event.provider;
      if (provider.companyId.isNotEmpty) {
        param['company'] = provider.companyId;

        final [daybookRes, docRes] = await Future.wait([
          _daybookService.findAll(provider, param),
          _documentService.findAll(provider, {})
        ]);
        List<DaybookListModel> daybooks = [];
        List<Document> document = [];
        if (daybookRes['statusCode'] == 200) {
          List data = daybookRes['data'];
          daybooks =
              data.map((item) => DaybookListModel.fromJson(item)).toList();
        }
        if (docRes['statusCode'] == 200) {
          List data = docRes['data'];
          document = data.map((item) => Document.fromJson(item)).toList();
        }
        emit(DaybookListState(daybooks: daybooks, document: document));
      } else {
        emit(const DaybookListState());
      }
    } catch (e) {
      emit(DaybookListError());
    }
  }
}
