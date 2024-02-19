import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/customer/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc() : super(CustomerLoading()) {
    on<CustomerStarted>(_onStarted);
    on<CustomerPageSizeChanged>(_onPageSizeChanged);
  }

  final CustomerService _customerService = CustomerService();

  Future<void> _onStarted(
      CustomerStarted event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    try {
      final AppProvider provider = event.provider;
      List<CustomerModel> customers = [];
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final res = await _customerService.findAll(provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          customers = data.map((item) => CustomerModel.fromJson(item)).toList();
        }
      }
      emit(CustomerState(
        customers: customers,
      ));
    } catch (e) {
      emit(CustomerError());
    }
  }

  void _onPageSizeChanged(
    CustomerPageSizeChanged event,
    Emitter<CustomerState> emit,
  ) {
    emit(
      state.copyWith(
        pageSize: event.pageSize,
      ),
    );
  }
}
