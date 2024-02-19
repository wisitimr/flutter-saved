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
    on<MaterialPageSizeChanged>(_onPageSizeChanged);
  }

  final MaterialService _materialService = MaterialService();

  Future<void> _onStarted(
      MaterialStarted event, Emitter<MaterialXState> emit) async {
    emit(MaterialLoading());
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
      emit(MaterialXState(
        materials: materials,
      ));
    } catch (e) {
      emit(MaterialError());
    }
  }

  void _onPageSizeChanged(
    MaterialPageSizeChanged event,
    Emitter<MaterialXState> emit,
  ) {
    emit(
      state.copyWith(
        pageSize: event.pageSize,
      ),
    );
  }
}
