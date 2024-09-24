import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:flutter_ecommerce_seller_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/product_request_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/update_product_request_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/add_product_response_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/products_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductsResponseModel>> getProducts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/seller/products');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.data!.token}',
    };
    final response = await http.get(
      url,
      headers: header,
    );

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get products');
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel data) async {
    final url = Uri.parse('${Variables.baseUrl}/api/seller/products');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.data!.token}',
    };
    var response = http.MultipartRequest(
      'POST',
      url,
    );

    response.files
        .add(await http.MultipartFile.fromPath('image', data.image.path));
    response.fields.addAll(data.toMap());

    response.headers.addAll(header);

    var result = await response.send();

    if (result.statusCode == 201) {
      return Right(AddProductResponseModel.fromJson(
          await result.stream.bytesToString()));
    } else {
      return const Left('Failed to add product');
    }
  }

  Future<Either<String, AddProductResponseModel>> updateProduct(
      UpdateProductRequestModel data) async {
    final url =
        Uri.parse('${Variables.baseUrl}/api/seller/products/${data.id}');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.data!.token}',
    };
    var response = http.MultipartRequest(
      'POST',
      url,
    );

    if (data.image != null) {
      response.files
          .add(await http.MultipartFile.fromPath('image', data.image!.path));
    }

    response.fields.addAll(data.toMap());

    response.headers.addAll(header);

    var result = await response.send();

    if (result.statusCode == 200) {
      return Right(AddProductResponseModel.fromJson(
          await result.stream.bytesToString()));
    } else {
      return const Left('Failed to add product');
    }
  }

  //delete product
  Future<Either<String, String>> deleteProduct(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/seller/products/$id');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.data!.token}',
    };
    final response = await http.delete(
      url,
      headers: header,
    );

    if (response.statusCode == 200) {
      return const Right('Product deleted');
    } else {
      return const Left('Failed to delete product');
    }
  }
}
