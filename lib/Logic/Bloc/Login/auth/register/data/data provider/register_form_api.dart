library register_form_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterFormApi {
  // String baseUrl = '192.168.1.161:8000';
  String endPoint = register['/register']!;
  final Map<String, String> reqBody;
  RegisterFormApi({required this.reqBody});

  Map<String, String>? requestHeaders = {
    'Content-type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json',
    'Authorization': ''
  };

  Future<Map<String, dynamic>> getRegisterRawData() async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(reqBody.toString());
      debugPrint(url.toString());
      var response = await http.post(
        url,
        body: jsonEncode({
          'email': reqBody['email'].toString(),
          'password': reqBody['password'].toString(),
          'password_confirmation': reqBody['comfirmPassword'].toString()
        }),
        headers: requestHeaders!,
      );
      debugPrint('API {register} - Completed');
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
