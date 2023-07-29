library register_verify_token_api;

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterVerifyTokenApi {
  String baseUrl = '192.168.1.161:8000';
  String endPoint = register['/verify-otp']!;
  final Map<String, String> reqBody;
  RegisterVerifyTokenApi({required this.reqBody});

  Future<Map<String, dynamic>> getRegisterRawData() async {
    try {
      var url = Uri.https(baseUrl, endPoint);
      debugPrint(url.toString());
      var response = await http.post(url, body: {
        "email": reqBody['email'],
        "otp": reqBody['otp'],
      });
      debugPrint('API {Verify Token} - Completed');
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
