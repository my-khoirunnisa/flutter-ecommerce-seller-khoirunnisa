import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/product_remote_datasource.dart';

part 'delete_product_bloc.freezed.dart';
part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  DeleteProductBloc(
    this.productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_DeleteProduct>((event, emit) async {
      emit(const _Loading());
      final result = await productRemoteDatasource.deleteProduct(
        event.id,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
