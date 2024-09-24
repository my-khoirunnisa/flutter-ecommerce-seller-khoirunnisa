import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/category_remote_datasource.dart';

import '../../../../data/models/response/category_response_model.dart';

part 'get_categories_bloc.freezed.dart';
part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  GetCategoriesBloc(
    this.categoryRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetCategories>((event, emit) async{
      emit(const _Loading());
      final result = await categoryRemoteDatasource.getCategories();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });
  }
}
