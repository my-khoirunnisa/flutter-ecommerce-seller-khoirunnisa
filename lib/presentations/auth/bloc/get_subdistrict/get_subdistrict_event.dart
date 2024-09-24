part of 'get_subdistrict_bloc.dart';

@freezed
class GetSubdistrictEvent with _$GetSubdistrictEvent {
  const factory GetSubdistrictEvent.started() = _Started;
  const factory GetSubdistrictEvent.getSubdistrict(int cityId) = _GetSubdistrict;


}