import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/seller/categories');
    final header = {
      'Authorization': 'Bearer ${authData.data!.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      url,
      headers: header,
    );

    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> addCategory(String name) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/seller/category');
    final header = {
      'Authorization': 'Bearer ${authData.data!.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: header,
      body: jsonEncode({
        'name': name,
        'description': name,
      }),
    );

    if (response.statusCode == 201) {
      return const Right('Success');
    } else {
      return Left(response.body);
    }
  }
}
