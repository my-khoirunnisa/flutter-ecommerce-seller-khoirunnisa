import 'dart:convert';

class AddProductResponseModel {
    final String? status;
    final String? message;
    final Data? data;

    AddProductResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddProductResponseModel.fromJson(String str) => AddProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddProductResponseModel.fromMap(Map<String, dynamic> json) => AddProductResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    final int? sellerId;
    final String? categoryId;
    final String? name;
    final String? description;
    final String? price;
    final String? stock;
    final String? image;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.sellerId,
        this.categoryId,
        this.name,
        this.description,
        this.price,
        this.stock,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        sellerId: json["seller_id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "seller_id": sellerId,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
