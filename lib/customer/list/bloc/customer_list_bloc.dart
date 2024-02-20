import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/customer/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'customer_list_event.dart';
part 'customer_list_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  CustomerBloc(AppProvider provider)
      : _provider = provider,
        super(CustomerLoading()) {
    on<CustomerStarted>(_onStarted);
    on<CustomerSearchChanged>(_onSearchChanged);
    on<CustomerConfirm>(_onConfirm);
    on<CustomerDelete>(_onDelete);
  }

  final AppProvider _provider;
  final CustomerService _customerService = CustomerService();

  Future<void> _onStarted(
      CustomerStarted event, Emitter<CustomerState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<CustomerModel> customers = [];
      if (_provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = _provider.companyId;
        final res = await _customerService.findAll(_provider, param);
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

  Future<void> _onConfirm(
    CustomerConfirm event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      emit(
        state.copyWith(
          status: Status.confirmation,
          selectedRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    CustomerDelete event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (event.id.isNotEmpty) {
        final res = await _customerService.delete(_provider, event.id);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: Status.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: Status.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: Status.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        message: e.toString(),
      ));
    }
  }
}
