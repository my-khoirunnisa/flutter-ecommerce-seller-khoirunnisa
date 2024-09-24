part of 'get_city_bloc.dart';

@freezed
class GetCityState with _$GetCityState {
  const factory GetCityState.initial() = _Initial;
  const factory GetCityState.loading() = _Loading;
  const factory GetCityState.loaded(List<City> results) = _Loaded;
  const factory GetCityState.error(String message) = _Error;
}
