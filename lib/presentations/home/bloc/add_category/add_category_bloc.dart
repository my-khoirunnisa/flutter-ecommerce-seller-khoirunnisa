import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/category_remote_datasource.dart';

part 'add_category_bloc.freezed.dart';
part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  AddCategoryBloc(
    this.categoryRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddCategory>((event, emit) async {
      emit(const _Loading());
      final result = await categoryRemoteDatasource.addCategory(event.name);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
