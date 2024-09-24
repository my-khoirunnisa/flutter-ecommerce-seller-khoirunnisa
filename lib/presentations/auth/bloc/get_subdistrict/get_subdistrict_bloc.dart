import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/rajaongkir_remote_datasource.dart';
import '../../../../data/models/subdistrict_response_model.dart';

part 'get_subdistrict_bloc.freezed.dart';
part 'get_subdistrict_event.dart';
part 'get_subdistrict_state.dart';

class GetSubdistrictBloc
    extends Bloc<GetSubdistrictEvent, GetSubdistrictState> {
  final RajaongkirRemoteDatasource rajaongkirRemoteDatasource;
  GetSubdistrictBloc(
    this.rajaongkirRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetSubdistrict>((event, emit) async {
      emit(const _Loading());
      final result =
          await rajaongkirRemoteDatasource.getSubDistrict(event.cityId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir!.results!)),
      );
    });
  }
}
