import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:flutter_ecommerce_seller_app/data/models/request/register_request_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/auth_response_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel data) async {
    //url
    final url = Uri.parse('${Variables.baseUrl}/api/seller/register');
    //request post image
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var request = http.MultipartRequest(
        'POST', url); // Here, you need to change the url to your own url
    request.files
        .add(await http.MultipartFile.fromPath('photo', data.image.path));
    request.fields.addAll(data.toMap());
    // Here, you need to change the key to your own key
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(
          await response.stream.bytesToString()));
    } else {
      return const Left('Failed to register');
    }

    //post
    //response
  }

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to login');
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token}',
      },
    );

    if (response.statusCode == 200) {
      return const Right('Success');
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> setLiveStreaming(String title, bool isActive) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/seller/livestreaming');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token}',
      },
      body: jsonEncode({
        'title': title,
        'is_active': isActive,
      }),
    );

    if (response.statusCode == 200) {
      return const Right('Success');
    } else {
      return Left(response.body);
    }
  }
}
