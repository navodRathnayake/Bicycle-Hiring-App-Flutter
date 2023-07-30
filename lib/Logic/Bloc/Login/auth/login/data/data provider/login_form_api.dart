library login_form_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginFormApi {
  String baseUrl = domain;
  String endPoint = auth['/login']!;
  final Map<String, String> reqBody;
  LoginFormApi({required this.reqBody});

  Map<String, String>? requestHeaders = {
    'Content-type': 'application/vnd.api+json',
    'Accept': 'application/vnd.api+json'
  };

  Future<Map<String, dynamic>> getLoginRawData() async {
    try {
      var url = Uri.http(domain, endPoint);

      debugPrint(url.toString());
      var response = await http.post(
        url,
        body: jsonEncode({
          'email': reqBody['email'].toString(),
          'password': reqBody['password'].toString()
        }),
        headers: requestHeaders!,
      );

      debugPrint(reqBody['email'].toString());
      debugPrint(reqBody['password']);
      debugPrint('API {login} - Completed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return {
        'status code': response.statusCode,
        'body': response.body,
        'headers': response.headers
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}
