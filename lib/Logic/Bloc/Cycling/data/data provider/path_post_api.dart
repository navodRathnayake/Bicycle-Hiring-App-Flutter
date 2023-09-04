library path_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PathPostApi {
  String baseUrl = domain;
  String endPoint = path['/path']!;
  PathPostApi();

  Future<Map<String, dynamic>> postPath(
      {required String bearerToken,
      required Map<String, String> reqBody}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());

      debugPrint('---> user id : ${int.parse(reqBody['user_id']!.toString())}');
      debugPrint(
          '---> bicycle id : ${int.parse(reqBody['bicycleId']!.toString())}');
      debugPrint('---> lang : ${reqBody['startLong']!.toString()}');
      debugPrint('---> long : ${reqBody['startLang']!.toString()}');
      debugPrint('---> station : ${reqBody['startLocation']!.toString()}');

      var response = await http.post(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
            'Authorization': 'Bearer $bearerToken'
          },
          body: jsonEncode({
            "user_id": int.parse(reqBody['user_id']!.toString()),
            "bicycleId": int.parse(reqBody['bicycleId']!.toString()),
            "startLong": reqBody['startLong']!.toString(),
            "startLang": reqBody['startLang']!.toString(),
            "endLong": '111',
            "endLang": '111',
            "startLocation": reqBody['startLocation']!.toString(),
            "endLocation": 'temp',
            "distance": 00.00
          }));
      debugPrint('API {path - post} - Completed');
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
