library service_post_dart;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServicePostApi {
  String baseUrl = domain;
  String endPoint = service['/post']!;
  ServicePostApi();

  Future<Map<String, dynamic>> postService(
      {required Map<String, String> reqBody}) async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());

      // debugPrint('---> user id : ${int.parse(reqBody['user_id']!.toString())}');
      // debugPrint(
      //     '---> bicycle id : ${int.parse(reqBody['bicycleId']!.toString())}');
      // debugPrint('---> lang : ${reqBody['startLong']!.toString()}');
      // debugPrint('---> long : ${reqBody['startLang']!.toString()}');
      // debugPrint('---> station : ${reqBody['startLocation']!.toString()}');

      var response = await http.post(url,
          headers: {
            'Content-type': 'application/vnd.api+json',
            'Accept': 'application/vnd.api+json',
          },
          body: jsonEncode({
            "bicycle_id": reqBody['bicycleID']!.toString(),
            "path_id": reqBody['pathID']!.toString(),
            "recent_activity_id": reqBody['recentActivityID']!.toString(),
            "temp_key": '1',
            "user_id": reqBody['userID']!.toString()
          }));

      debugPrint('API {service - post} - Completed');
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
