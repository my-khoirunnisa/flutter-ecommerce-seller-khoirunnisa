part of 'get_province_bloc.dart';

@freezed
class GetProvinceState with _$GetProvinceState {
  const factory GetProvinceState.initial() = _Initial;
  const factory GetProvinceState.loading() = _Loading;
  const factory GetProvinceState.loaded(List<Province> results) = _Loaded;
  const factory GetProvinceState.error(String message) = _Error;
}
