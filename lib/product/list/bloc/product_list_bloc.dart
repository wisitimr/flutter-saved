import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/product/list/models/models.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<ProductStarted>(_onStarted);
    on<ProductPageSizeChanged>(_onPageSizeChanged);
  }

  final ProductService _productService = ProductService();

  Future<void> _onStarted(
      ProductStarted event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final AppProvider provider = event.provider;
      List<ProductModel> products = [];
      if (provider.companyId.isNotEmpty) {
        Map<String, dynamic> param = {};
        param['company'] = provider.companyId;
        final res = await _productService.findAll(provider, param);
        if (res['statusCode'] == 200) {
          List data = res['data'];
          products = data.map((item) => ProductModel.fromJson(item)).toList();
        }
      }
      emit(ProductState(
        products: products,
      ));
    } catch (e) {
      emit(ProductError());
    }
  }

  void _onPageSizeChanged(
    ProductPageSizeChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(
      state.copyWith(
        pageSize: event.pageSize,
      ),
    );
  }
}
