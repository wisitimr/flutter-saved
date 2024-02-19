import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/material/form/models/material_form_model.dart';
import 'package:saved/material/form/models/models.dart';

part 'material_form_event.dart';
part 'material_form_state.dart';

class MaterialFormBloc extends Bloc<MaterialFormEvent, MaterialFormState> {
  MaterialFormBloc() : super(MaterialFormLoading()) {
    on<MaterialFormStarted>(_onStarted);
    on<MaterialFormIdChanged>(_onIdChanged);
    on<MaterialFormCodeChanged>(_onCodeChanged);
    on<MaterialFormNameChanged>(_onNameChanged);
    on<MaterialFormDescriptionChanged>(_onDescriptionChanged);
    on<MaterialSubmitted>(_onSubmitted);
  }

  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialFormStarted event, Emitter<MaterialFormState> emit) async {
    // emit(MaterialFormLoading());
    emit(state.copyWith(isLoading: true));
    try {
      final AppProvider provider = event.provider;
      final material = MaterialFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _materialService.findById(provider, event.id);
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
        isLoading: false,
        id: Id.dirty(material.id),
        code: Code.dirty(material.code),
        name: Name.dirty(material.name),
        description: Description.dirty(material.description),
        isValid: material.id.isNotEmpty,
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(MaterialFormError());
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

  Future<void> _onSubmitted(
    MaterialSubmitted event,
    Emitter<MaterialFormState> emit,
  ) async {
    final AppProvider provider = event.provider;
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['code'] = state.code.value;
        data['name'] = state.name.value;
        data['description'] = state.description.value;
        dynamic res = await _materialService.save(provider, data);
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

class MaterialFormTmp {
  String id = '';
  String code = '';
  String name = '';
  String description = '';
  String type = '';
}
