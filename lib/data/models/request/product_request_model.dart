import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  final String name;
  final String description;
  final int price;
  final int stock;
  final int categoryId;
  final XFile image;
  ProductRequestModel({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.categoryId,
  });

  

  Map<String, String> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price.toString(),
      'stock': stock.toString(),
      'category_id': categoryId.toString(),
    };
  }

  @override
  String toString() {
    return 'ProductRequestModel(name: $name, description: $description, price: $price, stock: $stock, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductRequestModel &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.stock == stock &&
        other.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        stock.hashCode ^
        image.hashCode;
  }
}
