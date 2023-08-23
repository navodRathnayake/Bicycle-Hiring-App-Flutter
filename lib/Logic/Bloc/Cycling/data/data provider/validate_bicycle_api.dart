library validate_bicycle_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ValidateBicycleApi {
  String baseUrl = domain;
  String endPoint = bicycle['/bicycle']!;
  ValidateBicycleApi();

  Future<Map<String, dynamic>> getBicycleData(
      {required String bearerToken, required bicycleID}) async {
    try {
      String tail = endPoint + bicycleID;
      var url = Uri.http(domain, tail);

      debugPrint(url.toString());
      var response = await http.get(
        url,
        headers: {
          'Content-type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $bearerToken'
        },
      );
      debugPrint('API {bicycle} - Completed');
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
