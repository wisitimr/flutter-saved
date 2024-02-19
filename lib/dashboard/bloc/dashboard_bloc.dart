import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<DashboardStarted>(_onStarted);
  }

  final UserService _userService = UserService();
  final DayBookService _daybookService = DayBookService();
  final AccountService _accountService = AccountService();
  final SupplierService _supplierService = SupplierService();
  final CustomerService _customerService = CustomerService();
  final ProductService _productService = ProductService();
  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      DashboardStarted event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    final AppProvider provider = event.provider;
    try {
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final [
          userRes,
          daybookRes,
          accountRes,
          supplierRes,
          customerRes,
          productRes,
          materialRes,
        ] = await Future.wait([
          _userService.count(provider),
          _daybookService.count(provider, param),
          _accountService.count(provider, param),
          _supplierService.count(provider, param),
          _customerService.count(provider, param),
          _productService.count(provider, param),
          _materialService.count(provider, param),
        ]);
        int userCount = 0;
        int daybookCount = 0;
        int accountCount = 0;
        int supplierCount = 0;
        int customerCount = 0;
        int productCount = 0;
        int materialCount = 0;
        if (userRes['statusCode'] == 200) {
          final data = userRes['data'];
          userCount = data['count'];
        }
        if (daybookRes['statusCode'] == 200) {
          final data = daybookRes['data'];
          daybookCount = data['count'];
        }
        if (accountRes['statusCode'] == 200) {
          final data = accountRes['data'];
          accountCount = data['count'];
        }
        if (supplierRes['statusCode'] == 200) {
          final data = supplierRes['data'];
          supplierCount = data['count'];
        }
        if (customerRes['statusCode'] == 200) {
          final data = customerRes['data'];
          customerCount = data['count'];
        }
        if (productRes['statusCode'] == 200) {
          final data = productRes['data'];
          productCount = data['count'];
        }
        if (materialRes['statusCode'] == 200) {
          final data = materialRes['data'];
          materialCount = data['count'];
        }
        emit(DashboardLoaded(
          userCount: userCount,
          daybookCount: daybookCount,
          accountCount: accountCount,
          supplierCount: supplierCount,
          customerCount: customerCount,
          productCount: productCount,
          materialCount: materialCount,
        ));
      } else {
        emit(const DashboardLoaded());
      }
    } catch (e) {
      emit(DashboardError());
    }
  }
}
