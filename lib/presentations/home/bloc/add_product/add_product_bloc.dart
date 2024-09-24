import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/product_request_model.dart';

part 'add_product_bloc.freezed.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  AddProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddProduct>((event, emit) async{
      emit(const _Loading());
      final result = await productRemoteDatasource.addProduct(event.data);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
