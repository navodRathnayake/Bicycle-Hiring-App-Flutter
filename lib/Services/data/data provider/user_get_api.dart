library user_get_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserGetApi {
  String baseUrl = domain;
  String endPoint = user['/user']!;
  UserGetApi();

  Future<Map<String, dynamic>> getUserData(
      {required String bearerToken, required String userId}) async {
    try {
      String modifiedEndPoint = endPoint + userId;
      var url = Uri.http(domain, modifiedEndPoint);

      debugPrint(url.toString());
      var response = await http.get(
        url,
        headers: {
          'Content-type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $bearerToken'
        },
      );
      debugPrint('API {user} - Completed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      debugPrint(bearerToken);
      return {
        'status': response.statusCode,
        'body': response.body,
        'headers': response.headers
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
