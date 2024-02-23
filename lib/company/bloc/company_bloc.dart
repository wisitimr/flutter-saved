import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:findigitalservice/company/models/models.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/core/core.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc({
    required AppProvider provider,
  })  : _provider = provider,
        super(CompanyLoading()) {
    on<CompanyStarted>(_onStarted);
    on<CompanyIdChanged>(_onIdChanged);
    on<CompanyNameChanged>(_onNameChanged);
    on<CompanyDescriptionChanged>(_onDescriptionChanged);
    on<CompanyAddressChanged>(_onAddressChanged);
    on<CompanyPhoneChanged>(_onPhoneChanged);
    on<CompanyContactChanged>(_onContactChanged);
    on<CompanySubmitConfirm>(_onConfirm);
    on<CompanySubmitted>(_onSubmitted);
  }

  final AppProvider _provider;
  final CompanyService _companyService = CompanyService();

  Future<void> _onStarted(
      CompanyStarted event, Emitter<CompanyState> emit) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      final company = CompanyTmp();
      if (event.id.isNotEmpty) {
        final res = await _companyService.findById(_provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          CompanyModel data = CompanyModel.fromJson(res['data']);
          company.id = data.id;
          company.name = data.name;
          company.description = data.description;
          company.address = data.address;
          company.phone = data.phone;
          company.contact = data.contact;
        }
      }
      emit(state.copyWith(
        status: CompanyStatus.success,
        id: Id.dirty(company.id),
        name: Name.dirty(company.name),
        description: Description.dirty(company.description),
        address: Address.dirty(company.address),
        phone: Phone.dirty(company.phone),
        contact: Contact.dirty(company.contact),
        isValid: company.id.isNotEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CompanyStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onIdChanged(
    CompanyIdChanged event,
    Emitter<CompanyState> emit,
  ) {
    final id = Id.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: Formz.validate(
          [
            state.name,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(
    CompanyNameChanged event,
    Emitter<CompanyState> emit,
  ) {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate(
          [
            name,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
    CompanyDescriptionChanged event,
    Emitter<CompanyState> emit,
  ) {
    final description = Description.dirty(event.description);
    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate(
          [
            state.name,
            description,
            state.address,
            state.phone,
            state.contact,
          ],
        ),
      ),
    );
  }

  void _onAddressChanged(
    CompanyAddressChanged event,
    Emitter<CompanyState> emit,
  ) {
    final address = Address.dirty(event.address);
    emit(
      state.copyWith(
        address: address,
        isValid: Formz.validate(
          [
            state.name,
          ],
        ),
      ),
    );
  }

  void _onPhoneChanged(
    CompanyPhoneChanged event,
    Emitter<CompanyState> emit,
  ) {
    final phone = Phone.dirty(event.phone);
    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate(
          [
            state.name,
          ],
        ),
      ),
    );
  }

  void _onContactChanged(
    CompanyContactChanged event,
    Emitter<CompanyState> emit,
  ) {
    final contact = Contact.dirty(event.contact);
    emit(
      state.copyWith(
        contact: contact,
        isValid: Formz.validate(
          [
            state.name,
          ],
        ),
      ),
    );
  }

  Future<void> _onConfirm(
    CompanySubmitConfirm event,
    Emitter<CompanyState> emit,
  ) async {
    emit(state.copyWith(status: CompanyStatus.loading));
    try {
      emit(
        state.copyWith(
          status: CompanyStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: CompanyStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    CompanySubmitted event,
    Emitter<CompanyState> emit,
  ) async {
    try {
      final Map<String, dynamic> data = {};
      if (state.id.isValid) {
        data['id'] = state.id.value;
      } else {
        data['id'] = null;
      }
      data['name'] = state.name.value;
      data['description'] = state.description.value;
      data['address'] = state.address.value;
      data['phone'] = state.phone.value;
      data['contact'] = state.contact.value;

      dynamic res = await _companyService.save(_provider, data);

      if (res['statusCode'] == 200 || res['statusCode'] == 201) {
        emit(state.copyWith(
          status: CompanyStatus.submited,
          message: res['statusMessage'],
        ));
      } else {
        emit(state.copyWith(
          status: CompanyStatus.failure,
          message: res['statusMessage'],
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: CompanyStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}

class CompanyTmp {
  String id = '';
  String name = '';
  String description = '';
  String address = '';
  String phone = '';
  String contact = '';
}
