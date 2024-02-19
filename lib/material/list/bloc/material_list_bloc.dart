import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/material/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'material_list_event.dart';
part 'material_list_state.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialXState> {
  MaterialBloc() : super(MaterialLoading()) {
    on<MaterialStarted>(_onStarted);
    on<MaterialSearchChanged>(_onSearchChanged);
  }

  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialStarted event, Emitter<MaterialXState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final AppProvider provider = event.provider;
      List<MaterialModel> materials = [];
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final res = await _materialService.findAll(provider, param);
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
}
