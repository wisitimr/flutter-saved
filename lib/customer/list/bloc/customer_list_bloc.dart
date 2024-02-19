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
    on<CustomerSearchChanged>(_onSearchChanged);
  }

  final CustomerService _customerService = CustomerService();

  Future<void> _onStarted(
      CustomerStarted event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: Status.loading));
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
      emit(
        state.copyWith(
          status: Status.success,
          customers: customers,
          filter: customers,
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
    CustomerSearchChanged event,
    Emitter<CustomerState> emit,
  ) {
    emit(state.copyWith(status: Status.loading));
    var filter = event.text.isNotEmpty
        ? state.customers
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.customers;
    emit(
      state.copyWith(
        status: Status.success,
        customers: state.customers,
        filter: filter,
      ),
    );
  }
}
