import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/account/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(AppProvider provider)
      : _provider = provider,
        super(AccountLoading()) {
    on<AccountStarted>(_onStarted);
    on<AccountSearchChanged>(_onSearchChanged);
    on<AccountConfirm>(_onConfirm);
    on<AccountDelete>(_onDelete);
  }

  final AppProvider _provider;
  final AccountService _accountService = AccountService();

  Future<void> _onStarted(
      AccountStarted event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<AccountModel> accounts = [];
      if (_provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = _provider.companyId;
        final res = await _accountService.findAll(_provider, param);
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

    // event.key.currentState?.pageTo(0);

    emit(
      state.copyWith(
        status: Status.success,
        accounts: state.accounts,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    AccountConfirm event,
    Emitter<AccountState> emit,
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
    AccountDelete event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (event.id.isNotEmpty) {
        final res = await _accountService.delete(_provider, event.id);
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
