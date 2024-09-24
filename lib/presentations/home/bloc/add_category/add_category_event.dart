part of 'add_category_bloc.dart';

@freezed
class AddCategoryEvent with _$AddCategoryEvent {
  const factory AddCategoryEvent.started() = _Started;
  const factory AddCategoryEvent.addCategory({
    required String name,
  }) = _AddCategory;
}