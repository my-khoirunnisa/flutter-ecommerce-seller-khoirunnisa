part of 'add_category_bloc.dart';

@freezed
class AddCategoryState with _$AddCategoryState {
  const factory AddCategoryState.initial() = _Initial;
  const factory AddCategoryState.loading() = _Loading;
  const factory AddCategoryState.loaded() = _Loaded;
  const factory AddCategoryState.error(String message) = _Error;
}
