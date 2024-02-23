import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/account/list/models/models.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/app_provider.dart';

part 'account_list_event.dart';
part 'account_list_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(AppProvider provider)
      : _provider = provider,
        super(AccountLoading()) {
    on<AccountStarted>(_onStarted);
    on<AccountSearchChanged>(_onSearchChanged);
    on<AccountDeleteConfirm>(_onConfirm);
    on<AccountDelete>(_onDelete);
  }

  final AppProvider _provider;
  final AccountService _accountService = AccountService();

  Future<void> _onStarted(
      AccountStarted event, Emitter<AccountState> emit) async {
    emit(state.copyWith(status: AccountListStatus.loading));
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
          status: AccountListStatus.success,
          accounts: accounts,
          filter: accounts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    AccountSearchChanged event,
    Emitter<AccountState> emit,
  ) {
    emit(state.copyWith(status: AccountListStatus.loading));
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
        status: AccountListStatus.success,
        accounts: state.accounts,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    AccountDeleteConfirm event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: AccountListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: AccountListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    AccountDelete event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: AccountListStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _accountService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: AccountListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: AccountListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: AccountListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: AccountListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
