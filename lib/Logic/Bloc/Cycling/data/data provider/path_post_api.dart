library path_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PathPostApi {
  String baseUrl = domain;
  String endPoint = path['/path']!;
  PathPostApi();

  Future<Map<String, dynamic>> postTransactionData(
      {required String bearerToken,
      required Map<String, String> reqBody}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());

      var response = await http.post(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({
            "user_id": reqBody['userID'].toString(),
            "bicycleId": reqBody['bicycleId'].toString(),
            "startLong": reqBody['startLong'].toString(),
            "startLang": reqBody['startLang'].toString(),
            "endLong": 'temp',
            "endLang": 'temp',
            "startLocation": reqBody['startLocation'],
            "endLocation": 'temp',
            "distance": 00.00
          }));
      debugPrint('API {transaction - post} - Completed');
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
