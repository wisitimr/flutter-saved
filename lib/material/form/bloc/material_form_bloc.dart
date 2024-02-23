import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/material/form/models/material_form_model.dart';
import 'package:findigitalservice/material/form/models/models.dart';

part 'material_form_event.dart';
part 'material_form_state.dart';

class MaterialFormBloc extends Bloc<MaterialFormEvent, MaterialFormState> {
  MaterialFormBloc(AppProvider provider)
      : _provider = provider,
        super(MaterialFormLoading()) {
    on<MaterialFormStarted>(_onStarted);
    on<MaterialFormIdChanged>(_onIdChanged);
    on<MaterialFormCodeChanged>(_onCodeChanged);
    on<MaterialFormNameChanged>(_onNameChanged);
    on<MaterialFormDescriptionChanged>(_onDescriptionChanged);
    on<MaterialFormSubmitConfirm>(_onConfirm);
    on<MaterialSubmitted>(_onSubmitted);
  }

  final AppProvider _provider;
  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialFormStarted event, Emitter<MaterialFormState> emit) async {
    emit(state.copyWith(status: MaterialFormStatus.loading));
    try {
      final material = MaterialFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _materialService.findById(_provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          MaterialFormModel data = MaterialFormModel.fromJson(res['data']);
          material.id = data.id;
          material.code = data.code;
          material.name = data.name;
          material.description = data.description;
          material.type = data.type;
        }
      }
      emit(state.copyWith(
        status: MaterialFormStatus.success,
        id: Id.dirty(material.id),
        code: Code.dirty(material.code),
        name: Name.dirty(material.name),
        description: Description.dirty(material.description),
        isValid: material.id.isNotEmpty,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: MaterialFormStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void _onIdChanged(
    MaterialFormIdChanged event,
    Emitter<MaterialFormState> emit,
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
    MaterialFormCodeChanged event,
    Emitter<MaterialFormState> emit,
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
    MaterialFormNameChanged event,
    Emitter<MaterialFormState> emit,
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
    MaterialFormDescriptionChanged event,
    Emitter<MaterialFormState> emit,
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

  Future<void> _onConfirm(
    MaterialFormSubmitConfirm event,
    Emitter<MaterialFormState> emit,
  ) async {
    emit(state.copyWith(status: MaterialFormStatus.loading));
    try {
      emit(
        state.copyWith(
          status: MaterialFormStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MaterialFormStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    MaterialSubmitted event,
    Emitter<MaterialFormState> emit,
  ) async {
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['code'] = state.code.value;
        data['name'] = state.name.value;
        data['description'] = state.description.value;
        data['company'] = _provider.companyId;

        dynamic res = await _materialService.save(_provider, data);
        if (res['statusCode'] == 200 || res['statusCode'] == 201) {
          emit(state.copyWith(
              status: MaterialFormStatus.submited,
              message: res['statusMessage']));
        } else {
          emit(state.copyWith(
              status: MaterialFormStatus.failure,
              message: res['statusMessage']));
        }
      } catch (e) {
        emit(state.copyWith(
          status: MaterialFormStatus.failure,
          message: e.toString(),
        ));
      }
    }
  }
}

class MaterialFormTmp {
  String id = '';
  String code = '';
  String name = '';
  String description = '';
  String type = '';
}
