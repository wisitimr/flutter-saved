import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/account/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountLoading()) {
    on<AccountStarted>(_onStarted);
    on<AccountPageSizeChanged>(_onPageSizeChanged);
  }

  final AccountService _accountService = AccountService();

  Future<void> _onStarted(
      AccountStarted event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      final AppProvider provider = event.provider;
      List<AccountModel> accounts = [];
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final res = await _accountService.findAll(provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          accounts = data.map((item) => AccountModel.fromJson(item)).toList();
        }
      }
      emit(AccountState(
        accounts: accounts,
      ));
    } catch (e) {
      emit(AccountError());
    }
  }

  void _onPageSizeChanged(
    AccountPageSizeChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(
      state.copyWith(
        pageSize: event.pageSize,
      ),
    );
  }
}
