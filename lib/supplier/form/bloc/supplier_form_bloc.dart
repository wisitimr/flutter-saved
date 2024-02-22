import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/supplier/form/models/supplier_form_model.dart';
import 'package:saved/supplier/form/models/models.dart';

part 'supplier_form_event.dart';
part 'supplier_form_state.dart';

class SupplierFormBloc extends Bloc<SupplierFormEvent, SupplierFormState> {
  SupplierFormBloc(AppProvider provider)
      : _provider = provider,
        super(SupplierFormLoading()) {
    on<SupplierFormStarted>(_onStarted);
    on<SupplierFormIdChanged>(_onIdChanged);
    on<SupplierFormCodeChanged>(_onCodeChanged);
    on<SupplierFormNameChanged>(_onNameChanged);
    on<SupplierFormAddressChanged>(_onAddressChanged);
    on<SupplierFormPhoneChanged>(_onPhoneChanged);
    on<SupplierFormContactChanged>(_onContactChanged);
    on<SupplierFormSubmitConfirm>(_onConfirm);
    on<SupplierSubmitted>(_onSubmitted);
  }

  final AppProvider _provider;
  final SupplierService _supplierService = SupplierService();

  Future<void> _onStarted(
      SupplierFormStarted event, Emitter<SupplierFormState> emit) async {
    // emit(SupplierFormLoading());
    emit(state.copyWith(status: SupplierFormStatus.loading));
    try {
      final supplier = SupplierFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _supplierService.findById(_provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          SupplierFormModel data = SupplierFormModel.fromJson(res['data']);
          supplier.id = data.id;
          supplier.code = data.code;
          supplier.name = data.name;
          supplier.address = data.address;
          supplier.phone = data.phone;
          supplier.contact = data.contact;
        }
      }
      emit(state.copyWith(
        status: SupplierFormStatus.success,
        id: Id.dirty(supplier.id),
        code: Code.dirty(supplier.code),
        name: Name.dirty(supplier.name),
        address: Address.dirty(supplier.address),
        phone: Phone.dirty(supplier.phone),
        contact: Contact.dirty(supplier.contact),
        isValid: supplier.id.isNotEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SupplierFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onIdChanged(
    SupplierFormIdChanged event,
    Emitter<SupplierFormState> emit,
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
    SupplierFormCodeChanged event,
    Emitter<SupplierFormState> emit,
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
    SupplierFormNameChanged event,
    Emitter<SupplierFormState> emit,
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

  void _onAddressChanged(
    SupplierFormAddressChanged event,
    Emitter<SupplierFormState> emit,
  ) {
    final address = Address.dirty(event.address);
    emit(
      state.copyWith(
        address: address,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  void _onPhoneChanged(
    SupplierFormPhoneChanged event,
    Emitter<SupplierFormState> emit,
  ) {
    final phone = Phone.dirty(event.phone);
    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  void _onContactChanged(
    SupplierFormContactChanged event,
    Emitter<SupplierFormState> emit,
  ) {
    final contact = Contact.dirty(event.contact);
    emit(
      state.copyWith(
        contact: contact,
        isValid: Formz.validate(
          [
            state.code,
            state.name,
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirm(
    SupplierFormSubmitConfirm event,
    Emitter<SupplierFormState> emit,
  ) async {
    emit(state.copyWith(status: SupplierFormStatus.loading));
    try {
      emit(
        state.copyWith(
          status: SupplierFormStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: SupplierFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    SupplierSubmitted event,
    Emitter<SupplierFormState> emit,
  ) async {
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['code'] = state.code.value;
        data['name'] = state.name.value;
        data['address'] = state.address.value;
        data['phone'] = state.phone.value;
        data['contact'] = state.contact.value;
        data['company'] = _provider.companyId;

        dynamic res = await _supplierService.save(_provider, data);
        if (res['statusCode'] == 200 || res['statusCode'] == 201) {
          emit(state.copyWith(
              status: SupplierFormStatus.submited,
              message: res['statusMessage']));
        } else {
          emit(state.copyWith(
              status: SupplierFormStatus.failure,
              message: res['statusMessage']));
        }
      } catch (e) {
        emit(state.copyWith(
          status: SupplierFormStatus.failure,
          message: e.toString(),
        ));
      }
    }
  }
}

class SupplierFormTmp {
  String id = '';
  String code = '';
  String name = '';
  String address = '';
  String tax = '';
  String phone = '';
  String contact = '';
}
