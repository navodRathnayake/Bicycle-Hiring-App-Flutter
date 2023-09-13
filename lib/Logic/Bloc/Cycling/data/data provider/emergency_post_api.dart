library emergency_post_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmergencyPostApi {
  String baseUrl = domain;
  String endPoint = emergency['/post']!;
  EmergencyPostApi();

  Future<Map<String, dynamic>> emergencyPost(
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
            "bicycleId": reqBody['bicycleID']!.toString(),
            "emegencyStatusId": reqBody['emergencyStatusID']!.toString(),
            "lang": reqBody['lang']!.toString(),
            "long": reqBody['long']!.toString(),
            "date": reqBody['date']!.toString(),
            "time": reqBody['time']!.toString(),
            "description": reqBody['description']!.toString()
          }));
      debugPrint('API {emergency - post} - Completed');
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
