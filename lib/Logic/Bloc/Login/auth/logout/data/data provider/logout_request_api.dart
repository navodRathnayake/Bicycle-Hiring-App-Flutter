library logout_request_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogoutRequestedApi {
  String baseUrl = domain;
  String endPoint = auth['/logout']!;
  LogoutRequestedApi();

  Future<Map<String, dynamic>> getLogoutRawData(
      {required String bearerToken}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/vnd.api+json',
          'Accept': 'application/vnd.api+json',
          'Authorization': 'Bearer $bearerToken'
        },
      );
      debugPrint('API {logout} - Completed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
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
