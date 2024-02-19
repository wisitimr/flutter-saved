import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/customer/form/models/customer_form_model.dart';
import 'package:saved/customer/form/models/models.dart';

part 'customer_form_event.dart';
part 'customer_form_state.dart';

class CustomerFormBloc extends Bloc<CustomerFormEvent, CustomerFormState> {
  CustomerFormBloc() : super(CustomerFormLoading()) {
    on<CustomerFormStarted>(_onStarted);
    on<CustomerFormIdChanged>(_onIdChanged);
    on<CustomerFormCodeChanged>(_onCodeChanged);
    on<CustomerFormNameChanged>(_onNameChanged);
    on<CustomerFormAddressChanged>(_onAddressChanged);
    on<CustomerFormTaxChanged>(_onTaxChanged);
    on<CustomerFormPhoneChanged>(_onPhoneChanged);
    on<CustomerFormContactChanged>(_onContactChanged);
    on<CustomerSubmitted>(_onSubmitted);
  }

  final CustomerService _customerService = CustomerService();

  Future<void> _onStarted(
      CustomerFormStarted event, Emitter<CustomerFormState> emit) async {
    // emit(CustomerFormLoading());
    emit(state.copyWith(isLoading: true));
    try {
      final AppProvider provider = event.provider;
      final customer = CustomerFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _customerService.findById(provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          CustomerFormModel data = CustomerFormModel.fromJson(res['data']);
          customer.id = data.id;
          customer.code = data.code;
          customer.name = data.name;
          customer.address = data.address;
          customer.tax = data.tax;
          customer.phone = data.phone;
          customer.contact = data.contact;
        }
      }
      emit(state.copyWith(
        isLoading: false,
        id: Id.dirty(customer.id),
        code: Code.dirty(customer.code),
        name: Name.dirty(customer.name),
        address: Address.dirty(customer.address),
        tax: Tax.dirty(customer.tax),
        phone: Phone.dirty(customer.phone),
        contact: Contact.dirty(customer.contact),
        isValid: customer.id.isNotEmpty,
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(CustomerFormError());
    }
  }

  void _onIdChanged(
    CustomerFormIdChanged event,
    Emitter<CustomerFormState> emit,
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
    CustomerFormCodeChanged event,
    Emitter<CustomerFormState> emit,
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
    CustomerFormNameChanged event,
    Emitter<CustomerFormState> emit,
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
    CustomerFormAddressChanged event,
    Emitter<CustomerFormState> emit,
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

  void _onTaxChanged(
    CustomerFormTaxChanged event,
    Emitter<CustomerFormState> emit,
  ) {
    final tax = Tax.dirty(event.tax);
    emit(
      state.copyWith(
        tax: tax,
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
    CustomerFormPhoneChanged event,
    Emitter<CustomerFormState> emit,
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
    CustomerFormContactChanged event,
    Emitter<CustomerFormState> emit,
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

  Future<void> _onSubmitted(
    CustomerSubmitted event,
    Emitter<CustomerFormState> emit,
  ) async {
    final AppProvider provider = event.provider;
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['code'] = state.code.value;
        data['name'] = state.name.value;
        data['address'] = state.address.value;
        data['tax'] = state.tax.value;
        data['phone'] = state.phone.value;
        data['contact'] = state.contact.value;
        dynamic res = await _customerService.save(provider, data);
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

class CustomerFormTmp {
  String id = '';
  String code = '';
  String name = '';
  String address = '';
  String tax = '';
  String phone = '';
  String contact = '';
}
