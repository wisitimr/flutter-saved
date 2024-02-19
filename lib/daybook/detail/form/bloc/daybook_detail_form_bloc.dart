import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/core/account.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/core/daybook_detail.dart';
import 'package:saved/daybook/detail/form/models/models.dart';
import 'package:saved/models/master/ms_account.dart';

part 'daybook_detail_form_event.dart';
part 'daybook_detail_form_state.dart';

class DaybookDetailFormBloc
    extends Bloc<DaybookDetailFormEvent, DaybookDetailFormState> {
  DaybookDetailFormBloc() : super(DaybookDetailFormLoading()) {
    on<DaybookDetailFormStarted>(_onStarted);
    on<DaybookDetailFormIdChanged>(_onIdChanged);
    on<DaybookDetailFormNameChanged>(_onNameChanged);
    on<DaybookDetailFormTypeChanged>(_onTypeChanged);
    on<DaybookDetailFormAmountChanged>(_onAmountChanged);
    on<DaybookDetailFormAccountChanged>(_onAccountChanged);
    on<DaybookDetailSubmitted>(_onSubmitted);
  }

  final DaybookDetailService _daybookDetailService = DaybookDetailService();
  final AccountService _accountService = AccountService();

  Future<void> _onStarted(DaybookDetailFormStarted event,
      Emitter<DaybookDetailFormState> emit) async {
    emit(DaybookDetailFormLoading());
    try {
      final AppProvider provider = event.provider;
      final acctRes = await _accountService.findAll(provider, {});
      List<MsAccount> accounts = [];
      final daybook = DaybookDetailFormTmp();
      daybook.daybook = event.daybook;
      if (event.id.isNotEmpty) {
        final invRes = await _daybookDetailService.findById(provider, event.id);
        if (invRes != null && invRes['statusCode'] == 200) {
          DaybookDetailFormModel data =
              DaybookDetailFormModel.fromJson(invRes['data']);
          daybook.id = data.id;
          daybook.name = data.name;
          daybook.type = data.type;
          daybook.amount = data.amount.toStringAsFixed(2);
          daybook.account = data.account;
        }
      }
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
      emit(state.copyWith(
        isLoading: false,
        msAccount: accounts,
        msAccountType: ['', 'DR', 'CR'],
        id: Id.dirty(daybook.id),
        name: Name.dirty(daybook.name),
        type: Type.dirty(daybook.type),
        amount: Amount.dirty(daybook.amount),
        account: Account.dirty(daybook.account),
        daybook: Daybook.dirty(daybook.daybook),
        isValid: daybook.id.isNotEmpty,
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(DaybookDetailFormError());
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
            state.type,
            state.amount,
            account,
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    DaybookDetailSubmitted event,
    Emitter<DaybookDetailFormState> emit,
  ) async {
    final AppProvider provider = event.provider;
    try {
      final Map<String, dynamic> data = {};
      if (state.id.isValid) {
        data['id'] = state.id.value;
      } else {
        data['id'] = null;
      }
      data['name'] = state.name.value;
      data['type'] = state.type.value;
      data['account'] = state.account.value;
      if (state.amount.isValid) {
        data['amount'] = double.parse(state.amount.value.replaceAll(',', ''));
      }
      data['daybook'] = state.daybook.value;

      dynamic res = await _daybookDetailService.save(provider, data);

      if (res['statusCode'] == 200 || res['statusCode'] == 201) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            message: res['statusMessage']));
      } else {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: res['statusMessage']));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}

class DaybookDetailFormTmp {
  String id = '';
  String name = '';
  String type = '';
  String amount = '';
  String account = '';
  String daybook = '';
}
