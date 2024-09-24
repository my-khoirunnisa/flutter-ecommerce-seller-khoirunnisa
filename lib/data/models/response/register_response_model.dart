import 'dart:convert';

class RegisterResponseModel {
    final String? status;
    final String? message;
    final Data? data;

    RegisterResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory RegisterResponseModel.fromJson(String str) => RegisterResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterResponseModel.fromMap(Map<String, dynamic> json) => RegisterResponseModel(
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
    final String? name;
    final String? email;
    final String? phone;
    final String? address;
    final String? country;
    final String? province;
    final String? city;
    final String? district;
    final String? postalCode;
    final String? roles;
    final String? photo;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Data({
        this.name,
        this.email,
        this.phone,
        this.address,
        this.country,
        this.province,
        this.city,
        this.district,
        this.postalCode,
        this.roles,
        this.photo,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        country: json["country"],
        province: json["province"],
        city: json["city"],
        district: json["district"],
        postalCode: json["postal_code"],
        roles: json["roles"],
        photo: json["photo"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "country": country,
        "province": province,
        "city": city,
        "district": district,
        "postal_code": postalCode,
        "roles": roles,
        "photo": photo,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
