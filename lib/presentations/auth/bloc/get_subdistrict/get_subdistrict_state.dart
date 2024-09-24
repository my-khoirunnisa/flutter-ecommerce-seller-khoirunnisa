part of 'get_subdistrict_bloc.dart';

@freezed
class GetSubdistrictState with _$GetSubdistrictState {
  const factory GetSubdistrictState.initial() = _Initial;
  const factory GetSubdistrictState.loading() = _Loading;
  const factory GetSubdistrictState.loaded(List<Subdistrict> results) = _Loaded;
  const factory GetSubdistrictState.error(String message) = _Error;
}
