import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/product/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(AppProvider provider)
      : _provider = provider,
        super(ProductLoading()) {
    on<ProductStarted>(_onStarted);
    on<ProductSearchChanged>(_onSearchChanged);
    on<ProductDeleteConfirm>(_onConfirm);
    on<ProductDelete>(_onDelete);
  }

  final AppProvider _provider;
  final ProductService _productService = ProductService();

  Future<void> _onStarted(
      ProductStarted event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      List<ProductModel> products = [];
      if (_provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = _provider.companyId;
        final res = await _productService.findAll(_provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          products = data.map((item) => ProductModel.fromJson(item)).toList();
        }
      }
      emit(
        state.copyWith(
          status: ProductListStatus.success,
          products: products,
          filter: products,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ProductListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    ProductSearchChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(status: ProductListStatus.loading));
    var filter = event.text.isNotEmpty
        ? state.products
            .where(
              (item) =>
                  item.code.toLowerCase().contains(event.text.toLowerCase()) ||
                  item.name.toLowerCase().contains(event.text.toLowerCase()),
            )
            .toList()
        : state.products;
    emit(
      state.copyWith(
        status: ProductListStatus.success,
        products: state.products,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    ProductDeleteConfirm event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: ProductListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ProductListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    ProductDelete event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _productService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: ProductListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ProductListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: ProductListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
