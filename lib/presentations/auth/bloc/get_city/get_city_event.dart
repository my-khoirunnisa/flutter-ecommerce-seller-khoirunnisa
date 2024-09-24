part of 'get_city_bloc.dart';

@freezed
class GetCityEvent with _$GetCityEvent {
  const factory GetCityEvent.started() = _Started;
  const factory GetCityEvent.getCity(int provinceId) = _GetCity;

}