import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/rajaongkir_remote_datasource.dart';
import '../../../../data/models/city_response_model.dart';

part 'get_city_bloc.freezed.dart';
part 'get_city_event.dart';
part 'get_city_state.dart';

class GetCityBloc extends Bloc<GetCityEvent, GetCityState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetCityBloc(
    this.rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetCity>((event, emit) async {
      emit(const _Loading());
      final result = await rajaongkirRemoteDatasource.getCity(event.provinceId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.rajaongkir!.results!)),
      );
    });
  }
}
