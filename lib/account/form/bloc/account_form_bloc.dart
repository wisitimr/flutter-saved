import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/account/form/models/account_form_model.dart';
import 'package:saved/account/form/models/models.dart';

part 'account_form_event.dart';
part 'account_form_state.dart';

class AccountFormBloc extends Bloc<AccountFormEvent, AccountFormState> {
  AccountFormBloc() : super(AccountFormLoading()) {
    on<AccountFormStarted>(_onStarted);
    on<AccountFormIdChanged>(_onIdChanged);
    on<AccountFormCodeChanged>(_onCodeChanged);
    on<AccountFormNameChanged>(_onNameChanged);
    on<AccountFormDescriptionChanged>(_onDescriptionChanged);
    on<AccountFormTypeChanged>(_onTypeChanged);
    on<AccountSubmitted>(_onSubmitted);
  }

  final AccountService _accountService = AccountService();

  Future<void> _onStarted(
      AccountFormStarted event, Emitter<AccountFormState> emit) async {
    // emit(AccountFormLoading());
    emit(state.copyWith(isLoading: true));
    try {
      final AppProvider provider = event.provider;
      final account = AccountFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _accountService.findById(provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          AccountFormModel data = AccountFormModel.fromJson(res['data']);
          account.id = data.id;
          account.code = data.code;
          account.name = data.name;
          account.description = data.description;
          account.type = data.type;
        }
      }
      emit(state.copyWith(
        isLoading: false,
        id: Id.dirty(account.id),
        code: Code.dirty(account.code),
        name: Name.dirty(account.name),
        description: Description.dirty(account.description),
        type: Type.dirty(account.type),
        isValid: account.id.isNotEmpty,
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(AccountFormError());
    }
  }

  void _onIdChanged(
    AccountFormIdChanged event,
    Emitter<AccountFormState> emit,
  ) {
    final id = Id.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  void _onCodeChanged(
    AccountFormCodeChanged event,
    Emitter<AccountFormState> emit,
  ) {
    final code = Code.dirty(event.code);
    emit(
      state.copyWith(
        code: code,
        isValid: Formz.validate(
          [
            code,
            state.name,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    AccountFormNameChanged event,
    Emitter<AccountFormState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(
          [
            state.code,
            name,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    AccountFormDescriptionChanged event,
    Emitter<AccountFormState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  void _onTypeChanged(
    AccountFormTypeChanged event,
    Emitter<AccountFormState> emit,
  ) {
    final type = Type.dirty(event.type);
    emit(
      state.copyWith(
        type: type,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    AccountSubmitted event,
    Emitter<AccountFormState> emit,
  ) async {
    final AppProvider provider = event.provider;
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['code'] = state.code.value;
        data['name'] = state.name.value;
        data['description'] = state.description.value;
        data['type'] = state.type.value;
        dynamic res = await _accountService.save(provider, data);
        if (res['statusCode'] == 200 || res['statusCode'] == 201) {
          emit(state.copyWith(
              status: FormzSubmissionStatus.success,
              message: res['statusMessage']));
        } else {
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              message: res['statusMessage']));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}

class AccountFormTmp {
  String id = '';
  String code = '';
  String name = '';
  String description = '';
  String type = '';
}
