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
    on<AccountSearchChanged>(_onSearchChanged);
  }

  final AccountService _accountService = AccountService();

  Future<void> _onStarted(
      AccountStarted event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: Status.loading));
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
      emit(
        state.copyWith(
          status: Status.success,
          accounts: accounts,
          filter: accounts,
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
    AccountSearchChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(status: Status.loading));
    var filter = event.text.isNotEmpty
        ? state.accounts
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.accounts;
    emit(
      state.copyWith(
        status: Status.success,
        accounts: state.accounts,
        filter: filter,
      ),
    );
  }
}
