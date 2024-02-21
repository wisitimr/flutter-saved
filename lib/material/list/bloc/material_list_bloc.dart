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
    on<MaterialDeleteConfirm>(_onConfirm);
    on<MaterialDelete>(_onDelete);
  }

  final AppProvider _provider;
  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialStarted event, Emitter<MaterialXState> emit) async {
    emit(state.copyWith(status: MaterialListStatus.loading));
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
          status: MaterialListStatus.success,
          materials: materials,
          filter: materials,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MaterialListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    MaterialSearchChanged event,
    Emitter<MaterialXState> emit,
  ) {
    emit(state.copyWith(status: MaterialListStatus.loading));
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
        status: MaterialListStatus.success,
        materials: state.materials,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    MaterialDeleteConfirm event,
    Emitter<MaterialXState> emit,
  ) async {
    emit(state.copyWith(status: MaterialListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: MaterialListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MaterialListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    MaterialDelete event,
    Emitter<MaterialXState> emit,
  ) async {
    emit(state.copyWith(status: MaterialListStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _materialService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: MaterialListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: MaterialListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: MaterialListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MaterialListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
