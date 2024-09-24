part of 'get_categories_bloc.dart';

@freezed
class GetCategoriesState with _$GetCategoriesState {
  const factory GetCategoriesState.initial() = _Initial;
  const factory GetCategoriesState.loading() = _Loading;
  const factory GetCategoriesState.loaded(List<Category> categories) = _Loaded;
  const factory GetCategoriesState.error(String message) = _Error;
}
