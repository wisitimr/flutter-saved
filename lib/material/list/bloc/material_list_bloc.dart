import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/material/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'material_list_event.dart';
part 'material_list_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialXState> {
  MaterialBloc(AppProvider provider)
      : _provider = provider,
        super(MaterialLoading()) {
    on<MaterialStarted>(_onStarted);
    on<MaterialSearchChanged>(_onSearchChanged);
    on<MaterialConfirm>(_onConfirm);
    on<MaterialDelete>(_onDelete);
  }

  final AppProvider _provider;
  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialStarted event, Emitter<MaterialXState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      List<MaterialModel> materials = [];
      if (_provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = _provider.companyId;
        final res = await _materialService.findAll(_provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          materials = data.map((item) => MaterialModel.fromJson(item)).toList();
        }
      }
      emit(
        state.copyWith(
          status: Status.success,
          materials: materials,
          filter: materials,
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
    MaterialSearchChanged event,
    Emitter<MaterialXState> emit,
  ) {
    emit(state.copyWith(status: Status.loading));
    var filter = event.text.isNotEmpty
        ? state.materials
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.materials;
    emit(
      state.copyWith(
        status: Status.success,
        materials: state.materials,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    MaterialConfirm event,
    Emitter<MaterialXState> emit,
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
    MaterialDelete event,
    Emitter<MaterialXState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (event.id.isNotEmpty) {
        final res = await _materialService.delete(_provider, event.id);
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
