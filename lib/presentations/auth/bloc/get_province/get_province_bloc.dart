import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_ecommerce_seller_app/data/datasources/rajaongkir_remote_datasource.dart';

import '../../../../data/models/province_response_model.dart';

part 'get_province_bloc.freezed.dart';
part 'get_province_event.dart';
part 'get_province_state.dart';

class GetProvinceBloc extends Bloc<GetProvinceEvent, GetProvinceState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetProvinceBloc(
    this.rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetProvince>((event, emit) async {
      emit(const _Loading());
      final result = await rajaongkirRemoteDatasource.getProvince();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir!.results!)),
      );
    });
  }
}
