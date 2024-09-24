import 'package:image_picker/image_picker.dart';

class UpdateProductRequestModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final int categoryId;
  XFile? image;
  UpdateProductRequestModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.categoryId,
    this.image,
  });

  Map<String, String> toMap() {
    return {
      'id': id.toString(),
      'name': name,
      'description': description,
      'price': price.toString(),
      'stock': stock.toString(),
      'category_id': categoryId.toString(),
    };
  }
}
