import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class AgoraRemoteDatasource {
  Future<Either<String, String>> getToken(
      String channel, String uid, String role) async {
    final url = Uri.parse('${Variables.baseUrl}/api/agora/token');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData.data!.token}',
    };
    final response = await http.post(
      url,
      headers: header,
      body: jsonEncode({
        'channelName': channel,
        'uid': uid,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body)['token']);
    } else {
      return const Left('Failed to get token');
    }
  }
}
