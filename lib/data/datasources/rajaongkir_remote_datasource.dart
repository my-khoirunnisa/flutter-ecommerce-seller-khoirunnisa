import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce_seller_app/core/constants/variables.dart';
import 'package:flutter_ecommerce_seller_app/data/models/city_response_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/province_response_model.dart';
import 'package:flutter_ecommerce_seller_app/data/models/subdistrict_response_model.dart';
import 'package:http/http.dart' as http;

class RajaongkirRemoteDatasource {
  Future<Either<String, ProvinceResponseModel>> getProvince() async {
    final url = Uri.parse(
        '${Variables.rajaOngkirBaseUrl}/api/province?key=${Variables.rajaOngkirKey}');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(ProvinceResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get province');
    }
  }

  Future<Either<String, CityResponseModel>> getCity(int provinceId) async {
    final url = Uri.parse(
        '${Variables.rajaOngkirBaseUrl}/api/city?key=${Variables.rajaOngkirKey}&province=$provinceId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(CityResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get city');
    }
  }

  Future<Either<String, SubdistrictResponseModel>> getSubDistrict(
      int cityId) async {
    final url = Uri.parse(
        '${Variables.rajaOngkirBaseUrl}/api/subdistrict?key=${Variables.rajaOngkirKey}&city=$cityId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get city');
    }
  }
}
