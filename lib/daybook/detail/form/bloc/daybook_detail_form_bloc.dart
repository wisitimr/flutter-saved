import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:findigitalservice/core/account.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/core/daybook_detail.dart';
import 'package:findigitalservice/daybook/detail/form/models/models.dart';
import 'package:findigitalservice/models/master/ms_account.dart';

part 'daybook_detail_form_event.dart';
part 'daybook_detail_form_state.dart';

class DaybookDetailFormBloc
    extends Bloc<DaybookDetailFormEvent, DaybookDetailFormState> {
  DaybookDetailFormBloc(AppProvider provider)
      : _provider = provider,
        super(DaybookDetailFormLoading()) {
    on<DaybookDetailFormStarted>(_onStarted);
    on<DaybookDetailFormIdChanged>(_onIdChanged);
    on<DaybookDetailFormNameChanged>(_onNameChanged);
    on<DaybookDetailFormDetailChanged>(_onDetailChanged);
    on<DaybookDetailFormTypeChanged>(_onTypeChanged);
    on<DaybookDetailFormAmountChanged>(_onAmountChanged);
    on<DaybookDetailFormAccountChanged>(_onAccountChanged);
    on<DaybookDetailFormSubmitConfirm>(_onConfirm);
    on<DaybookDetailSubmitted>(_onSubmitted);
  }

  final AppProvider _provider;
  final DaybookDetailService _daybookDetailService = DaybookDetailService();
  final AccountService _accountService = AccountService();

  Future<void> _onStarted(DaybookDetailFormStarted event,
      Emitter<DaybookDetailFormState> emit) async {
    emit(state.copyWith(status: DaybookDetailFormStatus.loading));
    try {
      final acctRes = await _accountService.findAll(_provider, {});
      List<MsAccount> accounts = [];
      final form = DaybookDetailFormTmp();
      form.daybook = event.daybook;
      if (acctRes['statusCode'] == 200) {
        List data = acctRes['data'];
        accounts.addAll([
          const MsAccount(
            id: '',
            code: '',
            name: '-- Select --',
            description: '',
            type: '',
          ),
          ...data.map((item) => MsAccount.fromJson(item)).toList(),
        ]);
      }
      if (event.id.isNotEmpty) {
        final res = await _daybookDetailService.findById(_provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          DaybookDetailFormModel data =
              DaybookDetailFormModel.fromJson(res['data']);
          form.id = data.id;
          form.name = data.name;
          form.detail = data.detail;
          form.type = data.type;
          form.amount = data.amount.toStringAsFixed(2);
          form.account = data.account;
          form.daybook = data.daybook;
          form.company = data.company;
        }
      }
      if (form.type.isNotEmpty) {
        form.typeName = form.type;
      }
      if (accounts.isNotEmpty) {
        if (form.account.isNotEmpty) {
          for (var ac in accounts) {
            if (ac.id == form.account) {
              form.accountName = ac.name;
            }
          }
        }
      }
      final id = Id.dirty(form.id);
      final name = Name.dirty(form.name);
      final detail = Detail.dirty(form.detail);
      final type = Type.dirty(form.type);
      final amount = Amount.dirty(form.amount);
      final account = Account.dirty(form.account);
      final daybook = Daybook.dirty(form.daybook);
      final company = Company.dirty(form.company);

      emit(state.copyWith(
        status: DaybookDetailFormStatus.success,
        msAccount: accounts,
        msAccountType: ['', 'DR', 'CR'],
        id: id,
        name: name,
        detail: detail,
        type: type,
        amount: amount,
        account: account,
        daybook: daybook,
        company: company,
        typeName: form.typeName,
        accountName: form.accountName,
        isValid: Formz.validate(
          [
            name,
            detail,
            type,
            amount,
            account,
          ],
        ),
        isHistory: event.isHistory,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DaybookDetailFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onIdChanged(
    DaybookDetailFormIdChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final id = Id.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: Formz.validate(
          [
            state.name,
            state.detail,
            state.type,
            state.amount,
            state.account,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    DaybookDetailFormNameChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(
          [
            name,
            state.detail,
            state.type,
            state.amount,
            state.account,
          ],
        ),
      ),
    );
  }

  void _onDetailChanged(
    DaybookDetailFormDetailChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final detail = Detail.dirty(event.detail);
    emit(
      state.copyWith(
        detail: detail,
        isValid: Formz.validate(
          [
            state.name,
            detail,
            state.type,
            state.amount,
            state.account,
          ],
        ),
      ),
    );
  }

  void _onTypeChanged(
    DaybookDetailFormTypeChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final type = Type.dirty(event.type);
    emit(
      state.copyWith(
        type: type,
        isValid: Formz.validate(
          [
            state.name,
            state.detail,
            type,
            state.amount,
            state.account,
          ],
        ),
      ),
    );
  }

  void _onAmountChanged(
    DaybookDetailFormAmountChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final amount = Amount.dirty(event.amount);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate(
          [
            state.name,
            state.detail,
            state.type,
            amount,
            state.account,
          ],
        ),
      ),
    );
  }

  void _onAccountChanged(
    DaybookDetailFormAccountChanged event,
    Emitter<DaybookDetailFormState> emit,
  ) {
    final account = Account.dirty(event.account);
    emit(
      state.copyWith(
        account: account,
        isValid: Formz.validate(
          [
            state.name,
            state.detail,
            state.type,
            state.amount,
            account,
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirm(
    DaybookDetailFormSubmitConfirm event,
    Emitter<DaybookDetailFormState> emit,
  ) async {
    emit(state.copyWith(status: DaybookDetailFormStatus.loading));
    try {
      emit(
        state.copyWith(
          status: DaybookDetailFormStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: DaybookDetailFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    DaybookDetailSubmitted event,
    Emitter<DaybookDetailFormState> emit,
  ) async {
    try {
      final Map<String, dynamic> data = {};
      if (state.id.isValid) {
        data['id'] = state.id.value;
      } else {
        data['id'] = null;
      }
      data['name'] = state.name.value;
      data['detail'] = state.detail.value;
      data['type'] = state.type.value;
      data['account'] = state.account.value;
      if (state.amount.isValid) {
        data['amount'] = double.parse(state.amount.value.replaceAll(',', ''));
      }
      data['daybook'] = state.daybook.value;
      data['company'] = state.company.value;
      dynamic res = await _daybookDetailService.save(_provider, data);

      if (res['statusCode'] == 200 || res['statusCode'] == 201) {
        emit(state.copyWith(
          status: DaybookDetailFormStatus.submited,
          message: res['statusMessage'],
        ));
      } else {
        emit(state.copyWith(
          status: DaybookDetailFormStatus.failure,
          message: res['statusMessage'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DaybookDetailFormStatus.failure,
        message: e.toString(),
      ));
    }
  }
}

class DaybookDetailFormTmp {
  String id = '';
  String name = '';
  String detail = '';
  String type = '';
  String typeName = '';
  String amount = '';
  String account = '';
  String company = '';
  String accountName = '';
  String daybook = '';
}
