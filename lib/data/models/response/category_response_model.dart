import 'dart:convert';

class CategoryResponseModel {
  final String? status;
  final String? message;
  final List<Category>? data;

  CategoryResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryResponseModel.fromJson(String str) =>
      CategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      CategoryResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Category>.from(
                json["data"]!.map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Category {
  final int? id;
  final int? sellerId;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.sellerId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        sellerId: json["seller_id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "seller_id": sellerId,
        "name": name,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return '$name';
  }
}
