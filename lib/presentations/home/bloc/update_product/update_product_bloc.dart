import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/update_product_request_model.dart';

part 'update_product_bloc.freezed.dart';
part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  UpdateProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_UpdateProduct>((event, emit) async{
      emit(const _Loading());
      final result = await productRemoteDatasource.updateProduct(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
