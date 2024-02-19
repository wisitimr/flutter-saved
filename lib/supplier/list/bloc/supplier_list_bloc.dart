import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/supplier/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'supplier_list_event.dart';
part 'supplier_list_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierLoading()) {
    on<SupplierStarted>(_onStarted);
    on<SupplierSearchChanged>(_onSearchChanged);
  }

  final SupplierService _supplierService = SupplierService();

  Future<void> _onStarted(
      SupplierStarted event, Emitter<SupplierState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final AppProvider provider = event.provider;
      List<SupplierModel> suppliers = [];
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final res = await _supplierService.findAll(provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          suppliers = data.map((item) => SupplierModel.fromJson(item)).toList();
        }
      }
      emit(
        state.copyWith(
          status: Status.success,
          suppliers: suppliers,
          filter: suppliers,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    SupplierSearchChanged event,
    Emitter<SupplierState> emit,
  ) {
    emit(state.copyWith(status: Status.loading));
    var filter = event.text.isNotEmpty
        ? state.suppliers
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.suppliers;

    emit(
      state.copyWith(
        status: Status.success,
        suppliers: state.suppliers,
        filter: filter,
      ),
    );
  }
}
