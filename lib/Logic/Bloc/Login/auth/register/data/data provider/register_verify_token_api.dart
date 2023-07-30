library register_verify_token_api;

import 'dart:convert';

import 'package:final_project/Const/API/api_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterVerifyTokenApi {
  final Map<String, String> reqBody;

  String endPoint = register['/verify-otp']!;

  RegisterVerifyTokenApi({required this.reqBody});

  Future<Map<String, dynamic>> getRegisterRawData(
      {required String bearerToken}) async {
    // try {
    var url = Uri.http(domain, endPoint);
    debugPrint(url.toString());

    var response = await http.post(
      url,
      body: jsonEncode({
        "email": reqBody['email'].toString(),
        "otp": reqBody['otp'].toString()
      }),
      headers: {
        'Content-type': 'application/vnd.api+json',
        'Accept': 'application/vnd.api+json',
        'Authorization': 'Bearer $bearerToken'
      },
    );

    debugPrint('API {Verify Token} - Completed');
    debugPrint(response.body);

    return {
      'status': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };
    // } catch (e) {
    //   return {'error': e.toString()};
    // }
  }
}
