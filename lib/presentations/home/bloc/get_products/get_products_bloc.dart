import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/products_response_model.dart';

part 'get_products_bloc.freezed.dart';
part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final ProductRemoteDatasource productRemoteDatasource;
  GetProductsBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetProducts>((event, emit) async {
      emit(const _Loading());
      final result = await productRemoteDatasource.getProducts();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data ?? [])),
      );
    });
  }
}
