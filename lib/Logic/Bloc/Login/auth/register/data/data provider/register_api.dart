library register_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterApi {
  String baseUrl = domain;
  String endPoint = nodes['/register']!;
  final Map<String, String> reqBody;
  RegisterApi({required this.reqBody});

  Future<Map<String, dynamic>> getRegisterRawData() async {
    try {
      var url = Uri.https(baseUrl, endPoint);
      debugPrint(url.toString());
      var response = await http.post(url, body: {
        "name": reqBody['name'],
        "email": reqBody['email'],
        "password": reqBody['password'],
        "password_confirmation": reqBody['comfirmPassword'],
      });
      debugPrint('API - Completed');
      debugPrint(response.body);
      return {
        'status': response.statusCode,
        'body': response.body,
        'headers': response.headers,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
